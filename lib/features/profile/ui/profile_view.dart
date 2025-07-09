import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supra_cart/features/home/logic/cubit/home_cubit/home_cubit.dart';
import 'package:supra_cart/features/profile/ui/widgets/custom_profile_button.dart';
import 'package:supra_cart/features/profile/ui/widgets/logout_widget.dart';
import 'package:supra_cart/features/profile/ui/widgets/my_orders_view.dart';
import 'package:supra_cart/features/profile/ui/widgets/user_profile_info.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          UserProfileInfo(),

          SizedBox(height: 10.h),
          CustomProfileButton(title: 'My Orders',icon: Icons.shopping_cart,onTap: (){
            context.read<HomeCubit>().getPurchaseProducts();

            Navigator.pushNamed(context, MyOrdersView.routeName);
          },),
          SizedBox(height: 10.h,),
          LogoutWidget(),

        ],
      ),
    );
  }
}


