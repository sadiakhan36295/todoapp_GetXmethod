import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practice_todoapp/view/controllers/edit_task_controller.dart';
import 'package:practice_todoapp/view/widgets/custom_button/custom_button.dart';

class EditTaskScreen extends StatelessWidget {
  final String initialTitle;
  final String initialDescription;
  final int taskIndex;

  EditTaskScreen({
    super.key,
    required this.initialTitle,
    required this.initialDescription,
    required this.taskIndex,
  });

  final EditTaskController controller = Get.put(EditTaskController());

  @override
  Widget build(BuildContext context) {
    // Load task data once
    controller.loadTaskData(
      title: initialTitle,
      description: initialDescription,
      index: taskIndex,
    );

    return Scaffold(
      resizeToAvoidBottomInset: true,
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
          'Edit Task',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Task Title',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white60,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: controller.titleController,
                style: const TextStyle(color: Colors.black),
                decoration: const InputDecoration(
                  hintText: 'e.g. Design Landing Page Header',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Description',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white60,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: controller.descriptionController,
                maxLines: 5,
                style: const TextStyle(color: Colors.black),
                decoration: const InputDecoration(
                  hintText: 'e.g. Include logo, navigation, and CTA button with brand color',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 40),
            CustomButton(
              title: 'Update Task',
              onTap: () {
                if (controller.titleController.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please enter a task title')),
                  );
                  return;
                }
                Navigator.pop(context, controller.updatedTask);
              },
              titleColor: Colors.white,
              backgroundColor: Colors.lightGreen,
              fillColor: Colors.lightGreen,
              height: 50,
              width: double.infinity,
              marginVerticel: 0,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            backgroundColor: Colors.white,
            currentIndex: controller.currentIndex.value,
            onTap: (index) {
              controller.currentIndex.value = index;
              if (index == 0) Navigator.pop(context);
            },
            items: [
              BottomNavigationBarItem(
                icon: Container(
                  decoration: BoxDecoration(
                    color: Colors.lightGreen,
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(8),
                  child: const Icon(Icons.home, color: Colors.white),
                ),
                label: "",
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.add, color: Colors.black),
                label: "Add Task",
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.person, color: Colors.black),
                label: "Profile",
              ),
            ],
            selectedLabelStyle: const TextStyle(color: Colors.black),
            unselectedLabelStyle: const TextStyle(color: Colors.black),
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.black,
          )),
    );
  }
}
