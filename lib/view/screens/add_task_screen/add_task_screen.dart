import 'package:flutter/material.dart';
import 'package:practice_todoapp/view/widgets/custom_button/custom_button.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  void _saveTask() {
    final title = titleController.text.trim();
    final description = descriptionController.text.trim();

    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a task title')),
      );
      return;
    }

    final newTask = {
      'title': title,
      'description': description,
    };

    Navigator.pop(context, newTask); // Send task back to HomeScreen
  }

  @override
  Widget build(BuildContext context) {
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
          'Add Task',
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
                controller: titleController,
                style: const TextStyle(color: Colors.black),
                decoration: const InputDecoration(
                  hintText: ' e.g. Design Landing Page Header ',
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
                controller: descriptionController,
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
              title: 'Save Task',
              onTap: _saveTask,
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
     bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
  currentIndex: 1, // Hardcoded to Add Task tab
  onTap: (index) {
    if (index == 0) {
      Navigator.pop(context); // Go back to Home
    }
  },
  items: [
    const BottomNavigationBarItem(
      icon: Icon(Icons.home, color: Colors.black),
      label: "My tasks",
    ),
    BottomNavigationBarItem(
  icon: Transform.translate(
    offset: const Offset(0, -12), // Move the icon 10 pixels up
    child: Container(
      padding: const EdgeInsets.all(14), // Bigger padding for bigger circle
      decoration: const BoxDecoration(
        color: Colors.lightGreen, // Circle background color
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.add,
        color: Colors.white,
        size: 28, // Bigger icon size
      ),
    ),
  ),
  label: "",
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
),

    );
  }
}
