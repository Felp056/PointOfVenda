import 'package:dio/dio.dart';
import 'package:pov_web/DataModels/Produto.dart';

class ProdutoRepository {
  final Dio dio = Dio();
  List<Produto> listProdutos = [];

  Future<List<Produto>> getAllProdutos() async {
    var url = "http://192.168.100.113:8080/api/produto/todas";
    Response response = await dio.get(url);

    if (response.statusCode == 200) {
      try {
        for (var produtos in response.data) {
          Produto produto = Produto.fromJson(produtos);
          listProdutos.add(produto);
        }
      } catch (e) {
        throw Exception(e.toString());
      }
    }
    return listProdutos;
  }
}
