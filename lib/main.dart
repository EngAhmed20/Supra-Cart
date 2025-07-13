import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supra_cart/bloc_observer.dart';
import 'package:supra_cart/core/helper_function/get_it_services.dart';
import 'package:supra_cart/core/repo/user_info_repo.dart';
import 'package:supra_cart/core/secret_data.dart';
import 'package:supra_cart/core/style/app_colors.dart';
import 'package:supra_cart/features/auth/logic/cubit/authentication_cubit.dart';
import 'package:supra_cart/features/splash/ui/splash_view.dart';

import 'core/helper_function/on_generate_route.dart';
import 'core/repo/product_repo.dart';
import 'features/home/logic/cubit/home_cubit/home_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: SecretData.supabaseUrl,
    anonKey: SecretData.supabaseAnonKey,
  );
  Bloc.observer = blocObserver();
  ServicesLoacator().init();
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
      builder: (_, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<AuthenticationCubit>(
              create:
                  (context) => AuthenticationCubit(
                    getIt.get<SupabaseClient>(),
                    getIt.get<SharedPreferences>(),
                  )..getUserDataFromPrefs(),
            ),
            BlocProvider(
              create:
                  (context) =>
                      HomeCubit(
                          getIt.get<HomeProductRepo>(),
                          getIt.get<SupabaseClient>(),
                          getIt.get<SharedPreferences>(),
                          getIt.get<UserInfoRepo>(),
                        )
                        ..init()
                        ..getHomeProducts(),
            ),
          ],

          child: MaterialApp(
            title: 'Supra Market',
            theme: ThemeData(
              scaffoldBackgroundColor: AppColors.kScaffoldColor,
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            ),
            onGenerateRoute: onGenerateRoute,
            initialRoute: SplashView.routeName,
            debugShowCheckedModeBanner: false,
          ),
        );
      },
    );
  }
}
