import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supra_cart/core/helper_function/validators.dart';
import 'package:supra_cart/core/style/app_colors.dart';
import 'package:supra_cart/core/widgets/custom_text_form.dart';
import 'package:supra_cart/core/widgets/loadibg_ink_drop.dart';
import 'package:supra_cart/features/auth/logic/cubit/authentication_cubit.dart';
import 'package:supra_cart/features/auth/ui/forget_pass_view.dart';
import 'package:supra_cart/features/auth/ui/sign_up_view.dart';

import '../../../../core/style/app_text_styles.dart';
import '../../../../core/widgets/custom_snack_bar.dart';
import 'login_button.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      builder: (context, state) {
        AuthenticationCubit cubit = context.read<AuthenticationCubit>();
        return state is AuthenticationLoginLoading ||state is AuthenticationGoogleSignInLoading
            ? Loading_body(context)
            : SingleChildScrollView(
              child: Form(
                key: cubit.loginFormKey,
                autovalidateMode: cubit.autovalidateMode,
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    Text('Welcome to Supra Cart', style: textStyle.Bold24),
                    SizedBox(height: MediaQuery.of(context).size.height * .09),
                    Card(
                      margin: EdgeInsets.zero,
                      color: AppColors.kWhiteColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 30,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomTextFormField(
                              hintText: 'Enter your email',
                              keyboardType: TextInputType.emailAddress,
                              controller: cubit.loginEmailController,
                              validator: (value) {
                              return FormValidators.validateEmail(value);
                              },
                            ),
                            const SizedBox(height: 25),
                            CustomTextFormField(
                              hintText: 'Enter your password',
                              isPassword: true,
                              controller: cubit.loginPasswordController,
                              obscureText: cubit.hidePass,
                              onTogglePasswordVisibility: () {
                                cubit.changePasswordVisibility();
                              },
                              validator: (value) {
                               return FormValidators.validatePassword(value);
                              },
                            ),
                            const SizedBox(height: 15),
                            Align(
                              alignment: Alignment.centerRight,
                              child: InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    ForgetPassView.routeName,
                                  );
                                },
                                child: Text(
                                  'Forgot Password?',
                                  style: textStyle.semiBold16.copyWith(
                                    color: AppColors.kPrimaryColor,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),
                            LoginButton(
                              loginText: 'Login',
                              onTap: () {
                                cubit.loginButtonPressed();
                              },
                            ),
                            const SizedBox(height: 25),
                            LoginButton(
                              loginText: 'Login With Google',
                              onTap: () {
                                cubit.googleSignIn();
                              },
                            ),
                            const SizedBox(height: 40),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Don\'t have an account?',
                                  style: textStyle.semiBold18,
                                ),
                                const SizedBox(width: 5),
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      SignUpView.routeName,
                                    );
                                  },
                                  child: InkWell(
                                    child: Text(
                                      'Sign Up',
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
              ),
            );
      },
      listener: (context, state) {
          if (state is AuthenticationLoginSuccess ||
              state is AuthenticationGoogleSignInSuccess) {
            customSnackBar(
              context: context,
              msg: "Logged in successfully.",
              isError: false,
            );

          } else if (state is AuthenticationLoginFailure) {
            customSnackBar(context: context, msg: state.errorMessage);
          } else if (state is AuthenticationGoogleSignInFailure) {
            customSnackBar(context: context, msg: state.errorMessage);
          }

        },
    );
  }


}
