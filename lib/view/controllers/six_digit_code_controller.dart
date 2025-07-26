import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SixDigitCodeController extends GetxController {
  final List<TextEditingController> codeControllers =
      List.generate(6, (_) => TextEditingController());

  final List<FocusNode> focusNodes =
      List.generate(6, (_) => FocusNode());

  final RxString email = ''.obs;

  @override
  void onInit() {
    super.onInit();

    // ✅ Receive email from Get.arguments
    if (Get.arguments != null && Get.arguments is String) {
      email.value = Get.arguments;
    } else {
      email.value = 'michelle.rivera@example.com';
    }

    for (int i = 0; i < codeControllers.length; i++) {
      codeControllers[i].addListener(() {
        if (codeControllers[i].text.length == 1 && i < codeControllers.length - 1) {
          FocusScope.of(Get.context!).requestFocus(focusNodes[i + 1]);
        } else if (codeControllers[i].text.isEmpty && i > 0) {
          FocusScope.of(Get.context!).requestFocus(focusNodes[i - 1]);
        }
      });
    }
  }

  @override
  void onClose() {
    for (final c in codeControllers) {
      c.dispose();
    }
    for (final f in focusNodes) {
      f.dispose();
    }
    super.onClose();
  }

  String get enteredCode => codeControllers.map((c) => c.text).join();

  void confirmCode(BuildContext context) {
    if (enteredCode.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter the full 6-digit code.')),
      );
      return;
    }

    if (enteredCode == '111111') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email verified successfully!')),
      );
      // Get.offAll(() => HomeScreen()); // Navigate to home or next screen
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid code. Please try again.')),
      );
    }
  }
}
