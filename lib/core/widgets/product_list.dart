import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supra_cart/core/widgets/product_card.dart';

import '../style/app_colors.dart';

class ProductList extends StatelessWidget {
  const ProductList({
    super.key, this.shrinkWrap, this.physics,
  });
  final bool? shrinkWrap;
  final ScrollPhysics? physics;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap:shrinkWrap?? true,
        physics: physics??NeverScrollableScrollPhysics(),
        itemBuilder: (context,index)=> ProductCard(productImg: "https://img.freepik.com/free-photo/3d-rendering-cartoon-shopping-cart_23-2151680638.jpg?ga=GA1.1.220289254.1670056954&semt=ais_hybrid&w=740", productName: 'Product one',
          productPrice: 250,oldPrice: 300, buyNowButton: () {  }, favButton: () {  },


        ),
        separatorBuilder: (context,index)=>Container(width: 5.h,color: AppColors.kGreyColor,), itemCount: 10);
  }
}
