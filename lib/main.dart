import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_test/Controller/controller_choice.dart';
import 'package:quiz_test/Controller/controller_load.dart';
import 'package:quiz_test/Controller/controller_result.dart';
import 'package:quiz_test/Pages/Choice.dart';
import 'package:quiz_test/Pages/Result.dart';
import 'package:quiz_test/Pages/StartPage.dart';
import 'package:quiz_test/Pages/TabNav.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(home: StartPage(), initialRoute: '/', getPages: [
      GetPage(
        name: '/Home',
        page: () => StartPage(),
        binding: BindingsBuilder(() {
          Get.lazyPut<LoadController>(
            () => LoadController(),
          );
        }),
      ),
      GetPage(name: '/Home/choice', page: () => TabNav()),
      GetPage(
        name: '/Home/result',
        page: () => Result(),
        binding: BindingsBuilder(() {
          Get.lazyPut<ResultController>(() => ResultController());
        }),
      )
    ]);
  }
}
