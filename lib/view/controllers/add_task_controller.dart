import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:practice_todoapp/view/model/task_model.dart';

class AddTaskController extends GetxController {
  var isLoading = false.obs;
  var tasks = <TaskData>[].obs;
  final _storage = GetStorage();
  final _storageKey = 'tasks';

  @override
  void onInit() {
    super.onInit();
    fetchTasks();
  }

  void fetchTasks() {
    isLoading.value = true;
    final storedTasks = _storage.read<List<dynamic>>(_storageKey);
    if (storedTasks != null) {
      tasks.value = storedTasks.map((e) => TaskData.fromJson(e)).toList();
    } else {
      tasks.clear();
    }
    isLoading.value = false;
  }

  void saveTasksToStorage() {
    final jsonList = tasks.map((e) => e.toJson()).toList();
    _storage.write(_storageKey, jsonList);
  }

  void addTask(TaskData newTask) {
    tasks.add(newTask);
    saveTasksToStorage();
  }

  void updateTask(int index, TaskData updatedTask) {
    if (index >= 0 && index < tasks.length) {
      tasks[index] = updatedTask;
      tasks.refresh(); // trigger UI rebuild
      saveTasksToStorage(); // also persist the update
    }
  }

  // ✅ Add this method for deleting a task
  void deleteTask(int index) {
    if (index >= 0 && index < tasks.length) {
      tasks.removeAt(index);
      saveTasksToStorage(); // save after deletion
    }
  }
}
