import 'package:flutter/material.dart';
import 'package:supra_cart/core/style/app_colors.dart';
import 'package:supra_cart/core/style/app_text_styles.dart';
import 'package:supra_cart/core/widgets/custom_text_form.dart';
import 'package:supra_cart/features/auth/ui/widgets/custom_text_button.dart';

class ForgetPassView extends StatelessWidget {
  const ForgetPassView({super.key});
  static const String routeName = '/forget-pass';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Forget Password', style: textStyle.Bold24),
            const SizedBox(height: 20),
            Text(
              'Please enter your email to reset your password.',
              textAlign: TextAlign.center,
              style: textStyle.regular16,
            ),
            const SizedBox(height: 20),
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
            CustomTextButton(text: 'Send', onPressed: (){}),
          ],
        ),
      ),
    );
  }
}
