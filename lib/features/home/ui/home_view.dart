import 'package:flutter/material.dart';
import 'package:supra_cart/core/widgets/custom_search_filed.dart';

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
      ],
    );
  }
}
