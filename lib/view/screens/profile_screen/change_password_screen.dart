import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practice_todoapp/view/controllers/change_password_controller.dart';
import 'package:practice_todoapp/view/widgets/custom_button/custom_button.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key});

  final ChangePasswordController controller = Get.put(ChangePasswordController());

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
          child: Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white60,
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.lightGreen),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
        centerTitle: true,
        title: const Text(
          'Change Password',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Type Password', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black87)),
            const SizedBox(height: 8),
            Obx(() => _buildPasswordField(
              controller: controller.typePasswordController,
              isVisible: controller.isTypePasswordVisible.value,
              toggleVisibility: controller.toggleTypePasswordVisibility,
              hintText: 'Current Password',
            )),
            const SizedBox(height: 20),
            const Text('New Password', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black87)),
            const SizedBox(height: 8),
            Obx(() => _buildPasswordField(
              controller: controller.newPasswordController,
              isVisible: controller.isNewPasswordVisible.value,
              toggleVisibility: controller.toggleNewPasswordVisibility,
              hintText: 'New Password',
            )),
            const SizedBox(height: 20),
            const Text('New Confirm Password', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black87)),
            const SizedBox(height: 8),
            Obx(() => _buildPasswordField(
              controller: controller.newConfirmPasswordController,
              isVisible: controller.isNewConfirmPasswordVisible.value,
              toggleVisibility: controller.toggleNewConfirmPasswordVisibility,
              hintText: 'Confirm New Password',
            )),
            const SizedBox(height: 40),
            CustomButton(
              title: 'Update',
              onTap: () => controller.updatePassword(context),
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
      bottomNavigationBar: Obx(() => BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: controller.currentIndex.value,
        onTap: (index) {
          controller.currentIndex.value = index;
          if (index == 0) {
            Navigator.pop(context);
          }
          // Add navigation logic for index 1 or 2 if needed
        },
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.black),
            label: "My Tasks",
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.add, color: Colors.black),
            label: "Add Task",
          ),
          BottomNavigationBarItem(
            icon: Container(
              decoration: const BoxDecoration(
                color: Colors.lightGreen,
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(8),
              child: const Icon(Icons.person, color: Colors.white),
            ),
            label: "", // ✅ Important: must not be empty
          ),
        ],
      )),
    );
  }


  Widget _buildPasswordField({
    required TextEditingController controller,
    required bool isVisible,
    required VoidCallback toggleVisibility,
    required String hintText,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white60,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: controller,
        obscureText: !isVisible,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.grey),
          border: InputBorder.none,
          suffixIcon: IconButton(
            icon: Icon(isVisible ? Icons.visibility : Icons.visibility_off, color: Colors.grey),
            onPressed: toggleVisibility,
          ),
        ),
      ),
    );
  }

  Widget _navIcon(IconData icon, bool isActive) {
    return Container(
      decoration: BoxDecoration(
        color: isActive ? Colors.lightGreen : Colors.transparent,
        shape: BoxShape.circle,
      ),
      padding: const EdgeInsets.all(8),
      child: Icon(icon, color: isActive ? Colors.white : Colors.black),
    );
  }
}
