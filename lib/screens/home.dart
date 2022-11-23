import 'package:flutter/material.dart';
import 'package:movies/setting_module/pressentation/setting_screen.dart';
import 'package:movies/tv_module/pressentation/screens/tv_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../movie_module/pressentation/screens/movie_screen.dart';

class HomeScreen extends StatelessWidget{
  final PersistentTabController _controller=PersistentTabController(initialIndex: 0);

  HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(context),
      confineInSafeArea: true,
      backgroundColor: Theme.of(context).backgroundColor,
      itemAnimationProperties: const ItemAnimationProperties( // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style1, // Choose the nav bar style with this property.
    );
  }

  List<Widget> _buildScreens() {
    return [
      const MoviesScreen(),
      const TvScreen(),
      const SettingScreen(),
    ];
  }
  List<PersistentBottomNavBarItem> _navBarsItems(context) {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.movie),
        activeColorPrimary: Theme.of(context).primaryColor,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.tv),
        activeColorPrimary: Theme.of(context).primaryColor,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.settings),
        activeColorPrimary: Theme.of(context).primaryColor,
      ),
    ];
  }
}