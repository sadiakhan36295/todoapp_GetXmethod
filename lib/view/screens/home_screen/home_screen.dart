import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practice_todoapp/view/controllers/add_task_controller.dart';
import 'package:practice_todoapp/view/model/task_model.dart';
import 'package:practice_todoapp/view/screens/add_task_screen/add_task_screen.dart';
import 'package:practice_todoapp/view/screens/auth/verify_email/verify_email_screen.dart';
import 'package:practice_todoapp/view/widgets/custom_container/custom_container.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AddTaskController taskController = Get.put(AddTaskController());
  int currentIndex = 0;

  Future<void> _navigateToAddTask() async {
    final result = await Navigator.push<Map<String, String>>(
      context,
      MaterialPageRoute(builder: (context) => const AddTaskScreen()),
    );

    if (result != null) {
      final newTask = TaskData(
        title: result['title'],
        description: result['description'],
      );
      taskController.addTask(newTask);
    }
  }

  @override
  void initState() {
    super.initState();
    taskController.fetchTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // ✅ Fix bottom overflow when keyboard appears
      backgroundColor: const Color.fromRGBO(250, 250, 250, 1),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ✅ Use correct image asset path
            SizedBox(
              width: double.infinity,
              height: 100,
              child: Image.asset(
                'assets/images/user.jpeg', // Make sure this file exists and path is correct in pubspec.yaml
                fit: BoxFit.cover,
              ),
            ),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Text(
                "My Tasks",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // ✅ Task List
            Expanded(
              child: Obx(() {
                if (taskController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (taskController.tasks.isEmpty) {
                  return Center(
                    child: Text(
                      "No tasks to display.",
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: taskController.tasks.length,
                  itemBuilder: (context, index) {
                    final task = taskController.tasks[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: CustomContainer(
                        title: task.title ?? '',
                        description: task.description ?? '',
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),

      // ✅ Bottom Navigation
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.grey,
        currentIndex: currentIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: "Add Task"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
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
              MaterialPageRoute(builder: (context) => const VerifyEmailScreen()),
            );
          }
        },
      ),
    );
  }
}
