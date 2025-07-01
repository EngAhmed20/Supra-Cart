import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supra_cart/core/models/product_model.dart';
import 'package:supra_cart/core/style/app_text_styles.dart';
import 'package:supra_cart/core/widgets/custom_app_bar.dart';
import 'package:supra_cart/core/widgets/custom_snack_bar.dart';
import 'package:supra_cart/core/widgets/loadibg_ink_drop.dart';
import 'package:supra_cart/features/home/logic/cubit/home_cubit/home_cubit.dart';
import 'package:supra_cart/features/product_details/ui/widgets/feedback_view.dart';
import 'package:supra_cart/features/product_details/ui/widgets/product_details_widget.dart';

import '../../../core/widgets/product_img.dart';

class ProductDetailsView extends StatelessWidget {
  const ProductDetailsView({super.key, required this.product});
  static const String routeName = '/productDetails';
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeState>(
        builder: (context,state){
          var cubit = context.read<HomeCubit>();
          if (state is GetProductRateLoading) {
            return Scaffold(
              appBar: customAppBar(context, title: product.name),
              body: Center(child: LoadingInkDrop()),
            );
          }
          else if (state is GetProductRateFailure) {
            return Scaffold(
              appBar: customAppBar(context, title: product.name),
              body: Center(child: Text(state.errorMessage, style: textStyle.Bold16)),
            );
          }
          return Scaffold(
            appBar: customAppBar(context, title: product.name),
            body: ListView(
              children: [
                ProductPicture(imgUrl:product.imageUrl),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 20.h),
                  child: Column(
                    children: [
                      /// product details
                      ProductDetails(
                        productName: product.name,
                        productPrice: product.price,
                        reviewRating: cubit.avgRate,
                        addToFavFun: (){},
                      ),
                      SizedBox(height: 20.h),
                      /// description
                      Text(product.description, style: textStyle.regular19),
                      SizedBox(height: 15.h),
                      /// rating bar
                      RatingBar.builder(
                        initialRating: cubit.userRate.toDouble(),
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: false,
                        itemCount: 5,
                        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder:
                            (context, _) => Icon(Icons.star, color: Colors.amber),
                        onRatingUpdate: (rating) {
                          cubit.addOrUpdateUserRate(productId:product.id ,rate: rating.toInt());
                        },
                      ),
                      SizedBox(height: 20.h),
                      /// feedback
                      FeedbackView(cubit: cubit,productId:product.id ,),
                    ],
                  ),
                ),
              ],
            ),
          );
    }, listener: (context,state){
      if (state is AddOrUpdateUserRateSuccess) {
        customSnackBar(context: context, msg: 'Rating added successfully.', isError: false);
      }
      else if (state is AddOrUpdateUserRateFailure) {
        customSnackBar(context: context, msg:'An error occurred.Please try again later.', isError: true);
      }
      else if (state is AddCommentSuccess){
        customSnackBar(context: context, msg: 'Comment added successfully.', isError: false);
      }
      else if (state is AddCommentFailure){
        customSnackBar(context: context, msg:'An error occurred.Please try again later.', isError: true);
      }
    });
  }
}

