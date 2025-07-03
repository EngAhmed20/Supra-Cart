import 'package:flutter/material.dart';
import 'package:supra_cart/features/auth/ui/forget_pass_view.dart';
import 'package:supra_cart/features/auth/ui/login_view.dart';
import 'package:supra_cart/features/auth/ui/sign_up_view.dart';
import 'package:supra_cart/features/home/ui/main_home_view.dart';
import 'package:supra_cart/features/home/ui/widgets/category_view.dart';
import 'package:supra_cart/features/home/ui/widgets/search_view.dart';
import 'package:supra_cart/features/product_details/ui/product_details_view.dart';
import 'package:supra_cart/features/splash/ui/splash_view.dart';

import '../../features/profile/ui/widgets/edit_name_view.dart';
import '../../features/profile/ui/widgets/my_orders_view.dart';
import '../models/product_model.dart';

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
      return MaterialPageRoute(builder: (_) =>  MainHomeView());
    case EditNameView.routeName:
      return MaterialPageRoute(builder: (_) =>  EditNameView());
    case MyOrdersView.routeName:
      return MaterialPageRoute(builder: (_) => const MyOrdersView());
    case ProductDetailsView.routeName:
      final product = settings.arguments as ProductModel;
      return MaterialPageRoute(builder: (_)=> ProductDetailsView(product: product,));
    case SearchView.routeName:
      return MaterialPageRoute(builder: (_) => const SearchView());
    case CategoryView.routeName:
      final categoryName = settings.arguments as String;
      return MaterialPageRoute(builder: (_) => CategoryView(categoryName: categoryName));


    default:
      return MaterialPageRoute(builder: (_) => const Scaffold());
  }
}