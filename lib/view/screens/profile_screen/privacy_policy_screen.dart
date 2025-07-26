import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Keep Get for Get.to/Get.back if you use them for navigation

class PrivacyPolicyScreen extends StatelessWidget {
  PrivacyPolicyScreen({super.key});

  // Local RxInt to manage the active state of the bottom navigation bar for this screen.
  // Assumes 'My Tasks' (index 0) is the default active state or the screen from which this might be commonly accessed.
  final RxInt _currentIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          'Privacy Policy',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Privacy Policy - Task Manager App'),
            const SizedBox(height: 8),
            _buildParagraph(
              'Your privacy is important to us. This Privacy Policy outlines how the Task Manager App handles your information and protects your data.',
            ),
            const SizedBox(height: 20),
            _buildSectionTitle('1. Information Collection'),
            const SizedBox(height: 8),
            _buildParagraph(
              'The Task Manager App may collect limited information such as your name, email address, and preferences, strictly for the purpose of enhancing your task management experience. We do not collect sensitive personal information unnecessarily.',
            ),
            const SizedBox(height: 20),
            _buildSectionTitle('2. Local Storage'),
            const SizedBox(height: 8),
            _buildParagraph(
              'Your tasks, subtasks, and user preferences are securely stored in our system or locally on your device (depending on platform settings). This data is used solely to support the app\'s features like scheduling, notifications, and user customization.',
            ),
            const SizedBox(height: 20),
            _buildSectionTitle('3. No Tracking'),
            const SizedBox(height: 8),
            _buildParagraph(
              'We do not use third-party trackers or intrusive analytics tools to monitor your behavior. Any performance monitoring is strictly anonymized and used internally to improve the app experience.',
            ),
            const SizedBox(height: 20),
            _buildSectionTitle('4. Static Data Display'),
            const SizedBox(height: 8),
            _buildParagraph(
              'If the app integrates with external tools (e.g., calendar, cloud storage), those services are governed by their own privacy policies. We do not control or assume responsibility for their data handling practices.',
            ),
            const SizedBox(height: 20),
            _buildSectionTitle('5. Third-Party Services'),
            const SizedBox(height: 8),
            _buildParagraph(
              'We implement industry-standard measures to ensure your information is protected from unauthorized access, alteration, or misuse. This includes encryption, secure servers, and routine maintenance.',
            ),
            const SizedBox(height: 20),
            _buildSectionTitle('6. Data Security'),
            const SizedBox(height: 8),
            _buildParagraph(
              'You retain full control over your account data. You can delete or export your tasks and personal information at any time through your profile settings (if applicable).',
            ),
            const SizedBox(height: 20),
            _buildSectionTitle('7. Policy Updates'),
            const SizedBox(height: 8),
            _buildParagraph(
              'This Privacy Policy may be updated periodically. Any changes will be clearly communicated within the app. Continued use after updates indicates your acceptance of the revised policy.',
            ),
            const SizedBox(height: 20),
            _buildParagraph(
              'If you have any questions or concerns regarding privacy, please contact us at support@taskmanagerapp.com.',
            ),
            const SizedBox(height: 40), // Spacing before bottom nav
          ],
        ),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          backgroundColor: Colors.white,
          currentIndex: _currentIndex.value, // Use local RxInt for visual state
          onTap: (index) {
            _currentIndex.value = index; // Update local state
            // Handle navigation based on index
            if (index == 0) {
              Navigator.popUntil(context, (route) => route.isFirst); // Go back to the root (My Tasks)
            } else if (index == 1) {
              // Navigate to Add Task
              // Get.to(() => AddTaskScreen()); // Example
            } else if (index == 2) {
              // Navigate to Profile screen (if applicable)
              // Get.to(() => ProfileScreen()); // Example
            }
          },
          items: [
            _buildBottomNavItem(Icons.home, "My Tasks", 0, _currentIndex.value),
            _buildBottomNavItem(Icons.add, "Add Task", 1, _currentIndex.value),
            _buildBottomNavItem(Icons.person, "Profile", 2, _currentIndex.value),
          ],
          selectedLabelStyle: const TextStyle(color: Colors.black),
          unselectedLabelStyle: const TextStyle(color: Colors.black),
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.black,
          showSelectedLabels: true,
          showUnselectedLabels: true,
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }

  Widget _buildParagraph(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 14,
        height: 1.5,
        color: Colors.black87,
      ),
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