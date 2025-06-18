import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supra_cart/core/helper_function/get_it_services.dart';
import 'package:supra_cart/features/auth/ui/login_view.dart';
import 'package:supra_cart/features/home/ui/main_home_view.dart';

import '../../../../generated/assets.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody> {
  @override
  void initState() {
    executeNavigation();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          Assets.imagesSupraLogo,
        ),
      ],
    );
  }
  void executeNavigation() {
    Future.delayed(const Duration(seconds: 3), () {
     getIt.get<SupabaseClient>().auth.currentUser!=null
          ? Navigator.pushReplacementNamed(context, MainHomeView.routeName)
          :
      Navigator.pushReplacementNamed(context, LoginView.routeName);
    });
  }
}

