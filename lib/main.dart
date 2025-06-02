import 'package:flutter/material.dart';
import 'package:supra_cart/core/style/app_colors.dart';
import 'package:supra_cart/features/splash/ui/splash_view.dart';

import 'core/helper_function/on_generate_route.dart';

void main() {
  runApp(const SupraCart());
}

class SupraCart extends StatelessWidget {
  const SupraCart({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Supra Market',
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.kScaffoldColor,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      onGenerateRoute: onGenerateRoute,
      initialRoute: SplashView.routeName,
      debugShowCheckedModeBanner: false,
    );
  }

}

