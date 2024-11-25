class Produto {
  final int idProduto;
  final String Descricao;
  final int CodBarras;
  final int QtdDisponivel;
  final String Medida;

  Produto(
      {required this.idProduto,
      required this.Descricao,
      required this.CodBarras,
      required this.QtdDisponivel,
      required this.Medida});

  factory Produto.fromJson(Map<String, dynamic> json) {
    return Produto(
        idProduto: json['idProduto'],
        Descricao: json['Descricao'],
        CodBarras: json['CodBarras'],
        QtdDisponivel: json['QtdDisponivel'],
        Medida: json['Medida']);
  }

  Map<String, dynamic> toJson() {
    return {
      'idProduto': idProduto,
      'Descricao': Descricao,
      'CodBarras': CodBarras,
      'QtdDisponivel': QtdDisponivel,
      'Medida': Medida
    };
  }
}
