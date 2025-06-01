import 'package:flutter/material.dart';
import 'package:supra_cart/features/favorite/ui/favorite_view.dart';
import 'package:supra_cart/features/home/ui/home_view.dart';
import 'package:supra_cart/features/profile/ui/profile_view.dart';
import 'package:supra_cart/features/store/ui/store_view.dart';
import 'nav_bar/google_nav_bar.dart';
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
    return Scaffold(
      body: SafeArea(
        child: Padding(padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: pages[0],
      ),
    ),
      bottomNavigationBar: GoogleNavBar(),
    );
  }
}

