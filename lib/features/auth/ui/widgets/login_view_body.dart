import 'package:flutter/material.dart';
import 'package:supra_cart/core/style/app_colors.dart';
import 'package:supra_cart/core/widgets/custom_text_form.dart';

import '../../../../core/style/app_text_styles.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  bool hidePass=true;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 30,),
        const Text(
          'Welcome to Supra Cart',
          style: textStyle.Bold24,

        ),
        const SizedBox(height: 25,),
        Card(
          color: AppColors.kWhiteColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: Column(
              children: [
                CustomTextFormField(hintText: 'Enter your email',
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  hintText: 'Enter your password',
                  isPassword: true,
                  obscureText: hidePass,
                  onTogglePasswordVisibility: (){
                    hidePass = !hidePass;
                    setState(() {});
                  },
                  validator: (value) {
                    if (value == null || value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),

              ],
            ),
          ),
        )
      ],

    );
  }
}
