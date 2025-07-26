import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:practice_todoapp/utils/network/api_urls.dart';
import 'package:practice_todoapp/utils/network/base_client.dart';
import 'package:practice_todoapp/utils/routes/routes.dart';
import 'package:practice_todoapp/view/model/my_profile.dart';
import 'package:practice_todoapp/view/controllers/my_profile_controller.dart';

class EditProfileController extends GetxController {
  final RxInt currentIndex = 2.obs;

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  Rx<File?> selectedImage = Rx<File?>(null);
  final ImagePicker _picker = ImagePicker();

  @override
  @override
void onInit() {
  super.onInit();
  final profile = Get.find<MyProfileController>().userData;

  if (profile != null) {
    final nameParts = profile.name?.split(" ") ?? [];
    firstNameController.text = nameParts.isNotEmpty ? nameParts.first : '';
    lastNameController.text = nameParts.length > 1 ? nameParts.sublist(1).join(" ") : '';
    emailController.text = profile.email ?? '';
    addressController.text = profile.address ?? '';
  }
}


  /// 📌 Method to pick an image
  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
    }
  }

  /// ✅ Method to update profile using multipart PUT or PATCH
  void updateProfile(BuildContext context) async {
    try {
      final name = '${firstNameController.text.trim()} ${lastNameController.text.trim()}';
      final email = emailController.text.trim();
      final address = addressController.text.trim();

      Map<String, String> fields = {
        'name': name,
        'email': email,
        'address': address,
      };

      Map<String, File> files = {};

      if (selectedImage.value != null) {
        files['image'] = selectedImage.value!;
      }

      // Using PUT or PATCH depending on your backend (adjust URL if needed)
      final response = await BaseClient.patchMultipart(
        ApiUrl.updateProfile,
        fields,
        files,
      );

      // ✅ Optionally refresh profile data after update
     await Get.find<MyProfileController>().fetchProfileData();


      // ✅ Navigate back to profile screen
      Get.offNamed(AppRoutes.myProfile);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Update failed: ${e.toString()}")),
      );
    }
  }
}
