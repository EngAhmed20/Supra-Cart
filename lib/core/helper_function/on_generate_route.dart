import 'package:flutter/material.dart';
import 'package:supra_cart/features/auth/ui/forget_pass_view.dart';
import 'package:supra_cart/features/auth/ui/login_view.dart';
import 'package:supra_cart/features/auth/ui/sign_up_view.dart';
import 'package:supra_cart/features/home/ui/main_home_view.dart';
import 'package:supra_cart/features/splash/ui/splash_view.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings){
  switch(settings.name){
    case SplashView.routeName:
      return MaterialPageRoute(builder: (_) => const SplashView());
    case LoginView.routeName:
      return MaterialPageRoute(builder: (_) => const LoginView());
    case ForgetPassView.routeName:
      return MaterialPageRoute(builder: (_) => const ForgetPassView());
    case SignUpView.routeName:
      return MaterialPageRoute(builder: (_) => const SignUpView());
    case MainHomeView.routeName:
      return MaterialPageRoute(builder: (_) => const MainHomeView());


    default:
      return MaterialPageRoute(builder: (_) => const Scaffold());
  }
}