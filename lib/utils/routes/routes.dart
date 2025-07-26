import 'package:get/get.dart';
import 'package:practice_todoapp/view/controllers/edit_profile_controller.dart';
import 'package:practice_todoapp/view/controllers/my_profile_controller.dart';
import 'package:practice_todoapp/view/screens/auth/signIn/sign_in_screen.dart';
import 'package:practice_todoapp/view/screens/auth/signup/sign_up_screen.dart';
import 'package:practice_todoapp/view/screens/auth/verify_email/verify_email_screen.dart';
import 'package:practice_todoapp/view/screens/home_screen/home_screen.dart';
import 'package:practice_todoapp/view/screens/splash/splash_screen.dart';
import 'package:practice_todoapp/view/screens/add_task_screen/add_task_screen.dart';
import 'package:practice_todoapp/view/screens/profile_screen/profile_screen.dart';
import 'package:practice_todoapp/view/screens/profile_screen/my_profile_screen.dart';
import 'package:practice_todoapp/view/screens/profile_screen/account_setting_screen.dart';
import 'package:practice_todoapp/view/screens/profile_screen/change_password_screen.dart';
import 'package:practice_todoapp/view/screens/profile_screen/edit_profile_screen.dart';
import 'package:practice_todoapp/view/screens/profile_screen/help_support_screen.dart';
import 'package:practice_todoapp/view/screens/profile_screen/privacy_policy_screen.dart';
import 'package:practice_todoapp/view/screens/profile_screen/terms_&_condition_screen.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String signIn = '/sign-in';
  static const String signUp = '/signup';
  static const String verifyEmail = '/verify-email';
  static const String sixDigit = '/six-digit';
  static const String home = '/home';
  static const String addTask = '/add-task';
  static const String profile = '/profile';
  static const String myProfile = '/my-profile';
  static const String accountSetting = '/account-setting';
  static const String changePassword = '/change-password';
  static const String editProfile = '/edit-profile';
  static const String termsAndConditions = '/terms-and-conditions';
  static const String privacyPolicy = '/privacy-policy';
  static const String helpSupport = '/help-support';

  static final routes = [
    GetPage(name: splash, page: () => const SplashScreen()),
    GetPage(name: signIn, page: () => const SignInScreen()),
    GetPage(name: signUp, page: () => const SignUpScreen()),

    GetPage(
      name: verifyEmail,
      page: () {
        final emailArg = Get.arguments as String?;
        return VerifyEmailScreen(email: emailArg ?? '');
      },
    ),
        

 

    GetPage(name: home, page: () => const HomeScreen()),
    GetPage(name: addTask, page: () => const AddTaskScreen()),
    GetPage(name: profile, page: () => const ProfileScreen()),

    GetPage(
      name: myProfile,
      page: () => const MyProfileScreen(),
      binding: BindingsBuilder(() {
        Get.put(MyProfileController());
      }),
    ),

    GetPage(name: accountSetting, page: () => const AccountSettingScreen()),
    GetPage(name: changePassword, page: () => ChangePasswordScreen()),

    GetPage(
      name: editProfile,
      page: () => EditProfileScreen(),
      binding: BindingsBuilder(() {
        Get.put(MyProfileController());
        Get.put(EditProfileController());
      }),
    ),

    GetPage(name: termsAndConditions, page: () => TermsAndConditionsScreen()),
    GetPage(name: privacyPolicy, page: () => PrivacyPolicyScreen()),
    GetPage(name: helpSupport, page: () => HelpSupportScreen()),
  ];
}
