import 'package:flutter/material.dart';
import 'package:rifa_liceu_flutter/api/api_service.dart';
import 'package:rifa_liceu_flutter/utils/user_preferences.dart';

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
      drawer: UserPreferencesDrawer(), // Adding UserPreferencesDrawer to the drawer
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

class UserPreferencesDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Informações',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
                SizedBox(height: 8.0),
                FutureBuilder<Map<String, dynamic>>(
                  future: UserPreferences.getUserInfo(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error loading user information');
                    } else {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Olá, ${snapshot.data?['userName'] ?? ''}.',
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            'Você vendeu ${snapshot.data?['userRifas'] ?? 0} rifas.',
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// The rest of the code remains unchanged
