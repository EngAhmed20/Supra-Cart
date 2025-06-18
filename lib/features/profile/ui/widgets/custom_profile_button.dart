import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supra_cart/core/widgets/loadibg_ink_drop.dart';

import '../../../../core/style/app_colors.dart';
import '../../../../core/style/app_text_styles.dart';

class CustomProfileButton extends StatelessWidget {
  const CustomProfileButton({
    super.key, required this.title, required this.icon, this.onTap, this.loading=false,
  });
  final String title;
  final IconData icon;
  final bool loading;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon,color: AppColors.kWhiteColor,size: 30,),
      title: loading?LoadingInkDrop(dropColor: AppColors.kWhiteColor):Text(title,textAlign: TextAlign.center, style: textStyle.Bold20),
      textColor: AppColors.kWhiteColor,
      trailing: const Icon(Icons.arrow_forward_ios,color: AppColors.kWhiteColor,size: 30,),
      tileColor: AppColors.kPrimaryColor,
      contentPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      onTap:onTap,
    );
  }
}
