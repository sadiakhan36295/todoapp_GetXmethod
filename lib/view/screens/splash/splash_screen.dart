import 'package:flutter/material.dart';
import 'package:practice_todoapp/view/screens/auth/signIn/sign_in_screen.dart';
import 'package:practice_todoapp/view/widgets/custom_text/custom_text.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  spRoute() async {
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.push(context, MaterialPageRoute(builder: (context)=>SignInScreen()));
    });
  }

  @override
  void initState() {
    spRoute();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: CustomText(
          text: 'Splash Screen',
        ),
      ),
    );
  }
}
