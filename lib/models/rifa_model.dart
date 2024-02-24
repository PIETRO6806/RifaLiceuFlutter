class Rifa {
  int numeroRifa;
  String nome;
  String telefone;
  String pagamento;
  String vendedor;

  // Constructor with named parameters
  Rifa({
    this.numeroRifa = 0,
    this.nome = "",
    this.telefone = "",
    this.pagamento = "",
    this.vendedor = "",
  });

  // Factory constructor to create an instance from a Map
  factory Rifa.fromMap(Map<String, dynamic> map) {
    return Rifa(
      numeroRifa: map['numeroRifa'] ?? 0,
      nome: map['nome'] ?? "",
      telefone: map['telefone'] ?? "",
      pagamento: map['pagamento'] ?? "",
      vendedor: map['vendedor'] ?? "",
    );
  }

  // Convert the object to a Map
  Map<String, dynamic> toMap() {
    return {
      'numeroRifa': numeroRifa,
      'nome': nome,
      'telefone': telefone,
      'pagamento': pagamento,
      'vendedor': vendedor,
    };
  }
}
