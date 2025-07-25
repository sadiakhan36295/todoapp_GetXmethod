import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditTaskController extends GetxController {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final currentIndex = 1.obs;

  int? taskIndex;

  void loadTaskData({
    required String title,
    required String description,
    required int index,
  }) {
    titleController.text = title;
    descriptionController.text = description;
    taskIndex = index;
    currentIndex.value = 1; // optional: if you want to reset nav
  }

  Map<String, dynamic> get updatedTask => {
    'title': titleController.text.trim(),
    'description': descriptionController.text.trim(),
    'index': taskIndex,
  };

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    super.onClose();
  }
}
