import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:practice_todoapp/utils/routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // ✅ Required for async init
  await GetStorage.init(); // ✅ Initialize GetStorage
  runApp(const MyApp());   // ✅ Start the app
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Todo App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: AppRoutes.splash, // ✅ Start with splash screen
      getPages: AppRoutes.routes,     // ✅ Define your named routes
    );
  }
}
