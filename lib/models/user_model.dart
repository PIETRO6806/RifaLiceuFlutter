class User {
  final String id;
  final String nome;
  final String email;
  final String senha;
  final int qtasRifas;

  // Named constructor for creating a User instance from a Map (e.g., JSON)
  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        nome = json['nome'],
        email = json['email'],
        senha = json['senha'],
        qtasRifas = json['qtasRifas'];

  // Named constructor for creating a User instance with parameters
  User({
    required this.id,
    required this.nome,
    required this.email,
    required this.senha,
    required this.qtasRifas,
  });
}