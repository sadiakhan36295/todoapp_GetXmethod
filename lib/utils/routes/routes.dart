
// lib/utils/routes.dart
import 'package:get/get.dart';
import 'package:practice_todoapp/view/screens/auth/signIn/sign_in_screen.dart';
import 'package:practice_todoapp/view/screens/home_screen/home_screen.dart';
import 'package:practice_todoapp/view/screens/splash/splash_screen.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String signIn = '/sign-in';
  static const String home = '/home';

  static final routes = [
    GetPage(name: splash, page: () => const SplashScreen()),
    GetPage(name: signIn, page: () => const SignInScreen()),
    GetPage(name: home, page: () => const HomeScreen()),
  ];
}
