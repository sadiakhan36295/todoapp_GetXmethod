import 'package:flutter/material.dart';
import 'package:practice_todoapp/view/screens/add_task_screen/add_task_screen.dart';
import 'package:practice_todoapp/view/screens/auth/verify_email/verify_email_screen.dart';
// Add this import
import 'package:practice_todoapp/view/widgets/custom_container/custom_container.dart'; // Assuming you want to reuse this for task cards
import 'package:practice_todoapp/view/widgets/custom_text/custom_text.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  // Store tasks here
  List<Map<String, String>> tasks = [];

  Future<void> _navigateToAddTask() async {
    final result = await Navigator.push<Map<String, String>>(
      context,
      MaterialPageRoute(builder: (context) => const AddTaskScreen()),
    );

    if (result != null) {
      setState(() {
        tasks.add(result);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Color(0xFFFAFAFA),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with avatar and greeting
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 24,
                    backgroundImage: AssetImage('assets/images/user.png'), // Replace with your asset
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      CustomText(text: "Hello Mojahid", fontSize: 16, fontWeight: FontWeight.w600),
                      CustomText(text: "Welcome to Task Manager", fontSize: 14, color: Colors.grey),
                    ],
                  ),
                ],
              ),
            ),

            // My Tasks title
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: CustomText(
                text: "My Tasks",
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            // Show tasks list or "no tasks" message
            Expanded(
              child: tasks.isEmpty
                  ? Center(
                      child: Text(
                        "No tasks to display.",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        final task = tasks[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: CustomContainer(
                            title: task['title'] ?? '',
                            description: task['description'] ?? '',
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.grey,
        currentIndex: currentIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ""),
        ],
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });

          if (index == 1) {
            _navigateToAddTask();
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const VerifyEmailScreen(),
              ),
            );
          }
        },
      ),
    );
  }
}
