import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rifa_liceu_flutter/controllers/rifa_controller.dart';
import 'package:rifa_liceu_flutter/utils/user_preferences.dart'; // Replace with your actual package name

class RifaPage extends StatefulWidget {
  @override
  _RifaPageState createState() => _RifaPageState();
}

class _RifaPageState extends State<RifaPage> {
  final RifaController rifaController = Get.put(RifaController());
  // Additional controllers for the input fields
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController telefoneController = TextEditingController();
  String? formaPagamento; // Default value for Forma de Pagamento is null
  final TextEditingController vendedorController = TextEditingController();

  bool isButtonEnabled() {
    // Check if all required fields are filled
    return nomeController.text.isNotEmpty &&
        telefoneController.text.isNotEmpty &&
        vendedorController.text.isNotEmpty &&
        formaPagamento != null; // Forma de Pagamento must be selected;
  }

  @override
  void initState() {
    super.initState();
    // Fetch user information and set Vendedor controller
    setUserInformation();
  }

  Future<void> setUserInformation() async {
    Map<String, dynamic> userInfo = await UserPreferences.getUserInfo();
    String userName = userInfo['userName'] ?? '';

    setState(() {
      // Set the username as read-only in the Vendedor controller
      vendedorController.text = userName;
    });
  }

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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Número da Rifa: $index',
              style: TextStyle(fontSize: 24.0),
            ),
            SizedBox(height: 20.0),
            // Input field for Nome
            TextFormField(
              controller: nomeController,
              decoration: InputDecoration(labelText: 'Nome:'),
            ),
            SizedBox(height: 10.0),
            // Input field for Telefone
            TextFormField(
              controller: telefoneController,
              keyboardType: TextInputType.phone, // Set the keyboard type to phone
              decoration: InputDecoration(labelText: 'Telefone:'),
            ),
            SizedBox(height: 10.0),
            // Radio buttons for Forma de Pagamento
            Text('Forma de Pagamento:'),
            Row(
              children: [
                Radio(
                  value: 'Pix',
                  groupValue: formaPagamento,
                  onChanged: (value) {
                    setState(() {
                      formaPagamento = value as String;
                    });
                  },
                ),
                Text('Pix'),
                Radio(
                  value: 'Dinheiro',
                  groupValue: formaPagamento,
                  onChanged: (value) {
                    setState(() {
                      formaPagamento = value as String;
                    });
                  },
                ),
                Text('Dinheiro'),
              ],
            ),
            SizedBox(height: 10.0),
            // Input field for Vendedor's name
            TextFormField(
              controller: vendedorController,
              decoration: InputDecoration(
                labelText: "Vendedor:",
                enabled: false, // Make the field read-only
              ),
            ),
            SizedBox(height: 20.0),
            // Button to confirm venda
            ElevatedButton(
              onPressed: isButtonEnabled()
                  ? () {
                // Pass the filled values to RifaController
                rifaController.setRifaFields(
                  nomeController.text,
                  telefoneController.text,
                  formaPagamento!,
                  vendedorController.text,
                );

                // Perform venda confirmation logic here
                int rifaNumber = index; // Replace with your actual Rifa number
                rifaController.addNewRifa(rifaNumber);
              }
                  : null,
              child: Text('Confirmar Venda'),
            ),
          ],
        ),
      ),
    );
  }
}
