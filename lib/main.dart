import 'package:flutter/material.dart';
import 'package:rifa_liceu_flutter/pages/home.dart';
import 'package:rifa_liceu_flutter/pages/rifa.dart'; // Import the new page

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
      home: const HomePage(),
      routes: {
        '/rifa': (context) => RifaPage(), // Define a route for RifaPage
      },
    );
  }
}