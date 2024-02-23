import 'package:flutter/material.dart';
import 'rifa.dart'; // Import the new page

class HomePage extends StatelessWidget {
  const HomePage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Rifa Campanha de Ovos',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: GridView.builder(
          key: PageStorageKey('myGridView'),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
          itemCount: 1500,
          itemBuilder: (context, index) {
            return ClickableCard(index: index + 1);
          },
        ),
      ),
    );
  }
}

class ClickableCard extends StatelessWidget {
  final int index;

  ClickableCard({required this.index});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to RifaPage and pass the selected index
        Navigator.pushNamed(context, '/rifa', arguments: index);
      },
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(width: 2.0, color: Colors.black),
        ),
        child: Center(
          child: Text(
            '$index',
            style: TextStyle(fontSize: 24.0),
          ),
        ),
      ),
    );
  }
}