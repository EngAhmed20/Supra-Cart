import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final bool isPassword;
  final bool obscureText;
  final TextEditingController? controller;
  final VoidCallback? onTogglePasswordVisibility;

  const CustomTextFormField({
    Key? key,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.isPassword = false,
    this.obscureText = false,
    this.controller,
    this.onTogglePasswordVisibility,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final outlineBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Colors.grey),
    );

    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        border: outlineBorder,
        enabledBorder: outlineBorder,
        focusedBorder: outlineBorder,
        suffixIcon:
            isPassword
                ? IconButton(
                  icon: Icon(
                    obscureText ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: onTogglePasswordVisibility,
                )
                : null,
      ),
    );
  }
}
