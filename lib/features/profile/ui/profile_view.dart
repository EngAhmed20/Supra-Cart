import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supra_cart/core/style/app_colors.dart';
import 'package:supra_cart/core/style/app_text_styles.dart';
import 'package:supra_cart/features/profile/ui/widgets/custom_profile_button.dart';
import 'package:supra_cart/features/profile/ui/widgets/edit_name_view.dart';
import 'package:supra_cart/features/profile/ui/widgets/my_orders_view.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(radius: 50,backgroundColor: AppColors.kPrimaryColor,
          child: Icon(Icons.person, size: 50, color: Colors.white),),
           SizedBox(height: 10.h),
          Text('User Name', style: textStyle.Bold19),
          SizedBox(height: 5.h),
          Text('Ahmed@gmail.com',style: textStyle.semiBold16,),
          SizedBox(height: 20.h),
          CustomProfileButton(title: 'Edit Name',icon: Icons.person,onTap: (){
            Navigator.pushNamed(context, EditNameView.routeName);
          },),
          SizedBox(height: 10.h),
          CustomProfileButton(title: 'My Orders',icon: Icons.shopping_cart,onTap: (){
            Navigator.pushNamed(context, MyOrdersView.routeName);
          },),
          SizedBox(height: 10.h,),
          CustomProfileButton(title: 'Logout',icon: Icons.logout,onTap: (){},),

        ],
      ),
    );
  }
}

