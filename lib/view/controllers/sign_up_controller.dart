import 'dart:io';
import 'package:get/get.dart';
import 'package:practice_todoapp/utils/network/api_urls.dart';
import 'package:practice_todoapp/utils/network/base_client.dart';
import 'package:practice_todoapp/view/widgets/custom_toast.dart';

class SignUpController extends GetxController {
  var isLoading = false.obs;

  Future<void> registerUser({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String address,
    File? file, // Optional profile image
  }) async {
    isLoading.value = true;

    Map<String, String> body = {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
      'address': address,
    };

    try {
      var response = await BaseClient.multipartAddRequest(
        api: ApiUrl.signUp,
        body: body,
        file: file, // ✅ Make sure to pass file
         // 👈 name expected by your backend
      );

      CustomToast.showToast(response["message"], isError: false);
    } catch (e) {
      CustomToast.showToast("Failed to sign up", isError: true);
    } finally {
      isLoading.value = false;
    }
  }
}
