import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supra_cart/core/style/app_text_styles.dart';
import 'package:supra_cart/core/widgets/cached_img.dart';
import 'package:supra_cart/core/widgets/custom_app_bar.dart';
import 'package:supra_cart/features/product_details/ui/widgets/product_details_widget.dart';

import '../../../core/widgets/loadibg_ink_drop.dart';

class ProductDetailsView extends StatelessWidget {
  const ProductDetailsView({super.key});
  static const String routeName = '/productDetails';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, title: 'Product Name'),
      body: ListView(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10.r),
              bottomRight: Radius.circular(10.r),
            ),
            child: CachedImg(
              imgUrl:
                  'https://img.freepik.com/free-photo/3d-rendering-cartoon-shopping-cart_23-2151680638.jpg?ga=GA1.1.220289254.1670056954&semt=ais_hybrid&w=740',
              placeHolder: Container(
                width: double.infinity,
                height: 150.h,
                child: Center(child: LoadingInkDrop()),
              ),
            ),
          ),
          SizedBox(height: 20.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Column(
              children: [
                ProductDetails(
                  productName: 'Product Name',
                  productPrice: 250,
                  addToFavFun: () {},
                ),
                SizedBox(height: 20.h),
                Text('Product Description', style: textStyle.regular19),
                SizedBox(height: 20.h),
                RatingBar.builder(
                  initialRating: 0,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder:
                      (context, _) => Icon(Icons.star, color: Colors.amber),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
