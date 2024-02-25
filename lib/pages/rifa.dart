import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rifa_liceu_flutter/controllers/rifa_controller.dart';
import 'package:rifa_liceu_flutter/models/rifa_model.dart';
import 'package:rifa_liceu_flutter/utils/user_preferences.dart';
import 'package:rifa_liceu_flutter/api/api_service.dart';

class RifaPage extends StatefulWidget {
  @override
  _RifaPageState createState() => _RifaPageState();
}

class _RifaPageState extends State<RifaPage> {
  final RifaController rifaController = Get.put(RifaController());
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController telefoneController = TextEditingController();
  String? formaPagamento;
  final TextEditingController vendedorController = TextEditingController();
  final FocusNode nomeFocus = FocusNode();
  final FocusNode telefoneFocus = FocusNode();
  final FocusNode vendedorFocus = FocusNode();

  bool isLoading = false;
  late int index; // Declare index at class level

  bool isButtonEnabled() {
    return nomeController.text.isNotEmpty &&
        telefoneController.text.isNotEmpty &&
        vendedorController.text.isNotEmpty &&
        formaPagamento != null;
  }

  @override
  void initState() {
    super.initState();
    setUserInformation();
  }

  @override
  void didUpdateWidget(covariant RifaPage oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Reset the state when the widget is updated
    setUserInformation();
  }

  Future<void> setUserInformation() async {
    Map<String, dynamic> userInfo = await UserPreferences.getUserInfo();
    String userName = userInfo['userName'] ?? '';

    setState(() {
      vendedorController.text = userName;
    });
  }

  Future<void> fetchRifaDetails(int rifaNumber) async {
    try {
      Rifa? rifa = await ApiService.getRifaByNumero(rifaNumber);

      if (rifa != null) {
        setState(() {
          nomeController.text = rifa.nome;
          telefoneController.text = rifa.telefone;
          vendedorController.text = rifa.vendedor;
          formaPagamento = rifa.pagamento;

          nomeFocus.canRequestFocus = false;
          telefoneFocus.canRequestFocus = false;
          vendedorFocus.canRequestFocus = false;
        });
      }
    } catch (e) {
      print('Error fetching Rifa details: $e');
    }
  }

  Future<void> handleConfirmarVenda() async {
    setState(() {
      isLoading = true;
    });

    try {
      rifaController.setRifaFields(
        nomeController.text,
        telefoneController.text,
        formaPagamento!,
        vendedorController.text,
      );

      // Use the class-level index here
      await rifaController.addNewRifa(index);

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Success'),
          content: Text('Sale confirmed successfully.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  isLoading = false;
                });
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    } catch (e) {
      print('Error confirming sale: $e');

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Failed to confirm sale. Please try again.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  isLoading = false;
                });
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments =
    ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    index = arguments['index'] ?? 0; // Assign the value to the class-level index
    final bool isSold = arguments['isSold'] ?? false;

    if (isSold) {
      fetchRifaDetails(index);
    }

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
            TextFormField(
              controller: nomeController,
              decoration: InputDecoration(labelText: 'Nome:'),
              readOnly: isSold,
              focusNode: nomeFocus,
            ),
            SizedBox(height: 10.0),
            TextFormField(
              controller: telefoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(labelText: 'Telefone:'),
              readOnly: isSold,
              focusNode: telefoneFocus,
            ),
            SizedBox(height: 10.0),
            Text('Forma de Pagamento:'),
            Row(
              children: [
                Radio(
                  value: 'Pix',
                  groupValue: formaPagamento,
                  onChanged: isSold
                      ? null
                      : (value) {
                    setState(() {
                      formaPagamento = value as String;
                    });
                  },
                ),
                Text('Pix'),
                Radio(
                  value: 'Dinheiro',
                  groupValue: formaPagamento,
                  onChanged: isSold
                      ? null
                      : (value) {
                    setState(() {
                      formaPagamento = value as String;
                    });
                  },
                ),
                Text('Dinheiro'),
              ],
            ),
            SizedBox(height: 10.0),
            TextFormField(
              controller: vendedorController,
              decoration: InputDecoration(
                labelText: "Vendedor:",
                enabled: false,
              ),
              focusNode: vendedorFocus,
            ),
            if (isSold)
              Column(
                children: [
                  SizedBox(height: 20.0),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Center(
                      child: Text(
                        'VENDIDO',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: isButtonEnabled() && !isSold
                  ? () {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => AlertDialog(
                    content: Row(
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(width: 16.0),
                        Text('Confirming sale...'),
                      ],
                    ),
                  ),
                );

                handleConfirmarVenda();
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
