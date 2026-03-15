import 'package:flutter/material.dart';
import 'package:plantify/app/widgets/bottom_bar/bottom_navigation_bar.dart';
import 'package:plantify/router.dart';
import '../features/home/presentation/home/view/home_screen.dart';
import '../features/my_cart_and_transaction/presentation/view/my_cart_list/view/my_cart_list_screen.dart';
import '../features/order_and_e-eeceipt/presentation/myorder_status/view/myorder_status_screen.dart';
import '../features/profile_and_setting/profile_menu/profile_menu_screen.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int _currentIndex = 0;

  DateTime? _lastBackPressed;

  final List<Widget> _screens = const [
    HomeScreen(),
    MyCartListScreen(),
    SizedBox(),
    MyOrdersScreen(),
    ProfileMenuScreen(),
  ];

  void _onTabTapped(int index) {
    if (index == 2) {
      Navigator.pushNamed(context, AppRouter.camerascan);
      return;
    }

    setState(() {
      _currentIndex = index;
    });
  }

  Future<bool> _onWillPop() async {

    if (_currentIndex != 0) {
      setState(() {
        _currentIndex = 0;
      });
      return false;
    }

    final now = DateTime.now();

    if (_lastBackPressed == null ||
        now.difference(_lastBackPressed!) > const Duration(seconds: 2)) {

      _lastBackPressed = now;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Press back again to exit"),
          duration: Duration(seconds: 2),
        ),
      );

      return false;
    }

    return true; // exit app
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: _screens,
        ),
        bottomNavigationBar: CustomBottomNavBar(
          currentIndex: _currentIndex,
          onTap: _onTabTapped,
        ),
      ),
    );
  }
}