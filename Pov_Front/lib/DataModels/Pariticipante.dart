class Participante {
  final int id;
  final String Nome;
  final String Email;
  final int Documento;
  final int NumContato;
  final String Endereco;
  final bool Fornecedor;

  Participante({
    required this.id,
    required this.Nome,
    required this.Email,
    required this.Documento,
    required this.NumContato,
    required this.Endereco,
    required this.Fornecedor
  });

  factory Participante.fromJson(Map<String, dynamic> json) {
    return Participante(
      id: json['id'],
      Nome: json['Nome'],
      Email: json['Email'],
      Documento: json['Documento'],
      NumContato: json['NumContato'],
      Endereco: json['Endereco'],
      Fornecedor: json['Fornecedor'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id' : id,
      'Nome': Nome,
      'Email': Email,
      'Documento': Documento,
      'NumContato': NumContato,
      'Endereco': Endereco,
      'Fornecedor': Fornecedor,
    };
  }
}
