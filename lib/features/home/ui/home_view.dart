import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supra_cart/core/style/app_text_styles.dart';
import 'package:supra_cart/core/widgets/custom_search_filed.dart';
import 'package:supra_cart/features/home/ui/widgets/popular_category_item.dart';
import '../../../core/widgets/product_list.dart';
import '../../../generated/assets.dart';
import '../logic/models/category_name_model.dart';

class HomeView extends StatelessWidget {
  const  HomeView({super.key});


  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        CustomSearchField(hintText: 'Search in Market',
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a search term';
            }
            return null;
          },
          searchAction: (){

          },),
        SizedBox(height: 30.h,),
        Image.asset(Assets.imagesBuy),
        SizedBox(height: 30.h,),
        Text('Popular Categories',style: textStyle.Bold20,),
        SizedBox(height: 20.h,),
        /// category items
        SizedBox(
          height: 120.h,
          child: ListView.builder(itemBuilder:(context,index){
           return Padding(
             padding:  EdgeInsets.symmetric(horizontal: 5.w),
             child: popular_categoryItem(categoryNameModel: categoryNames[index]),
           );
          },itemCount: categoryNames.length,scrollDirection: Axis.horizontal,),
        ),
        /// product List view
        ProductList()

      ],
    );
  }


}



