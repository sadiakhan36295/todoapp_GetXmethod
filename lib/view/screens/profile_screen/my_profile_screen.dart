import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practice_todoapp/gen/assets.gen.dart';
import 'package:practice_todoapp/view/screens/add_task_screen/add_task_screen.dart';
import 'package:practice_todoapp/view/screens/home_screen/home_screen.dart';

class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 12),

            // Top row with back button, title and edit icon
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _circularButton(Icons.arrow_back_ios_new_rounded, () {
                    Get.back();
                  }),
                  const Text(
                    'My Profile',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  _circularButton(Icons.edit, () {
                    // Handle edit
                  }),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Profile Icon in Center (80x80)
            Center(
              child: Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
               
                 
                  image: DecorationImage(
                    image: Assets.images.myprofilelogo.provider(),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Name
            const Text(
              'Mojahid',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),

            const SizedBox(height: 30),

            // Info Cards
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  _infoCard(Icons.person, "Mojahid Islam"),
                  const SizedBox(height: 12),
                  _infoCard(Icons.email, "Samaltman@gmail.com"),
                  const SizedBox(height: 12),
                  _infoCard(Icons.location_on, "1234 Elm Street, Springfield, IL"),
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

  // Top circular icon button
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
            )
          ],
        ),
        child: Icon(icon, size: 20, color: Colors.lightGreen),
      ),
    );
  }

  // Info tile
  Widget _infoCard(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
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
          Icon(icon, color: Colors.lightGreen),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
