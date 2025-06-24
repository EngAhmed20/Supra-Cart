import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supra_cart/core/helper_function/base_api_services.dart';
import 'package:supra_cart/core/helper_function/get_it_services.dart';
import 'package:supra_cart/core/repo/product_repo.dart';
import 'package:supra_cart/features/favorite/ui/favorite_view.dart';
import 'package:supra_cart/features/home/logic/cubit/home_cubit/home_cubit.dart';
import 'package:supra_cart/features/home/ui/home_view.dart';
import 'package:supra_cart/features/profile/ui/profile_view.dart';
import 'package:supra_cart/features/store/ui/store_view.dart';
import 'nav_bar/google_nav_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainHomeView extends StatelessWidget {
  const MainHomeView({super.key});
  static const String routeName = '/mainHome';
  final List<Widget> pages = const [
     HomeView(),
    StoreView(),
    FavoriteView(),
    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(getIt.get<HomeProductRepo>())..getHomeProducts(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          final cubit = context.read<HomeCubit>();
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300), // ⏱ مدة الانتقال
                  transitionBuilder: (Widget child, Animation<double> animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
                  child: KeyedSubtree(
                    key: ValueKey<int>(cubit.currentIndex),
                    child: pages[cubit.currentIndex],
                  ),
                ),
              ),
            ),
            bottomNavigationBar: const GoogleNavBar(),
          );
        },
      ),
    );
  }
}

