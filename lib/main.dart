import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz/utils.dart/binding.dart';
import 'package:quiz/views/quiz_screen/quiz_screen.dart';
import 'package:quiz/views/result_screen/result_screen.dart';
import 'package:quiz/views/welcome_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "quize app",
      debugShowCheckedModeBanner: false,
      initialBinding: MyBinding(),
      getPages: [
        GetPage(
            name: WelcomeScreen.routeName, page: () => const WelcomeScreen()),
        GetPage(name: ResultScreen.routeName, page: () => const ResultScreen()),
        GetPage(name: QuizScreen.routeName, page: () => const QuizScreen()),
      ],
      home: const WelcomeScreen(),
    );
  }
}
