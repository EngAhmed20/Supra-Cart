import 'package:flutter/material.dart';
import 'package:supra_cart/features/auth/ui/login_view.dart';
import 'package:supra_cart/features/splash/ui/splash_view.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings){
  switch(settings.name){
    case SplashView.routeName:
      return MaterialPageRoute(builder: (_) => const SplashView());
    case LoginView.routeName:
      return MaterialPageRoute(builder: (_) => const LoginView());


    default:
      return MaterialPageRoute(builder: (_) => const Scaffold());
  }
}