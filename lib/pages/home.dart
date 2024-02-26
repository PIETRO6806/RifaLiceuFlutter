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
  int totalNumberOfRifas = 0;

  @override
  void initState() {
    super.initState();
    _loadSoldRifaNumbers();
    _loadTotalNumberOfRifas();
  }

  Future<void> _loadTotalNumberOfRifas() async {
    final int totalRifas = await ApiService.getNumberOfRifas();
    setState(() {
      totalNumberOfRifas = totalRifas;
    });
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
      drawer: UserPreferencesDrawer(
        totalNumberOfRifas: totalNumberOfRifas,
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

class UserPreferencesDrawer extends StatelessWidget {
  final int totalNumberOfRifas;

  UserPreferencesDrawer({required this.totalNumberOfRifas});

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
                  '3ª Série A (EM)',
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
          ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total de rifas vendidas:',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 8.0),
                Center(
                  child: Text(
                    '$totalNumberOfRifas',
                    style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            onTap: () {
              // Handle tap if needed
            },
          ),
          SizedBox(height: 0), // Add some spacing
          Center(
            child: Text(
              'Prêmio:',
              style: TextStyle(fontSize: 20),
            ),
          ),
          SizedBox(height: 0), // Add some spacing
          Center(
            child: Text(
              'Box com ovo trufado e nove pães de mel da Santa Chocolateria',
              style: TextStyle(fontSize: 15),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 20), // Add some spacing
          Center(
            child: Text(
              'Compras até dia 17 de março.',
              style: TextStyle(fontSize: 15),
            ),
          ),
          SizedBox(height: 8.0),
          Center(
            child: Text(
              'Sorteio dia 22 de março.',
              style: TextStyle(fontSize: 15),
            ),
          ),
          SizedBox(height: 8.0),
          Center(
            child: Text(
              '(Apenas UM ganhador)',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w100),
            ),
          ),
          SizedBox(height: 20), // Add some spacing
          Container(
            color: Colors.orange, // Set the background color to orange
            padding: EdgeInsets.all(16.0), // Adjust padding as needed
            child: Center(
              child: Text(
                '5 reais cada rifa ou 3 números por um ovo 150g sem brinquedo',
                style: TextStyle(fontSize: 15, color: Colors.white), // Set text color to white for better visibility
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(height: 60), // Add some spacing
          Center(
            child: Text(
              'Seja o coelhinho',
              style: TextStyle(
                fontSize: 25,
                fontStyle: FontStyle.italic,
                color: Colors.blue,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Center(
            child: Text(
              ' da Páscoa de muitas',
              style: TextStyle(
                fontSize: 25,
                fontStyle: FontStyle.italic,
                color: Colors.blue,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Center(
            child: Text(
              'crianças!',
              style: TextStyle(
                fontSize: 25,
                fontStyle: FontStyle.italic,
                color: Colors.blue,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
