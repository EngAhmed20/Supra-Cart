import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supra_cart/core/style/app_text_styles.dart';
import 'package:supra_cart/core/widgets/custom_snack_bar.dart';
import 'package:supra_cart/core/widgets/custom_text_form.dart';
import 'package:supra_cart/features/auth/logic/cubit/authentication_cubit.dart';
import 'package:supra_cart/features/auth/ui/widgets/custom_text_button.dart';

import '../../../core/helper_function/validators.dart';
import '../../../core/widgets/loadibg_ink_drop.dart';

class ForgetPassView extends StatelessWidget {
  const ForgetPassView({super.key});
  static const String routeName = '/forget-pass';

  @override
  Widget build(BuildContext context) {
   return BlocConsumer<AuthenticationCubit,AuthenticationState>(builder: (context,state){
      var cubit = context.read<AuthenticationCubit>();
     return state is AuthenticationPasswordResetLoading
         ? Scaffold(body: Loading_body(context))
         :
       Scaffold(
       appBar: AppBar(
         leading: IconButton(
           icon: const Icon(Icons.arrow_back_ios),
           onPressed: () => Navigator.of(context).pop(),
         ),
       ),
       body: Padding(
         padding: const EdgeInsets.symmetric(horizontal: 16),
         child: Form(
           key: cubit.resetPassFormKey,
            autovalidateMode: cubit.resetPassAutovalidateMode,
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
                  controller: cubit.resetPassEmailController,
                 validator: (value) {
                   return FormValidators.validateEmail(value);
                 },
               ),
               const SizedBox(height: 20),
               CustomTextButton(text: 'Send', onPressed: (){
                  cubit.resetPasswordButtonPressed();
               }),
             ],
           ),
         ),
       ),
     );
   }, listener: (context,state){
      if (state is AuthenticationPasswordResetSuccess) {

          customSnackBar(
            context: context,
            msg: "Password reset link sent to your email.",
            isError: false,);
          Future.delayed(const Duration(seconds: 2), () {
            Navigator.pop(context);
          });
      } else if (state is AuthenticationPasswordResetFailure) {
       customSnackBar(context: context, msg: 'Failed to send password reset link. Please try again.');
      }
   });
  }
}
