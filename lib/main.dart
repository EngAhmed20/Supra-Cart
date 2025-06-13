import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supra_cart/core/secret_data.dart';
import 'package:supra_cart/core/style/app_colors.dart';
import 'package:supra_cart/features/splash/ui/splash_view.dart';

import 'core/helper_function/on_generate_route.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: SecretData.supabaseUrl,
    anonKey: SecretData.supabaseAnonKey,
  );
  runApp(const SupraCart());
}

class SupraCart extends StatelessWidget {
  const SupraCart({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder:(_,child){
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
    );
  }

}

