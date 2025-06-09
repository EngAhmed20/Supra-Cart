import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/style/app_text_styles.dart';
import '../../../core/widgets/product_list.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Text('Your Favorite Products',style: textStyle.Bold24,textAlign: TextAlign.center,),
        SizedBox(height: 20.h,),
        /// product List view
        ProductList(),
      ],
    );

  }
}
