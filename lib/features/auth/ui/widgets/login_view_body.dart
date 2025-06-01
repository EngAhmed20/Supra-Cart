import 'package:flutter/material.dart';
import 'package:supra_cart/core/style/app_colors.dart';
import 'package:supra_cart/core/widgets/custom_text_form.dart';
import 'package:supra_cart/features/auth/ui/forget_pass_view.dart';
import 'package:supra_cart/features/auth/ui/sign_up_view.dart';
import 'package:supra_cart/features/home/ui/main_home_view.dart';

import '../../../../core/style/app_text_styles.dart';
import 'login_button.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
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
                  const SizedBox(height: 15,),
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, ForgetPassView.routeName);
                      },
                      child: Text('Forgot Password?',
                        style: textStyle.semiBold16.copyWith(
                          color: AppColors.kPrimaryColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30,),
                  LoginButton(loginText: 'Login',onTap: (){
                    Navigator.pushNamed(context, MainHomeView.routeName);
                  },),
                  const SizedBox(height: 25,),
                  LoginButton(loginText: 'Login With Google',onTap: (){},),
                  const SizedBox(height: 40,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Don\'t have an account?',
                          style: textStyle.semiBold18
                      ),
                      const SizedBox(width: 5,),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, SignUpView.routeName);
                        },
                        child: InkWell(
                          child: Text('Sign Up',
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



          //Spacer(flex: 2,),

        ],

      ),
    );
  }
}

