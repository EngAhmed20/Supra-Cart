import 'package:flutter/material.dart';
import 'package:supra_cart/core/widgets/product_card.dart';

import '../style/app_colors.dart';

class ProductList extends StatelessWidget {
  const ProductList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context,index)=> ProductCard(productImg: "https://img.freepik.com/free-photo/3d-rendering-cartoon-shopping-cart_23-2151680638.jpg?ga=GA1.1.220289254.1670056954&semt=ais_hybrid&w=740", productName: 'Product one',
          productPrice: 250,oldPrice: 300, buyNowButton: () {  }, favButton: () {  },


        ),
        separatorBuilder: (context,index)=>Container(width: 2,color: AppColors.kGreyColor,), itemCount: 10);
  }
}
