import 'package:flutter/material.dart';

import '../style/app_colors.dart';
import '../style/app_text_styles.dart';

AppBar customAppBar(BuildContext context,{required String title}) {
  return AppBar(
    title:  Text(title,style: textStyle.Bold26.copyWith(color: AppColors.kWhiteColor),),
    centerTitle: true,
    backgroundColor: AppColors.kPrimaryColor,
    leading: IconButton(
      icon: const Icon(Icons.arrow_back_ios,color: Colors.white,size: 30,),
      onPressed: () => Navigator.pop(context),
    ),

  );
}
