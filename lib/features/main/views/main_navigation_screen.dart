import 'package:final_assignment/features/constants/sizes.dart';
import 'package:final_assignment/features/home/views/home_screen.dart';
import 'package:final_assignment/features/post/views/post_screen.dart';
import 'package:final_assignment/features/users/views/user_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class MainNavigationScreen extends StatefulWidget {
  static const String routeUrl = "/";
  static const String routeName = "home";

  const MainNavigationScreen({super.key, required this.tab});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String tab;

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen>
    with TickerProviderStateMixin {
  final List<String> _tabs = [
    "",
    "search",
    "xxxx",
    "activity",
    "profile",
  ];

  late int _selectedIndex = _tabs.indexOf(widget.tab);

  void _onTap(int index) {
    context.go("/${_tabs[index]}");
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onBottomSheet() async {
    await showModalBottomSheet(
      showDragHandle: false,
      isScrollControlled: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => const PostScreen(),
      transitionAnimationController: AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 600),
        reverseDuration: const Duration(milliseconds: 600),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Offstage(
            offstage: _selectedIndex != 0,
            child: const HomeScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 1,
            child: Container(),
          ),
          Offstage(
            offstage: _selectedIndex != 3,
            child: Container(),
          ),
          Offstage(
            offstage: _selectedIndex != 4,
            child: const UserProfileScreen(),
          )
        ],
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.transparent,
        indicatorColor: Colors.transparent,
        height: Sizes.size52,
        animationDuration: const Duration(milliseconds: 600),
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) => _onTap(index),
        elevation: 0,
        destinations: [
          NavigationDestination(
            selectedIcon: const FaIcon(
              FontAwesomeIcons.house,
            ),
            icon: FaIcon(
              FontAwesomeIcons.house,
              color: Colors.grey.withOpacity(0.4),
              size: Sizes.size24,
            ),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: const FaIcon(
              FontAwesomeIcons.magnifyingGlass,
            ),
            icon: FaIcon(
              FontAwesomeIcons.magnifyingGlass,
              color: Colors.grey.withOpacity(0.4),
            ),
            label: 'Search',
          ),
          Center(
            child: GestureDetector(
              onTap: _onBottomSheet,
              child: FaIcon(
                FontAwesomeIcons.penToSquare,
                color: Colors.grey.withOpacity(0.4),
              ),
            ),
          ),
          NavigationDestination(
            selectedIcon: const FaIcon(
              FontAwesomeIcons.solidHeart,
            ),
            icon: FaIcon(
              FontAwesomeIcons.heart,
              color: Colors.grey.withOpacity(0.4),
            ),
            label: 'likes',
          ),
          NavigationDestination(
            selectedIcon: const FaIcon(
              FontAwesomeIcons.solidUser,
            ),
            icon: FaIcon(
              FontAwesomeIcons.user,
              color: Colors.grey.withOpacity(0.4),
            ),
            label: 'profile',
          ),
        ],
      ),
    );
  }
}
