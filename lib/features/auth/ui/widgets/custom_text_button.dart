import 'package:flutter/material.dart';

import '../../../../core/style/app_colors.dart';
import '../../../../core/style/app_text_styles.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({super.key, required this.text, this.radius, required this.onPressed});
  final String text;
  final double? radius;
   final void Function() onPressed;



  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,

      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          AppColors.kPrimaryColor,
        ),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          const EdgeInsets.symmetric(vertical: 5, horizontal: 15),

        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius??15),
          ),
        ),
      ),
      child: Text(
        text,
        style: textStyle.Bold24.copyWith(color: AppColors.kWhiteColor),
      ),
    );
  }
}
