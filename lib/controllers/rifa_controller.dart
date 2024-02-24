import 'package:get/get.dart';
import 'package:rifa_liceu_flutter/models/rifa_model.dart'; // Import your Rifa model
import 'package:rifa_liceu_flutter/api/api_service.dart'; // Import your ApiService

class RifaController extends GetxController {
  // Reactive variables for Rifa data
  var nome = ''.obs;
  var telefone = ''.obs;
  var formaPagamento = ''.obs;
  var vendedor = ''.obs;

  // Method to add a new Rifa
  Future<void> addNewRifa(int numeroRifa) async {
    // Create a Rifa object with the filled data
    Rifa newRifa = Rifa(
      numeroRifa: numeroRifa,
      nome: nome.value,
      telefone: telefone.value,
      pagamento: formaPagamento.value,
      vendedor: vendedor.value,
    );

    // Call the ApiService to add the new Rifa
    bool result = await ApiService.addNewRifa(newRifa);

    if (result) {
      // Rifa added successfully
      Get.snackbar('Success', 'Rifa added successfully');
      // Navigate back to the home page
      Get.offAllNamed('/home'); // Replace '/home' with the actual route of your home page
    } else {
      // Failed to add Rifa
      Get.snackbar('Error', 'Failed to add Rifa');
    }
  }

  // Method to set Rifa fields
  void setRifaFields(String nome, String telefone, String formaPagamento, String vendedor) {
    this.nome.value = nome;
    this.telefone.value = telefone;
    this.formaPagamento.value = formaPagamento;
    this.vendedor.value = vendedor;
  }
}

