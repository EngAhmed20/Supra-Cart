import 'package:flutter/material.dart';

import '../../../../core/style/app_colors.dart';
import '../../../../core/style/app_text_styles.dart';
import '../../../../core/widgets/custom_text_form.dart';
import 'login_button.dart';

class SignupViewBody extends StatefulWidget {
  const SignupViewBody({super.key});

  @override
  State<SignupViewBody> createState() => _SignupViewBodyState();
}

class _SignupViewBodyState extends State<SignupViewBody> {
  bool hidePass=true;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 30,),
          const Text(
            'Welcome to Supra Cart',
            style: textStyle.Bold24,

          ),
          SizedBox(height: MediaQuery.of(context).size.height*.09,),
          Card(
            margin: EdgeInsets.zero,
            color: AppColors.kWhiteColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextFormField(hintText: 'Enter your name',
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 25),
                  CustomTextFormField(hintText: 'Enter your email',
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 25),
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

                  const SizedBox(height: 30,),
                  LoginButton(loginText: 'Sign Up',onTap: (){},),
                  const SizedBox(height: 25,),
                  LoginButton(loginText: 'Sign Up With Google',onTap: (){},),
                  const SizedBox(height: 40,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Already have an account?',
                          style: textStyle.semiBold18
                      ),
                      const SizedBox(width: 5,),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: InkWell(
                          child: Text('Login',
                            style: textStyle.semiBold18.copyWith(
                              color: AppColors.kPrimaryColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),




        ],

      ),
    );
  }
}
