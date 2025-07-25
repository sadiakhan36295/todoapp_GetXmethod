import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practice_todoapp/gen/assets.gen.dart';
import 'package:practice_todoapp/utils/routes/routes.dart';
import 'package:practice_todoapp/view/screens/home_screen/home_screen.dart';
import 'package:practice_todoapp/view/screens/add_task_screen/add_task_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Top banner image
            SizedBox(
              height: 220,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(24),
                ),
                child: Assets.images.profilelogo.image(
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  _buildOptionTile(Icons.person, "My Profile", onTap: () {
                    Get.toNamed(AppRoutes.myProfile);
                  }),
                  _buildOptionTile(Icons.settings, "Account Setting", onTap: () {
                    Get.toNamed(AppRoutes.accountSetting); // ✅ Route added
                  }),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "More",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildOptionTile(Icons.description, "Terms & Condition"),
                  _buildOptionTile(Icons.privacy_tip_outlined, "Privacy Policy"),
                  _buildOptionTile(Icons.help_outline, "Help/Support"),
                  _buildOptionTile(Icons.logout_sharp, "Log Out"),
                ],
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: 2,
        onTap: (index) {
          if (index == 0) {
            Get.offAll(() => const HomeScreen());
          } else if (index == 1) {
            Get.to(() => const AddTaskScreen());
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

  // Updated to accept optional onTap
  Widget _buildOptionTile(IconData icon, String title, {VoidCallback? onTap}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
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
      child: ListTile(
        leading: Icon(icon, color: Colors.lightGreen),
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap ??
            () {
              Get.toNamed(AppRoutes.myProfile);
            },
      ),
    );
  }
}
