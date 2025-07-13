import 'package:flutter/material.dart';

import '../../../../core/style/app_colors.dart';
import '../../../../core/style/app_text_styles.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({super.key, this.style, required this.text, this.radius, required this.onPressed, this.backgroundColor, this.verticalPadding, this.horizontalPadding});
  final String text;
  final double? radius;
  final TextStyle? style;
  final Color?backgroundColor;
  final double?verticalPadding;
  final double?horizontalPadding;
   final void Function() onPressed;



  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,

      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          backgroundColor?? AppColors.kPrimaryColor,
        ),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
           EdgeInsets.symmetric(vertical:verticalPadding?? 10, horizontal:horizontalPadding?? 10),

        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius??15),
          ),
        ),
      ),
      child: Text(
        text,
        style: style??textStyle.Bold24.copyWith(color: AppColors.kWhiteColor),
      ),
    );
  }
}
