import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practice_todoapp/view/screens/auth/verify_email/six_digit_code_screen.dart';

class VerifyEmailController extends GetxController {
  final TextEditingController emailController = TextEditingController();

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }

  void sendVerificationEmail(BuildContext context) {
    if (emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your email address.')),
      );
      return;
    }

    if (!GetUtils.isEmail(emailController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid email address.')),
      );
      return;
    }

    // ✅ Show a success message (you can remove it if you don't want)
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Verification code sent to ${emailController.text}!')),
    );

    // ✅ Navigate to SixDigitCodeScreen with email as argument
    Get.to(() => SixDigitCodeScreen(), arguments: emailController.text);
  }
}
