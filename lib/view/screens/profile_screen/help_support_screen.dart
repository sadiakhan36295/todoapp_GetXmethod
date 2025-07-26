import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Keep Get for Get.to/Get.back if you use them for navigation
import 'package:url_launcher/url_launcher.dart'; // To open email client

class HelpSupportScreen extends StatelessWidget {
  HelpSupportScreen({super.key});

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
          'Help/Support',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'FAQs',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            _FAQItem(
              question: 'How do I create a new task?',
              answer:
                  'Tap the "Add Task" button on the navigation bar. Fill in the task title, due date, priority, and other details — then tap "Save".',
            ),
            _FAQItem(
              question: 'How can I view task details?',
              answer:
                  'Tap on any task from your main task list to open its detailed view, where you can see all associated information.',
            ),
            _FAQItem(
              question: 'Can I mark a task as favorite or important?',
              answer:
                  'Yes, within the task details screen, you\'ll find an option (e.g., a star icon or toggle) to mark tasks as favorite or important for easy filtering.',
            ),
            _FAQItem(
              question: 'How do I edit or delete a task?',
              answer:
                  'To edit, tap on a task to view its details, then select the "Edit" option (e.g., a pencil icon). To delete, either long-press on a task in the list or find the "Delete" option within its details view.',
            ),
            _FAQItem(
              question: 'Is my data secure?',
              answer:
                  'Yes, we implement industry-standard security measures to protect your data. All sensitive information is encrypted, and we adhere to strict privacy policies. Please refer to our Privacy Policy for more details.',
            ),
            const SizedBox(height: 30),
            const Text(
              'Need More Help?',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            _buildMailUsSection(context),
            const SizedBox(height: 40), // Spacing before bottom nav
          ],
        ),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          backgroundColor: Colors.white,
          currentIndex: _currentIndex.value,
          onTap: (index) {
            _currentIndex.value = index;
            // Handle navigation based on index
            if (index == 0) {
              Navigator.popUntil(context, (route) => route.isFirst); // Go back to the root (My Tasks)
            } else if (index == 1) {
              // Navigate to Add Task
              // Get.to(() => AddTaskScreen());
            } else if (index == 2) {
              // Navigate to Profile screen (if applicable)
              // Get.to(() => ProfileScreen());
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

  Widget _buildMailUsSection(BuildContext context) {
    const String email = 'support@taskmanagerapp.com';
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white60,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300), // Optional: Add a light border
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.lightGreen.withOpacity(0.1), // Light green background for icon
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(12),
            child: const Icon(Icons.headset_mic, color: Colors.lightGreen, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Mail Us: ',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    final Uri emailLaunchUri = Uri(
                      scheme: 'mailto',
                      path: email,
                      queryParameters: {
                        'subject': 'Support Request for Task Manager App',
                      },
                    );
                    if (await canLaunchUrl(emailLaunchUri)) {
                      await launchUrl(emailLaunchUri);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Could not launch email client.')),
                      );
                    }
                  },
                  child: const Text(
                    email,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.lightGreen, // Make it look clickable
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Our help desk is available 24/7 to support your workflow.',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
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

// A StatefulWidget for each FAQ item to manage its own expansion state
class _FAQItem extends StatefulWidget {
  final String question;
  final String answer;

  const _FAQItem({
    required this.question,
    required this.answer,
  });

  @override
  State<_FAQItem> createState() => _FAQItemState();
}

class _FAQItemState extends State<_FAQItem> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white60,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          ListTile(
            title: Text(
              widget.question,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            trailing: Icon(
              _isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
              color: Colors.lightGreen,
            ),
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
          ),
          if (_isExpanded)
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
              child: Text(
                widget.answer,
                style: const TextStyle(
                  fontSize: 14,
                  height: 1.5,
                  color: Colors.black54,
                ),
              ),
            ),
        ],
      ),
    );
  }
}