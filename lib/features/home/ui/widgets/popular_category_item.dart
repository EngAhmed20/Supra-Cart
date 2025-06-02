import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/style/app_colors.dart';
import '../../../../core/style/app_text_styles.dart';
import '../../logic/models/category_name_model.dart';

Column popular_categoryItem({required CategoryNameModel categoryNameModel}) {
  return Column(
    children: [
      CircleAvatar(
        radius: 30.r,
        backgroundColor:AppColors.kPrimaryColor,
        child: Icon(categoryNameModel.icon,color: AppColors.kWhiteColor,size: 40.h,),
      ),
      const SizedBox(height: 10,),
      Text(categoryNameModel.name,style: textStyle.semiBold18,),
    ],
  );
}
