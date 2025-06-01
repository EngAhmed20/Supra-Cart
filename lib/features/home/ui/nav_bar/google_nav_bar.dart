import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:supra_cart/core/style/app_colors.dart';

class GoogleNavBar extends StatelessWidget {
  const GoogleNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
      child: GNav(
        onTabChange: (value){
          print(value);
        },
          rippleColor: AppColors.kPrimaryColor, // tab button ripple color when pressed
          hoverColor:AppColors.kPrimaryColor, // tab button hover color
          curve: Curves.easeOutExpo, // tab animation curves
          duration: Duration(milliseconds: 300), // tab animation duration
          gap: 8, // the tab button gap between icon and text
          color: AppColors.kGreyColor, // unselected icon color
          activeColor: AppColors.kWhiteColor, // selected icon and text color
          iconSize: 24, // tab button icon size
          tabBackgroundColor:AppColors.kPrimaryColor, // selected tab background color
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12), // navigation bar padding
          tabs: [
            GButton(
              icon: Icons.home,
              text: 'Home',
            ),
            GButton(
              icon: Icons.store,
              text: 'Store',
            ),
            GButton(
              icon: Icons.favorite,
              text: 'Favorite',
            ),
            GButton(
              icon: Icons.person,
              text: 'Profile',
            )
          ]
      ),
    );
  }
}
