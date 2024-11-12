import 'package:dio/dio.dart';

class UserRepository {
  final Dio dio = Dio();

  Future<bool> doLogin(
    String email,
    String senha,
  ) async {
    // Retorna true ou false
    var url = "http://192.168.1.161:8080/api/usuario/login";
    Response response = await dio.post(url,
        data: {"Email": email, "Senha": senha},
        options: Options(contentType: "application/x-www-form-urlencoded"));

    if (response.statusCode == 200) {
      // Se as credenciais de Login forem válidas, vai validar o login
      return response.data;
    } else {
      // Se não for válido, retorna um erro
      throw Exception('Não foi possível fazer Login');
    }
  }
}
