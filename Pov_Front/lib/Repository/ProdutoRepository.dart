import 'package:dio/dio.dart';
import 'package:pov_web/DataModels/Produto.dart';

class ProdutoRepository {
  final Dio dio = Dio();
  Produto? produto;

  Future<Produto> getAllProdutos() async {
    var url = "http://192.168.1.9:8080/api/produto/todas";
    Response response = await dio.post(url);

    if (response.statusCode == 200) {}
    return produto;
  }
}
