class Cliente {
  final int idCliente;
  final String nome;
  final String documento;
  final String endereco;
  String? contato;
  String? email;
  bool? isFornecedor;

  Cliente({
    required this.idCliente,
    required this.nome,
    required this.documento,
    required this.endereco,
    this.contato,
    this.email,
    this.isFornecedor = false,
  });

  factory Cliente.fromJson(Map<String, dynamic> json) {
    return Cliente(
      idCliente: json['idCliente'],
      nome: json['nome'],
      documento: json['documento'],
      endereco: json['endereco'],
      contato: json['contato'],
      email: json['email'],
      isFornecedor: json['fornecedor'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idCliente': idCliente,
      'nome': nome,
      'documento': documento,
      'endereco': endereco,
      'contato': contato,
      'email': email,
      'fornecedor': isFornecedor
    };
  }
}
