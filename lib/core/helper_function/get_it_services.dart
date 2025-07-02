

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supra_cart/core/helper_function/base_api_services.dart';
import 'package:supra_cart/core/repo/product_repo.dart';
import 'package:supra_cart/core/repo/product_repo_impl.dart';

import '../secret_data.dart';
import '../utilis/constants.dart';
import 'api_services.dart';

final getIt = GetIt.instance;

class ServicesLoacator {
  void init() async{
    getIt.registerSingleton<SupabaseClient>(Supabase.instance.client);
    final sharedPrefs = await SharedPreferences.getInstance();

    getIt.registerLazySingleton<SharedPreferences>(() => sharedPrefs);
    ///Dio
    getIt.registerLazySingleton<Dio>(() => Dio(
      BaseOptions(
        baseUrl: baseUrl,
        headers: {'apikey': SecretData.supabaseAnonKey},
      ),
    ));
    // API Service
    getIt.registerLazySingleton<BaseApiServices>(() => ApiServices(dio: getIt<Dio>()));
    getIt.registerLazySingleton<HomeProductRepo>(()=>HomeProductRepoImpl(apiServices: getIt.get<BaseApiServices>()));


  }
}
