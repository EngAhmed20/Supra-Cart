import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:supra_cart/core/style/app_text_styles.dart';
import 'package:supra_cart/core/widgets/loadibg_ink_drop.dart';
import 'package:supra_cart/core/widgets/product_card.dart';
import 'package:supra_cart/features/home/logic/cubit/home_cubit/home_cubit.dart';

import '../helper_function/dummy_product_list.dart';
import '../style/app_colors.dart';

class ProductList extends StatelessWidget {
  const ProductList({
    super.key, this.shrinkWrap, this.physics,
  });
  final bool? shrinkWrap;
  final ScrollPhysics? physics;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeState>(builder: (context,state){
      var cubit= context.read<HomeCubit>();
      if (state is GetHomeProductsLoading) {
        return Skeletonizer(child: ListView.separated(
            shrinkWrap:shrinkWrap?? true,
            physics: physics??NeverScrollableScrollPhysics(),
            itemBuilder: (context,index)=> ProductCard(productModel:dummyProductList[index], buyNowButton: () {  }, favButton: () {  },


            ),
            separatorBuilder: (context,index)=>Container(width: 5.h,color: AppColors.kGreyColor,), itemCount: dummyProductList.length),

        );
      } else if (state is GetHomeProductsFailure) {
        return Center(child: Text(state.errorMessage,style: textStyle.Bold16,));
      }
      return ListView.separated(
          shrinkWrap:shrinkWrap?? true,
          physics: physics??NeverScrollableScrollPhysics(),
          itemBuilder: (context,index)=> ProductCard(productModel:cubit.homeProducts[index], buyNowButton: () {  }, favButton: () {  },),
          separatorBuilder: (context,index)=>Container(width: 5.h,color: AppColors.kGreyColor,), itemCount: cubit.homeProducts.length);
    }, listener: (context,state){

    });
  }
}
