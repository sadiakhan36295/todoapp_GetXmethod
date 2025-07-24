
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:practice_todoapp/utils/network/api_urls.dart';
import 'package:practice_todoapp/utils/network/base_client.dart';
import 'package:practice_todoapp/utils/routes/routes.dart';
import 'package:practice_todoapp/view/widgets/custom_toast.dart';

class SignInController extends GetxController {
  var isLoading = false.obs;
  final box = GetStorage();

  Future<void> signIn({
    required String email,
    required String password,
    BuildContext? context,
  }) async {
    try {
      isLoading.value = true;

      final Map<String, dynamic> response = await BaseClient.postRequest(
        api: ApiUrl.signIn,
        body: {
          "email": email,
          "password": password,
        },
      );

      isLoading.value = false;

      if (response["status"] == true || response["success"] == true) {
        CustomToast.showToast(
          response["message"] ?? "Login successful",
          isError: false,
        );

        final token = response["token"];
        if (token != null) {
          box.write("token", token);
        }

        Get.offAllNamed(AppRoutes.home);
      } else {
        CustomToast.showToast(
          response["message"] ?? "Login failed",
          isError: true,
        );
      }
    } catch (e) {
      isLoading.value = false;
      CustomToast.showToast("Login Error: $e", isError: true);
    }
  }
}
