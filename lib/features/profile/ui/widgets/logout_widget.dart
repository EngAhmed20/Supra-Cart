import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supra_cart/features/auth/ui/login_view.dart';
import 'package:supra_cart/features/home/logic/cubit/home_cubit/home_cubit.dart';
import '../../../../core/widgets/custom_snack_bar.dart';
import '../../../auth/logic/cubit/authentication_cubit.dart';
import 'custom_profile_button.dart';

class LogoutWidget extends StatelessWidget {
  const LogoutWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationCubit,AuthenticationState>(builder: (context,state){
      AuthenticationCubit cubit = context.read<AuthenticationCubit>();
      return CustomProfileButton(title: 'Logout',icon: Icons.logout,loading: state is AuthenticationLogoutLoading,onTap: (){
        cubit.logout();
      },);
    }, listener: (context,state){
      if (state is AuthenticationLogoutSuccess) {
        context.read<HomeCubit>().changeIndex(0);
        customSnackBar(
          context: context,
          msg: "Logout successful.",
          isError: false,
        );

        Navigator.pushNamedAndRemoveUntil(context,LoginView.routeName ,(route)=>false);


      } else if (state is AuthenticationLogoutFailure) {
        customSnackBar(
          context: context,
          msg: "Logout failed. Please try again.",
          isError: true,
        );

      }
    });
  }
}
