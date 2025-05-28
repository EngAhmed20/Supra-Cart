import 'package:flutter/material.dart';
import 'package:supra_cart/features/auth/ui/widgets/signup_view_body.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});
  static const String routeName = '/signUp';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
        child: SignupViewBody(),
      )),
    );
  }

}
