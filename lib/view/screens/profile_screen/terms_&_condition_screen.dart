import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Keep Get for Get.to/Get.back if you use them for navigation

class TermsAndConditionsScreen extends StatelessWidget {
  // Option 1: Pass initial selected index if this screen is always launched from a specific tab
  // final int initialIndex;
  // TermsAndConditionsScreen({super.key, this.initialIndex = 0}); // Default to My Tasks

  TermsAndConditionsScreen({super.key}); // No initialIndex if you're simplifying

  // You can define a local RxInt for the bottom navigation bar's current index
  // if you want this screen to manage its own bottom nav state visually.
  // However, for a simple terms screen, the bottom nav might just reflect
  // the state of the screen it came *from*.
  // For this example, we'll assume 'My Tasks' (index 0) is the default active state
  // or the screen from which this might be commonly accessed.
  final RxInt _currentIndex = 0.obs; // This will manage the state for *this screen's* bottom nav

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
          'Terms & Condition',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Terms & Conditions'),
            const SizedBox(height: 8),
            _buildParagraph(
              'Welcome to the Task Manager App. By accessing or using this application, you agree to the following terms and conditions:',
            ),
            const SizedBox(height: 20),
            _buildSectionTitle('1. Use of the App'),
            const SizedBox(height: 8),
            _buildParagraph(
              'This app is designed to help users create, manage, and track personal or professional tasks efficiently. By using the app, you agree to use it responsibly and only for lawful purposes.',
            ),
            const SizedBox(height: 20),
            _buildSectionTitle('2. Accuracy of Information'),
            const SizedBox(height: 8),
            _buildParagraph(
              'All tasks, notes, and other information entered by the user are stored securely. While we strive to maintain accurate task management functionality, the app is not responsible for missed deadlines, incorrect entries, or user-generated errors.',
            ),
            const SizedBox(height: 20),
            _buildSectionTitle('3. User Responsibility'),
            const SizedBox(height: 8),
            _buildParagraph(
              'Users are solely responsible for managing their tasks, reminders, and any personal or professional outcomes related to the completion or non-completion of tasks created within the app.',
            ),
            const SizedBox(height: 20),
            _buildSectionTitle('4. Data Collection'),
            const SizedBox(height: 8),
            _buildParagraph(
              'We respect your privacy. The Task Manager App may collect limited personal data (such as name, email, and usage patterns) solely for improving user experience. No data is shared with third parties without user consent.',
            ),
            const SizedBox(height: 20),
            _buildSectionTitle('5. Limitation of Liability'),
            const SizedBox(height: 8),
            _buildParagraph(
              'We are not liable for any loss of productivity, missed deadlines, or damages resulting from your use of the app. The app is a productivity tool and should be used at your discretion.',
            ),
            const SizedBox(height: 20),
            _buildSectionTitle('6. Third-Party Links'),
            const SizedBox(height: 8),
            _buildParagraph(
              'If the app connects to any third-party tools (e.g., calendar, email), we are not responsible for their data policies or service availability. Use of such services is subject to their respective terms.',
            ),
            const SizedBox(height: 20),
            _buildSectionTitle('7. Changes to Terms'),
            const SizedBox(height: 8),
            _buildParagraph(
              'We reserve the right to update these Terms & Conditions at any time. Continued use of the app following any changes will constitute your acceptance of those revised terms.',
            ),
            const SizedBox(height: 40), // Spacing before bottom nav
          ],
        ),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          backgroundColor: Colors.white,
          currentIndex: _currentIndex.value, // Use local RxInt
          onTap: (index) {
            _currentIndex.value = index; // Update local state for visual feedback
            // Handle navigation based on index
            if (index == 0) {
              Navigator.popUntil(context, (route) => route.isFirst); // Go back to the root (My Tasks)
            } else if (index == 1) {
              // Navigate to Add Task
              // Get.to(() => AddTaskScreen()); // Example
            } else if (index == 2) {
              // Navigate to Profile screen (if applicable, otherwise keep current)
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