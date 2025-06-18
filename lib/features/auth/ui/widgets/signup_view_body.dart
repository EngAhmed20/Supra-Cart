import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supra_cart/core/helper_function/validators.dart';
import 'package:supra_cart/features/auth/logic/cubit/authentication_cubit.dart';

import '../../../../core/style/app_colors.dart';
import '../../../../core/style/app_text_styles.dart';
import '../../../../core/widgets/custom_snack_bar.dart';
import '../../../../core/widgets/custom_text_form.dart';
import '../../../../core/widgets/loadibg_ink_drop.dart';
import '../../../home/ui/main_home_view.dart';
import 'login_button.dart';


class SignupViewBody extends StatelessWidget {
  const SignupViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationCubit,AuthenticationState>(
        builder:(context,state){
          var cubit=context.read<AuthenticationCubit>();
          return state is AuthenticationRegisterLoading || state is AuthenticationGoogleSignInLoading
              ? Loading_body(context)
              :
            SingleChildScrollView(
            child: Form(
              key: cubit.registerFormKey,
              autovalidateMode: cubit.autovalidateMode,
              child: Column(
                children: [
                  const SizedBox(height: 30,),
                  Text(
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
                            controller: cubit.registerNameController,
                            validator: (value) {
                            return  FormValidators.validateName(value);
                            },
                          ),
                          const SizedBox(height: 25),
                          CustomTextFormField(hintText: 'Enter your email',
                            keyboardType: TextInputType.emailAddress,
                            controller: cubit.registerEmailController,
                            validator: (value) {
                             return FormValidators.validateEmail(value);
                            },
                          ),
                          const SizedBox(height: 25),
                          CustomTextFormField(
                            hintText: 'Enter your password',
                            isPassword: true,
                            obscureText: cubit.hidePass,
                            controller: cubit.registerPasswordController,
                            onTogglePasswordVisibility: (){
                              cubit.changePasswordVisibility();
                            },
                            validator: (value) {
                             return FormValidators.validatePassword(value);
                            },
                          ),
                          const SizedBox(height: 25),
                          CustomTextFormField(
                            hintText: 'Re-enter your password',
                            isPassword: true,
                            obscureText: cubit.hideConfirmPass,
                            controller: cubit.registerConfirmPasswordController,
                            onTogglePasswordVisibility: () {
                              cubit.changeConfirmPasswordVisibility();
                            },
                            validator: (value) {
                            return FormValidators.validateConfirmPassword(value, cubit.registerPasswordController.text);
                            },
                          ),


                          const SizedBox(height: 30,),
                          LoginButton(loginText: 'Sign Up',onTap: ()async {
                            cubit.registerButtonPressed();
                          },),
                          const SizedBox(height: 25,),
                          LoginButton(loginText: 'Sign Up With Google',onTap: (){
                            cubit.googleSignIn();
                          },),
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
            ),
          );
        },
        listener: (context,state){

            if (state is AuthenticationRegisterSuccess) {
              customSnackBar(
                context: context,
                msg: "Account created successfully.",
                isError: false,
              );
              Navigator.pushNamedAndRemoveUntil(context, MainHomeView.routeName, (route) => false);
            } else if (state is AuthenticationRegisterFailure) {
              customSnackBar(context: context, msg: state.errorMessage);
            } else if (state is AuthenticationGoogleSignInFailure) {
              customSnackBar(context: context, msg: state.errorMessage);
            }


    });

}



}
