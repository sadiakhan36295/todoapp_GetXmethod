import 'package:get/get.dart';
import 'package:practice_todoapp/view/screens/auth/signIn/sign_in_screen.dart';
import 'package:practice_todoapp/view/screens/home_screen/home_screen.dart';
import 'package:practice_todoapp/view/screens/profile_screen/account_setting_screen.dart';
import 'package:practice_todoapp/view/screens/splash/splash_screen.dart';
import 'package:practice_todoapp/view/screens/add_task_screen/add_task_screen.dart';
import 'package:practice_todoapp/view/screens/profile_screen/profile_screen.dart';
import 'package:practice_todoapp/view/screens/profile_screen/my_profile_screen.dart'; // <--- Add this import

class AppRoutes {
  static const String splash = '/splash';
  static const String signIn = '/sign-in';
  static const String home = '/home';
  static const String addTask = '/add-task';
  static const String profile = '/profile';
  static const String myProfile = '/my-profile'; 
  static const String accountSetting = '/account-setting'; 


  static final routes = [
    GetPage(name: splash, page: () => const SplashScreen()),
    GetPage(name: signIn, page: () => const SignInScreen()),
    GetPage(name: home, page: () => const HomeScreen()),
    GetPage(name: addTask, page: () => const AddTaskScreen()),
    GetPage(name: profile, page: () => const ProfileScreen()),
    GetPage(name: myProfile, page: () => const MyProfileScreen()), 
    GetPage(name: accountSetting, page: () => const AccountSettingScreen()),
     
  ];
}
