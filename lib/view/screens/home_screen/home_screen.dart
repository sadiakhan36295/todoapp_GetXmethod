import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practice_todoapp/gen/assets.gen.dart';
import 'package:practice_todoapp/utils/app_colors/app_colors.dart';
import 'package:practice_todoapp/view/controllers/add_task_controller.dart';
import 'package:practice_todoapp/view/model/task_model.dart';
import 'package:practice_todoapp/view/screens/add_task_screen/add_task_screen.dart';
import 'package:practice_todoapp/view/screens/auth/verify_email/verify_email_screen.dart';
import 'package:practice_todoapp/view/widgets/custom_container/custom_container.dart';
import 'package:practice_todoapp/view/widgets/custom_user/custom_user.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AddTaskController taskController = Get.put(AddTaskController());

  int currentIndex = 0; // ✅ Fix added here

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
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomUser(
              username: 'Hello Mojahid',
              status: 'Welcome to Task Manager',
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

      /// ✅ Custom full-width bottom container with image
      bottomNavigationBar: BottomNavigationBar(
  backgroundColor: Colors.white,
  currentIndex: currentIndex,
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
  items: [
    /// 🟩 Home Item with Green Circle Icon if selected
    BottomNavigationBarItem(
      icon: Container(
        decoration: BoxDecoration(
          color: currentIndex == 0 ? Colors.lightGreen : Colors.lightGreen,
          shape: BoxShape.circle,
        ),
        padding: const EdgeInsets.all(8),
        child: Icon(
          Icons.home,
          color: currentIndex == 0 ? Colors.white : Colors.white,
        ),
      ),
      label: "",
    ),

    /// ➕ Add Task Item - Always Black Icon
    const BottomNavigationBarItem(
      icon: Icon(Icons.add, color: Colors.black),
      label: "Add Task",
    ),

    /// 👤 Profile Item - Always Black Icon
    const BottomNavigationBarItem(
      icon: Icon(Icons.person, color: Colors.black),
      label: "Profile",
    ),
  ],
  selectedLabelStyle: const TextStyle(color: Colors.black),
  unselectedLabelStyle: const TextStyle(color: Colors.black),
  selectedItemColor: Colors.black,
  unselectedItemColor: Colors.black,
),

    );
  }
}

