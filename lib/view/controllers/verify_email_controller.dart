import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifyEmailController extends GetxController {
  final TextEditingController emailController = TextEditingController();

  // You might want to pass the email from the SignUpScreen to pre-fill it.
  // This can be done in the constructor or using Get.arguments.
  // For now, we'll initialize with a dummy email as seen in the image.
  @override
  void onInit() {
    super.onInit();
    // This assumes you want to pre-fill the email address from a previous screen
    // or set a default. If coming from SignUp, you'd pass it via Get.arguments.
    if (Get.arguments != null && Get.arguments is String) {
      emailController.text = Get.arguments as String;
    } else {
      emailController.text = 'michelle.rivera@example.com'; // Default from image
    }
  }

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

    // --- Implement your email sending logic here ---
    // This is where you would call an API or a service to send the verification email.
    print('Sending verification email to: ${emailController.text}');

    // For demonstration, show a success message and potentially navigate.
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Verification email sent to ${emailController.text}!')),
    );

    // After sending the email, you might navigate to a screen
    // that asks for the verification code.
    // Example:
    // Get.to(() => EnterVerificationCodeScreen(email: emailController.text));
  }
}