import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supra_cart/features/auth/logic/cubit/authentication_cubit.dart';

import '../../../../core/style/app_colors.dart';
import '../../../../core/style/app_text_styles.dart';
import 'custom_profile_button.dart';
import 'edit_name_view.dart';

class UserProfileInfo extends StatelessWidget {
  const UserProfileInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationCubit,AuthenticationState>(
      builder: (context,state){
        var cubit= context.read<AuthenticationCubit>();
        return Column(
          children: [
            CircleAvatar(radius: 50,backgroundColor: AppColors.kPrimaryColor,
              child: Icon(Icons.person, size: 50, color: Colors.white),),
            SizedBox(height: 10.h),
            Text(cubit.userSavedDataModel.name!, style: textStyle.Bold19),
            SizedBox(height: 5.h),
            Text(cubit.userSavedDataModel.email!,style: textStyle.semiBold16,),
            SizedBox(height: 20.h),
            CustomProfileButton(title: 'Edit Name',icon: Icons.person,onTap: (){
              Navigator.pushNamed(context, EditNameView.routeName);
            },),

          ],
        );
      },listener: (context,state){

    },
    );
  }
}
