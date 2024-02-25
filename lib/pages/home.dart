import 'package:flutter/material.dart';
import 'package:rifa_liceu_flutter/api/api_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<int> soldRifaNumbers = [];

  @override
  void initState() {
    super.initState();
    _loadSoldRifaNumbers();
  }

  Future<void> _loadSoldRifaNumbers() async {
    final List<int> numbers = await ApiService.getAllSoldRifaNumbers();
    setState(() {
      soldRifaNumbers = numbers;
    });
  }

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
            bool isSold = soldRifaNumbers.contains(index + 1);

            return ClickableCard(
              index: index + 1,
              isSold: isSold,
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/rifa',
                  arguments: {'index': index + 1, 'isSold': isSold},
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class ClickableCard extends StatelessWidget {
  final int index;
  final bool isSold;
  final VoidCallback? onPressed;

  ClickableCard({required this.index, required this.isSold, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Card(
        color: isSold ? Colors.red : Colors.white,
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
