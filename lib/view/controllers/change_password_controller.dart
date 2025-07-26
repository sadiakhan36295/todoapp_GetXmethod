import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordController extends GetxController {
  // Controllers for the password fields
  final TextEditingController typePasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController newConfirmPasswordController = TextEditingController();

  // Password visibility toggles
  RxBool isTypePasswordVisible = false.obs;
  RxBool isNewPasswordVisible = false.obs;
  RxBool isNewConfirmPasswordVisible = false.obs;

  // Current selected index in the bottom nav bar
  RxInt currentIndex = 0.obs;

  // Toggle visibility functions
  void toggleTypePasswordVisibility() {
    isTypePasswordVisible.value = !isTypePasswordVisible.value;
  }

  void toggleNewPasswordVisibility() {
    isNewPasswordVisible.value = !isNewPasswordVisible.value;
  }

  void toggleNewConfirmPasswordVisibility() {
    isNewConfirmPasswordVisible.value = !isNewConfirmPasswordVisible.value;
  }

  // Simulated update password logic
  void updatePassword(BuildContext context) {
    final current = typePasswordController.text;
    final newPass = newPasswordController.text;
    final confirmNew = newConfirmPasswordController.text;

    if (current.isEmpty || newPass.isEmpty || confirmNew.isEmpty) {
      Get.snackbar("Error", "All fields are required",
          snackPosition: SnackPosition.BOTTOM);
    } else if (newPass != confirmNew) {
      Get.snackbar("Error", "New passwords do not match",
          snackPosition: SnackPosition.BOTTOM);
    } else {
      // Perform update logic here
      Get.snackbar("Success", "Password updated successfully",
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  void onClose() {
    typePasswordController.dispose();
    newPasswordController.dispose();
    newConfirmPasswordController.dispose();
    super.onClose();
  }
}
