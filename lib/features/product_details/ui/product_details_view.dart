import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supra_cart/core/style/app_colors.dart';
import 'package:supra_cart/core/style/app_text_styles.dart';
import 'package:supra_cart/core/widgets/custom_app_bar.dart';
import 'package:supra_cart/core/widgets/custom_text_form.dart';
import 'package:supra_cart/features/product_details/ui/widgets/comments_widget.dart';
import 'package:supra_cart/features/product_details/ui/widgets/product_details_widget.dart';

import '../../../core/widgets/product_img.dart';

class ProductDetailsView extends StatelessWidget {
  const ProductDetailsView({super.key});
  static const String routeName = '/productDetails';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, title: 'Product Name'),
      body: ListView(
        children: [
          ProductPicture(imgUrl:'https://img.freepik.com/free-photo/3d-rendering-cartoon-shopping-cart_23-2151680638.jpg?ga=GA1.1.220289254.1670056954&semt=ais_hybrid&w=740',),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 20.h),
            child: Column(
              children: [
                /// product details
                ProductDetails(
                  productName: 'Product Name',
                  productPrice: 250,
                  addToFavFun: () {},
                ),
                SizedBox(height: 20.h),
                /// description
                Text('Product Description', style: textStyle.regular19),
                SizedBox(height: 15.h),
                /// rating bar
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
                SizedBox(height: 20.h),
                /// feedback
                CustomTextFormField(hintText: 'Type your feedback here',
                  maxLines: 2,

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your feedback';
                    }
                    return null;
                  },
                  suffixIcon: IconButton(onPressed: (){}, icon:Icon(
                    Icons.send, color: AppColors.kGreyColor, size: 25.sp,
                  )),
                ),
                SizedBox(height: 15.h),
                ///comments
                Row(
                  children: [
                    Text('Comments', style: textStyle.Bold19),


                  ],
                ),
                SizedBox(height: 15.h),
                /// comments list
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 10,
                  itemBuilder:(context,index)=>CommentsWidget(userName: 'Ahmed',userComment: 'good and useful product',),)
              ],
            ),
          ),
        ],
      ),
    );
  }
}

