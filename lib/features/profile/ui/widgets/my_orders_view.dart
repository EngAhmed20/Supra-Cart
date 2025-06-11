import 'package:flutter/material.dart';
import 'package:supra_cart/core/widgets/custom_app_bar.dart';
import 'package:supra_cart/core/widgets/product_list.dart';
class MyOrdersView extends StatelessWidget {
  const MyOrdersView({super.key});
  static const String routeName = '/myOrders';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, title: 'My Orders'),
      body: ProductList(shrinkWrap: false,physics: BouncingScrollPhysics(),),
    );
  }
}
