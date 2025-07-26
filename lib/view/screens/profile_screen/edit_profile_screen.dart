import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practice_todoapp/view/controllers/edit_profile_controller.dart';
import 'package:practice_todoapp/view/widgets/custom_button/custom_button.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});

  final EditProfileController controller = Get.find<EditProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.lightGreen),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        centerTitle: true,
        title: const Text(
          'Edit Profile',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: GestureDetector(
                onTap: controller.pickImage,
                child: Obx(
                  () => Stack(
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.white60,
                        backgroundImage: controller.selectedImage.value != null
                            ? FileImage(controller.selectedImage.value!)
                            : null,
                        child: controller.selectedImage.value == null
                            ? ClipOval(
                               
                              )
                            : null,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.lightGreen,
                            shape: BoxShape.circle,
                          ),
                          padding: const EdgeInsets.all(8),
                          child: const Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            _buildTextField(
              controller: controller.firstNameController,
              label: 'First Name',
              hintText: 'e.g. Kristin',
            ),
            const SizedBox(height: 20),
            _buildTextField(
              controller: controller.lastNameController,
              label: 'Last Name',
              hintText: 'e.g. Cooper',
            ),
            const SizedBox(height: 20),
            _buildTextField(
              controller: controller.emailController,
              label: 'Email Address',
              hintText: 'e.g. kristin.cooper@example.com',
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20),
            _buildTextField(
              controller: controller.addressController,
              label: 'Address',
              hintText: 'e.g. 1234 Elm Street, Springfield, IL',
              keyboardType: TextInputType.streetAddress,
            ),
            const SizedBox(height: 40),
            CustomButton(
              title: 'Update',
              onTap: () => controller.updateProfile(context),
              titleColor: Colors.white,
              backgroundColor: Colors.lightGreen,
              fillColor: Colors.lightGreen,
              height: 50,
              width: double.infinity,
              marginVerticel: 0,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          backgroundColor: Colors.white,
          currentIndex: controller.currentIndex.value,
          onTap: (index) {
            controller.currentIndex.value = index;
            if (index == 0) {
              Navigator.pop(context);
            }
          },
          items: [
            _buildBottomNavItem(Icons.home, "My Tasks", 0, controller.currentIndex.value),
            _buildBottomNavItem(Icons.add, "Add Task", 1, controller.currentIndex.value),
            _buildBottomNavItem(Icons.person, "Profile", 2, controller.currentIndex.value),
          ],
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.black,
          showSelectedLabels: true,
          showUnselectedLabels: true,
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white60,
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            maxLines: maxLines,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(color: Colors.grey),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }

  BottomNavigationBarItem _buildBottomNavItem(IconData icon, String label, int index, int currentIndex) {
    bool isActive = index == currentIndex;
    return BottomNavigationBarItem(
      icon: Container(
        decoration: BoxDecoration(
          color: isActive ? Colors.lightGreen : Colors.transparent,
          shape: BoxShape.circle,
        ),
        padding: const EdgeInsets.all(8),
        child: Icon(icon, color: isActive ? Colors.white : Colors.black),
      ),
      label: label,
    );
  }
}
