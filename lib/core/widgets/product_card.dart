import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supra_cart/core/models/product_model.dart';
import '../../../../core/style/app_colors.dart';
import '../../../../core/style/app_text_styles.dart';
import '../../../../core/widgets/cached_img.dart';
import '../../../../core/widgets/loadibg_ink_drop.dart';
import '../../features/auth/ui/widgets/custom_text_button.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key, required this.productModel, required this.buyNowButton, required this.favButton, this.onTap,
  });
  final ProductModel productModel;
  final  void Function() buyNowButton;
  final  void Function() favButton;
  final void Function()? onTap;



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.h),
        ),
        child: Stack(
          children: [
            Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.h),
                  child:CachedImg(imgUrl: productModel.imageUrl,
                    placeHolder: Container(
                        width: double.infinity,
                        height: 150.h,
                        child: Center(child: LoadingInkDrop())),
                  ),
                ),
                SizedBox(height: 10.h,),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 10.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(productModel.name,style: textStyle.Bold20,),
                      IconButton(icon:Icon(Icons.favorite,size: 25.h,color: AppColors.kGreyColor), onPressed: favButton,),
                    ],),
                ),
                ListTile(title: Text('${productModel.price} LE',style: textStyle.Bold20,),
                  trailing: CustomTextButton(text: 'Buy Now', onPressed: buyNowButton),
                  subtitle:productModel.oldPrice!=0? Text('${productModel.oldPrice} LE',style: textStyle.regular16.copyWith(
                    decoration:TextDecoration.lineThrough,),):null,
                  contentPadding: EdgeInsets.symmetric(horizontal: 10.w),

                ),

              ],
            ),
            if(productModel.oldPrice!=0)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5.w,vertical: 5.h),
                decoration: BoxDecoration(
                  color: AppColors.kPrimaryColor,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10.h)),
                ),
                child: Text('${productModel.sale} % OFF',style: textStyle.semiBold16.copyWith(color: AppColors.kWhiteColor),),
              ),
          ],

        ),
      ),
    );
  }
}
