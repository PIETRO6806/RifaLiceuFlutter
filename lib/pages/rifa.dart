import 'package:flutter/material.dart';

class RifaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get the selected index from the arguments
    final int index = ModalRoute.of(context)?.settings.arguments as int ?? 0;

    return Scaffold(
      appBar: AppBar(
        title: Text('Rifa Number $index'),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'You selected number $index',
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}