import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import GetX
import 'package:rifa_liceu_flutter/controllers/register_controller.dart';

import 'package:rifa_liceu_flutter/pages/home.dart';
import 'package:rifa_liceu_flutter/pages/login.dart';
import 'package:rifa_liceu_flutter/pages/register.dart';
import 'package:rifa_liceu_flutter/pages/rifa.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp( // Use GetMaterialApp instead of MaterialApp
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Poppins'),
      initialRoute: '/login',
      getPages: [
        GetPage(
          name: '/login',
          page: () => LoginPage(),
        ),
        GetPage(
          name: '/register',
          page: () => RegisterPage(),
          binding: BindingsBuilder(() {
            // Register the RegisterController when navigating to the RegisterPage
            Get.put(RegisterController());
          }),
        ),
        GetPage(
          name: '/home',
          page: () => HomePage(),
        ),
        GetPage(
          name: '/rifa',
          page: () => RifaPage(),
        ),
      ],
    );
  }
}
