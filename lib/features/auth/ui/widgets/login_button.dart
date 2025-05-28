import 'package:flutter/material.dart';

import '../../../../core/style/app_colors.dart';
import '../../../../core/style/app_text_styles.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
    required this.loginText, this.onTap,
  });
  final String loginText;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(
          loginText,
          style: textStyle.Bold20.copyWith(
            color: AppColors.kWhiteColor,
          ),
        ),
        tileColor: AppColors.kPrimaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          color: AppColors.kWhiteColor,
          size: 30,
        ),
        onTap: onTap
    );
  }
}
