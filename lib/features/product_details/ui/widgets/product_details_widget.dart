import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/style/app_colors.dart';
import '../../../../core/style/app_text_styles.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({
    super.key, required this.productName, required this.productPrice, this.reviewRating, this.favIconColor, this.addToFavFun,
  });
  final String productName;
  final double productPrice;
  final int? reviewRating;
  final Color? favIconColor;
  final void Function()? addToFavFun;



  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            productName,
            style: textStyle.Bold20,
          ),
          Text(
            '${productPrice} \EGP',
            style: textStyle.semiBold18.copyWith(color:Colors.red),
          ),
        ],
      ),
      subtitle: Row(
        children: [
          Text(reviewRating!=null?'${reviewRating} /5':'0', style:textStyle.regular18,),
          SizedBox(width: 4),
          Icon(Icons.star, color: Colors.amber, size: 25.h),
          Spacer(), // مسافة بين التقييم وزر المفضلة
          IconButton(
            icon: Icon(Icons.favorite,size: 30.h,color:favIconColor?? AppColors.kGreyColor,),
            onPressed: addToFavFun,
          ),
        ],
      ),
    );
  }
}
