import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practice_todoapp/gen/assets.gen.dart';
import 'package:practice_todoapp/utils/app_colors/app_colors.dart';
import 'package:practice_todoapp/utils/routes/routes.dart';
import 'package:practice_todoapp/view/controllers/add_task_controller.dart';
import 'package:practice_todoapp/view/model/task_model.dart';
import 'package:practice_todoapp/view/screens/add_task_screen/add_task_screen.dart';
import 'package:practice_todoapp/view/screens/auth/verify_email/verify_email_screen.dart';
import 'package:practice_todoapp/view/screens/edit_task_screen/edit_task_screen.dart';
import 'package:practice_todoapp/view/screens/tasks_details/tasks_details_screen.dart';
import 'package:practice_todoapp/view/widgets/custom_container/custom_container.dart';
import 'package:practice_todoapp/view/widgets/custom_user/custom_user.dart';


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
                    return GestureDetector(
                      onTap: () async {
                        final result = await Navigator.push<Map<String, dynamic>>(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TaskDetailsScreen(
                              taskTitle: task.title ?? '',
                              taskDescription: task.description ?? '',
                              taskIndex: index,
                            ),
                          ),
                        );

                        if (result != null) {
                          if (result['action'] == 'delete') {
                            taskController.deleteTask(index);
                          } else if (result['action'] == 'edit') {
                            final updatedTask = TaskData(
                              title: result['title'],
                              description: result['description'],
                            );
                            taskController.updateTask(index, updatedTask);
                          }
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: CustomContainer(
                          title: task.title ?? '',
                          description: task.description ?? '',
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });

          if (index == 0) {
            Get.offNamed(AppRoutes.home);
          } else if (index == 1) {
            _navigateToAddTask();
          } else if (index == 2) {
            Get.toNamed(AppRoutes.profile);
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: currentIndex == 0 ? Colors.lightGreen : Colors.grey[300],
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.home,
                color: currentIndex == 0 ? Colors.white : Colors.black,
              ),
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add,
              color: currentIndex == 1 ? Colors.lightGreen : Colors.black,
            ),
            label: "Add Task",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: currentIndex == 2 ? Colors.lightGreen : Colors.black,
            ),
            label: "Profile",
          ),
        ],
        selectedLabelStyle: const TextStyle(color: Colors.black),
        unselectedLabelStyle: const TextStyle(color: Colors.black),
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        showUnselectedLabels: true,
      ),
    );
  }
}
