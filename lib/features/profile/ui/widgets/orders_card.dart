import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supra_cart/core/utilis/constants.dart';
import 'package:supra_cart/features/home/logic/cubit/home_cubit/home_cubit.dart';

import '../../../../core/models/product_model.dart';
import '../../../../core/style/app_colors.dart';
import '../../../../core/style/app_text_styles.dart';
import '../../../../core/widgets/cached_img.dart';
import '../../../../core/widgets/loadibg_ink_drop.dart';
import '../../../auth/ui/widgets/custom_text_button.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({
    super.key,
    required this.productModel,
   required this.cancelOrder,
    this.onTap,
    required this.orderStatus, required this.confirmReceipt,required this.archiveOrder,
  });
  final ProductModel productModel;
  final void Function()? onTap;
  final void Function() cancelOrder;
  final void Function() confirmReceipt;
  final void Function() archiveOrder;

  final String orderStatus;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.h),
        ),
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(height: 5),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.h),
                  child: CachedImg(
                    imgUrl: productModel.imageUrl,
                    placeHolder: Container(
                      width: double.infinity,
                      height: 150.h,
                      child: Center(child: LoadingInkDrop()),
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Row(
                    children: [
                      Flexible(
                        child: Text(productModel.name, style: textStyle.Bold20),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Order Status: ',
                          style: textStyle.Bold16.copyWith(color: Colors.black),
                        ),
                        TextSpan(
                          text: orderStatus,
                          style: textStyle.Bold16.copyWith(color: Colors.blue),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 5.h),
                ListTile(
                  title: Text(
                    '${productModel.price} LE',
                    style: textStyle.Bold20,
                  ),
                  trailing:
                      orderStatus == orderStatusList[0] ||
                              orderStatus == orderStatusList[1]
                          ? CustomTextButton(
                            text: 'Cancel Order',
                            backgroundColor: AppColors.kRedColor,
                            style: textStyle.Bold19.copyWith(
                              color: AppColors.kWhiteColor,
                            ),
                            onPressed:cancelOrder,
                          )
                          : orderStatus == orderStatusList[3]
                          ? CustomTextButton(
                            text: 'Confirm Receipt',
                            style: textStyle.Bold19.copyWith(
                              color: AppColors.kWhiteColor,
                            ),
                            onPressed: confirmReceipt,
                          )
                          : orderStatus == orderStatusList[4]
                          ? CustomTextButton(
                            text: 'Archive Order',
                            backgroundColor: AppColors.kRedColor,
                            style: textStyle.Bold19.copyWith(
                              color: AppColors.kWhiteColor,
                            ),
                            onPressed: archiveOrder,
                          )
                          : null,
                  subtitle:
                      productModel.oldPrice != 0
                          ? Text(
                            '${productModel.oldPrice} LE',
                            style: textStyle.regular16.copyWith(
                              decoration: TextDecoration.lineThrough,
                            ),
                          )
                          : null,
                  contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
                ),
              ],
            ),
            if (productModel.oldPrice != 0)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
                decoration: BoxDecoration(
                  color: AppColors.kPrimaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.h),
                  ),
                ),
                child: Text(
                  '${productModel.sale} % OFF',
                  style: textStyle.semiBold16.copyWith(
                    color: AppColors.kWhiteColor,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
