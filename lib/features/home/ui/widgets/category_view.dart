import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supra_cart/core/widgets/custom_app_bar.dart';
import 'package:supra_cart/core/widgets/product_list.dart';
import 'package:supra_cart/features/home/logic/cubit/home_cubit/home_cubit.dart';

class CategoryView extends StatelessWidget {
  const CategoryView({super.key, required this.categoryName});
  static const String routeName = '/categoryView';
  final String categoryName;

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: customAppBar(context, title: categoryName,onPressed: ()async{
        await context.read<HomeCubit>().clear();
        Navigator.pop(context);
      }),
      body:Padding(
        padding:  EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        child: ProductList(physics: BouncingScrollPhysics(),),
      ),
    );


  }
}

