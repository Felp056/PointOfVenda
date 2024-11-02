import 'dart:ffi';

class NewLogin{
  final Long IdAcesso;
  final String Email;
  final String Senha;
  final int NivelAcesso;

  NewLogin({
      required this.IdAcesso,
      required this.Email,
      required this.Senha,
      required this.NivelAcesso
  });


  factory NewLogin.FromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
      'IdAcesso': Long IdAcesso,
      'Email': String Email,
      'Senha': String Senha,
      'NivelAceso': int NivelAcesso
      } =>
          NewLogin(
            IdAcesso: IdAcesso,
            Email: Email,
            Senha: Senha,
            NivelAcesso: NivelAcesso
          ),
      _ => throw const FormatException('Failed to fetch data.'),
    };
  }
}

class login{
  final String Email;
  final String Senha;

  login({
    required this.Email,
    required this.Senha,
  });

  factory login.FromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
      'Email': String Email,
      'Senha': String Senha,
      } =>
          login(
              Email: Email,
              Senha: Senha,
          ),
      _ => throw const FormatException('Failed to login.'),
    };
  }
}