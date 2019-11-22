import 'dart:core';
import 'dart:io';
import 'package:path/path.dart';
import 'package:praxis/utilidades/globals.dart' as globals;
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class Table<T> {

  final String nome;
  T Function(List<Map<String, dynamic>> response) parse;
  T Function(Map<String, dynamic> response) first;
  T Function(int response) lastid;
  Table({this.nome, this.parse, this.first, this.lastid});

}

class DatabaseHelper {

  static final _databaseName = "px.db";
  static final _databaseVersion = 1;

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    Database foo = await openDatabase(
        path,
        version: _databaseVersion,
        onOpen: (instance) {},
        onCreate: _onCreate
    );
    return foo;
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(globals.APP_DB);
  }

  /// Insere novas linhas no banco de dados
  Future<int> insert(Table table, Map<String, dynamic> row) async {

    Database db = await instance.database;
    return await db.insert(table.nome, row);
  }

  /// Seleciona todas as linhas da tabela
  Future<T> selectAll<T>(Table<T> table) async {
    Database db = await instance.database;
    String nome = table.nome;
    var result = await db.rawQuery('SELECT * FROM $nome;');
    return table.parse(result);
  }

  /// Seleciona todos os Ids de uma tabela específica
  Future<T> selectAllIds<T>(Table<T> table) async {
    Database db = await instance.database;
    String nome = table.nome;
    var result = await db.rawQuery('SELECT id FROM $nome');
    return table.parse(result);
  }

  /// Busca o registro com base no Id
  Future<Table> selectById(Table table, int id) async {
    Database db = await instance.database;
    String nome = table.nome;
    var results = await db.rawQuery('SELECT * FROM $nome WHERE id = $id');
    if (results.length > 0) {
      return table.first(results.first);
    }
    return null;
  }

  /// Atualiza as linhas da tabela
  Future<int> update(Table table, Map<String, dynamic> row, int id) async {
    Database db = await instance.database;

    // returns num rows updated
    return await db.update(
        table.nome,
        row,
        where: 'id = $id'
    );
  }

  /// Remove linhas da tabela
  Future<int> delete(Table table, int id) async {
    Database db = await instance.database;
    String nome = table.nome;
    return await db.rawDelete('DELETE FROM $nome WHERE id = $id');
  }

  /// Conta a quantidade de linhas na tabela
  Future<int> rowCount(Table table) async {
    Database db = await instance.database;
    String nome = table.nome;
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(1) FROM $nome'));
  }

  /// Obtem o último id
  Future<int> MaxId(Table table) async {
    Database db = await instance.database;
    String nome = table.nome;
    return Sqflite.firstIntValue(await db.rawQuery('SELECT MAX(id) FROM $nome'));
  }

}