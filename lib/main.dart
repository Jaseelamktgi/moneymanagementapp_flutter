import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:get/get.dart';
import 'package:moneymanagementapp_flutter/Model/Category/Category_model.dart';
import 'package:moneymanagementapp_flutter/Model/Profile/Profile_model.dart';
import 'package:moneymanagementapp_flutter/Model/Transaction/Transaction_model.dart';
import 'package:moneymanagementapp_flutter/Screens/Home/Home_Screen.dart';
import 'package:moneymanagementapp_flutter/Screens/Transactions/Widgets/Add_Transactions.dart';
import 'package:moneymanagementapp_flutter/Screens/login/login_screen.dart';
import 'package:moneymanagementapp_flutter/Screens/onboarding_screen/onboarding_screen.dart';
import 'package:moneymanagementapp_flutter/Screens/profile_screen/profile_screen.dart';
import 'package:moneymanagementapp_flutter/Screens/register/register_screen.dart';
import 'package:moneymanagementapp_flutter/Screens/splash_screen/splash_screen.dart';

void main() async {
  //before starting app auto checking everything is connected
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(UserProfileAdapter());
  Hive.registerAdapter(CategoryTypeAdapter());
  Hive.registerAdapter(CategoryModelAdapter());
  Hive.registerAdapter(TransactionModelAdapter());
  await Hive.openBox<UserProfile>('user_profiles');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Money Management App',
      theme: ThemeData(
        useMaterial3: true,
      ),
      initialRoute: '/',
      getPages: [
       GetPage(name: '/', page: () => SplashScreen()),
        GetPage(name: '/onboarding', page: () => OnboardingScreen()),
        GetPage(name: '/register', page: () => RegistrationPage()),
        GetPage(name: '/login', page: () => LoginScreen()),
        GetPage(name: '/home', page: () => HomeScreen()),
        GetPage(name: '/profile', page: () => ProfileScreen()),
        GetPage(name: '/add_transaction', page: () => AddTransaction()),

      ],
    );
  }
}
