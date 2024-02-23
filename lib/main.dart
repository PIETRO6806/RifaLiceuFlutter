import 'package:flutter/material.dart';
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Poppins'),
      initialRoute: '/login', // Set the initial route to login
      routes: {
        '/login': (context) => LoginPage(), // Define a route for LoginPage
        '/register': (context) => RegisterPage(), // Define a route for RegisterPage
        '/home': (context) => HomePage(), // Define a route for HomePage
        '/rifa': (context) => RifaPage(), // Define a route for RifaPage
      },
    );
  }
}