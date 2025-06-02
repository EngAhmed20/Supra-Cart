import 'package:flutter/material.dart';
import 'package:supra_cart/core/style/app_colors.dart';

  class CustomSearchField extends StatelessWidget {
  final String hintText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final void Function()? searchAction;

  const CustomSearchField({
    Key? key,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.controller,
    this.searchAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final outlineBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: Colors.grey),
    );

    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        border: outlineBorder,
        enabledBorder: outlineBorder,
        focusedBorder: outlineBorder,
        suffixIcon:Padding(
          padding: const EdgeInsets.only(right: 5),
          child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.kPrimaryColor,
                foregroundColor: AppColors.kWhiteColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: searchAction, label: Icon(Icons.search,size: 20,)),
        )

      ),
    );
  }
}
