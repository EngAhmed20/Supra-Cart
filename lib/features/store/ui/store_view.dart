import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supra_cart/core/style/app_text_styles.dart';
import 'package:supra_cart/core/widgets/custom_search_filed.dart';
import '../../../core/widgets/product_list.dart';
class StoreView extends StatelessWidget {
  const  StoreView({super.key});
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
          Text('Welcome To Our Market',style: textStyle.Bold24,textAlign: TextAlign.center,),
        SizedBox(height: 20.h,),
        CustomSearchField(hintText: 'Search in Market',
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a search term';
            }
            return null;
          },
          searchAction: (){

          },),
        SizedBox(height: 20.h,),
        /// product List view
        ProductList(),
      ],
    );
  }


}




