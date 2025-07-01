import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supra_cart/core/helper_function/dummy_product_list.dart';
import 'package:supra_cart/core/widgets/custom_app_bar.dart';
import 'package:supra_cart/core/widgets/product_card.dart';
import 'package:supra_cart/features/home/logic/cubit/home_cubit/home_cubit.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});
  static const String routeName = '/searchView';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeState>(builder: (context,state){
      return Scaffold(
        appBar: customAppBar(context, title: 'Search Result'),
        body:Padding(
          padding:  EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          child: ListView.builder(itemBuilder: (context,index)=>ProductCard(productModel:dummyProductList[index], buyNowButton:(){}, favButton: (){}),
            itemCount: dummyProductList.length,scrollDirection: Axis.vertical,shrinkWrap: true,physics: const BouncingScrollPhysics(),
          ),
        ),
      );
    }, listener: (context,state){

    });
  }
}
