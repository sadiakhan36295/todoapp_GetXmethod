import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountSettingScreen extends StatelessWidget {
  const AccountSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 12),

            // Header with back button and title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  _circularButton(Icons.arrow_back_ios_new_rounded, () {
                    Get.back();
                  }),
                  const SizedBox(width: 8),
                  const Text(
                    "Account Setting",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Options: Change Password & Delete Account
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  _settingTile(
                    icon: Icons.lock_outline,
                    title: "Change Password",
                    iconColor: Colors.lightGreen,
                    onTap: () {
                      // TODO: Implement change password
                    },
                  ),
                  const SizedBox(height: 12),
                  _settingTile(
                    icon: Icons.person_remove_outlined,
                    title: "Delete Account",
                    iconColor: Colors.red,
                    textColor: Colors.red,
                    onTap: () {
                      // TODO: Implement delete account
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: 2,
        onTap: (index) {
          if (index == 0) {
            // Replace with your HomeScreen route
            Get.offAllNamed('/home');
          } else if (index == 1) {
            // Replace with your AddTaskScreen route
            Get.toNamed('/add-task');
          }
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
            label: "",
          ),
        ],
      ),
    );
  }

  // Reusable circular button
  Widget _circularButton(IconData icon, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Icon(icon, size: 20, color: Colors.lightGreen),
      ),
    );
  }

  // Reusable setting tile
  Widget _settingTile({
    required IconData icon,
    required String title,
    required Color iconColor,
    Color? textColor,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              blurRadius: 6,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: iconColor),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  color: textColor ?? Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Icon(Icons.arrow_forward_ios_rounded,
                color: textColor ?? Colors.black, size: 16),
          ],
        ),
      ),
    );
  }
}