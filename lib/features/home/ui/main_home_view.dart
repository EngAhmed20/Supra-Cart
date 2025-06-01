import 'package:flutter/material.dart';
import 'package:supra_cart/features/favorite/ui/favorite_view.dart';
import 'package:supra_cart/features/home/ui/home_view.dart';
import 'package:supra_cart/features/profile/ui/profile_view.dart';
import 'package:supra_cart/features/store/ui/store_view.dart';
import '../logic/cubit/nav_bar_cubit/nav_bar_cubit.dart';
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
      create: (context) => NavBarCubit(),
      child: BlocBuilder<NavBarCubit, NavBarState>(
        builder: (context, state) {
          final cubit = context.read<NavBarCubit>();
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
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

