import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practice_todoapp/utils/network/api_urls.dart';
import 'package:practice_todoapp/utils/network/base_client.dart';

import 'package:practice_todoapp/utils/routes/routes.dart';
import 'package:practice_todoapp/view/widgets/custom_toast.dart';

class SignInController extends GetxController {
  var isLoading = false.obs;

  Future<void> signIn({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    isLoading.value = true;

    Map<String, String> body = {
      'email': email,
      'password': password,
    };

    try {
      print('Sending login request: $body');

      final res = await BaseClient.postRequest(
        api: ApiUrl.signIn,
        body: body,
      );

      print("Raw response: $res");

      // Decode the response
      final response = jsonDecode(res.body);
      print("Login response: $response");

      if (response["status"] == true || response["success"] == true) {
        CustomToast.showToast(
          response["message"] ?? "Login successful",
          isError: false,
        );

        //  Navigate using named route
        Get.offAllNamed(AppRoutes.home);
      } else {
        CustomToast.showToast(
          response["message"] ?? "Login failed",
          isError: true,
        );
      }
    } catch (e) {
      print("Error during login: $e");
      CustomToast.showToast("Something went wrong", isError: true);
    } finally {
      isLoading.value = false;
    }
  }
}
