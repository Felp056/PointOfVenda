import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DB {
  // construtor com acesso privado
  DB._();
  // Criar uma instancia de DB
  static final DB instance = DB._();
  // Instancia de SQLite
  static Database? _database;

  get database async {
    if (_database != null) {
      return _database;
    }
    return await _initDatabase();
  }

  _initDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'POVMobile.db'),
      version: 1,
      onCreate: _onCreate,
    );
  }

  _onCreate(db, versao) async {
    await db.execute(_pedido);
    await db.execute(_produto);
    await db.execute(_cliente);
  }

  String get _pedido => '''
    CREATE TABLE pedido (
      idPedido INTEGER PRIMARY KEY AUTOINCREMENT,
      valorPedido REAL,
      formaPagamento TEXT,
      creditoDisponivel REAL
    );
  ''';

  String get _produto => '''
    CREATE TABLE produto (
      idProduto INTEGER PRIMARY KEY AUTOINCREMENT,
      descricao TEXT,
      codBarras INTEGER,
      qtdDisponivel INTEGER,
      medida TEXT
    );
  ''';

  String get _cliente => '''
    CREATE TABLE cliente (
      idCliente INTEGER PRIMARY KEY AUNTOINCREMENT,
      nome TEXT,
      endereco TEXT,
      contato TEXT,
      email TEXT,
      isFornecedor BOOL
    );
  ''';
}
