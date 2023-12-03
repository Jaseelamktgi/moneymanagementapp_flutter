import 'package:flutter/material.dart';
import 'package:moneymanagementapp_flutter/Screens/Category/Category_Screen.dart';
import 'package:moneymanagementapp_flutter/Screens/Home/Widgets/BottomNavigation.dart';
import 'package:moneymanagementapp_flutter/Screens/Transactions/Transaction_Screen.dart';
import 'package:moneymanagementapp_flutter/Screens/profile_screen/profile_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final _pages = [
    TransactionScreen(),
    CategoryScreen(),
    ProfileScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ValueListenableBuilder(
            valueListenable: indexChangeNofifier,
            builder: (BuildContext context, int updatedIndex, Widget? _) {
              return _pages[updatedIndex];
            }),
      ),
      bottomNavigationBar: BottomNavigationWidget(),
    );
  }
}
