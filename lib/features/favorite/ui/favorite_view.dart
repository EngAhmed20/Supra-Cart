import 'package:flutter/material.dart';
import '../../../core/style/app_text_styles.dart';
import '../../../core/widgets/product_list.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites', style: textStyle.Bold24),
        centerTitle: true,
        backgroundColor:Colors.transparent,

      ),
      body:ProductList(showFavProduct: true,physics: BouncingScrollPhysics(),),
    );

  }
}
