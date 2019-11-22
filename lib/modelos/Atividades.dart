import 'dart:convert';
import 'package:praxis/servicos/database_helpers.dart';
import 'package:praxis/servicos/webservice.dart';
import 'package:praxis/utilidades/globals.dart' as globals;

class Atividades {
  int id;
  DateTime firstdate;
  DateTime lastdate;
  DateTime purgedate;
  String firstuser;
  String lastuser;
  String purgeuser;
  int contrato;
  String titulo;
  String descricao;
  String responsavel;
  int situacao;
  int progresso;

  Atividades({
    this.id,
    this.firstdate,
    this.lastdate,
    this.purgedate,
    this.firstuser,
    this.lastuser,
    this.purgeuser,
    this.contrato,
    this.titulo,
    this.descricao,
    this.responsavel,
    this.situacao,
    this.progresso,
  });

  factory Atividades.fromJson(Map<String, dynamic> json) => Atividades(
        id: json["id"],
        firstdate: json["firstdate"] == null ? null :  DateTime.parse(json["firstdate"]),
        lastdate: json["lastdate"] == null ? null: DateTime.parse(json["lastdate"]),
        purgedate: json["purgedate"] == null ? null : DateTime.parse(json["purgedate"]),
        firstuser: json["firstuser"],
        lastuser: json["lastuser"],
        purgeuser: json["purgeuser"],
        contrato: json["contrato"],
        titulo: json["titulo"],
        descricao: json["descricao"],
        responsavel: json["responsavel"],
        situacao: json["situacao"],
        progresso: json["progresso"],
      );

  factory Atividades.fromMap(Map<String, dynamic> map) => Atividades(
        id: map["id"],
        firstdate: map["firstdate"] == null ? null : DateTime.parse(map["firstdate"]),
        lastdate: map["lastdate"] == null ? null : DateTime.parse(map["lastdate"]),
        purgedate: map["purgedate"] == null ? null : DateTime.parse(map["purgedate"]),
        firstuser: map["firstuser"],
        lastuser: map["lastuser"],
        purgeuser: map["purgeuser"],
        contrato: map["contrato"],
        titulo: map["titulo"],
        descricao: map["descricao"],
        responsavel: map["responsavel"],
        situacao: map["situacao"],
        progresso: map["progresso"],
      );

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      "id": id,
      "firstdate": firstdate.toIso8601String(),
      "lastdate": lastdate.toIso8601String(),
      "purgedate": purgedate.toIso8601String(),
      "firstuser": firstuser,
      "lastuser": lastuser,
      "purgeuser": purgeuser,
      "contrato": contrato,
      "titulo": titulo,
      "descricao": descricao,
      "responsavel": responsavel,
      "situacao": situacao,
      "progresso": progresso,
    };
    return map;
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstdate": firstdate.toIso8601String(),
        "lastdate": lastdate.toIso8601String(),
        "purgedate": purgedate.toIso8601String(),
        "firstuser": firstuser,
        "lastuser": lastuser,
        "purgeuser": purgeuser,
        "contrato": contrato,
        "titulo": titulo,
        "descricao": descricao,
        "responsavel": responsavel,
        "situacao": situacao,
        "progresso": progresso,
      };

  static Table<Atividades> get localdbInsert {
    return Table(
        nome: 'atividades',
        parse: (response) {
          var item = response.first;
          return new Atividades(
            id: item["id"],
            firstdate: item["firstdate"],
            lastdate: item["lastdate"],
            purgedate: item["purgedate"],
            firstuser: item["firstuser"],
            lastuser: item["lastuser"],
            purgeuser: item["purgeuser"],
            contrato: item["contrato"],
            titulo: item["titulo"],
            descricao: item["descricao"],
            responsavel: item["responsavel"],
            situacao: item["situacao"],
            progresso: item["progresso"],
          );
        }
    );
  }

  static Table<List<Atividades>> get localdbSelect {
    return Table(
        nome: 'atividades',
        parse: (response) {
          return response.map((model) => Atividades.fromJson(model)).toList();
        }
      );
  }

  static Table<int> get localdbLastId {
    return Table(
        nome: 'atividades',
        lastid: (response) {
          return response;
        }
      );
  }

  static Table<List<Map<String, dynamic>>> get localdbSelectIds {
    return Table(
        nome: 'atividades',
        parse: (response) {
          return response;
        }
      );
  }

  static Resource<List<Atividades>> get all {
    return Resource(
        url: globals.ATIVIDADES_URL,
        parse: (response) {
          final result = json.decode(response.body);
          Iterable list = result;
          return list.map((model) => Atividades.fromJson(model)).toList();
        });
  }

  static Resource<Atividades> get insert {
    return Resource(
        url: globals.ATIVIDADES_URL,
        parse: (response) {
          final result = json.decode(response.body);
          Iterable list = result;

          var item = list.first;
          return new Atividades(
            id: item["id"],
            firstdate: item["firstdate"] == null ? null : DateTime.parse(item["firstdate"]),
            lastdate: item["lastdate"] == null ? null : DateTime.parse(item["lastdate"]),
            purgedate: item["purgedate"] == null ? null : DateTime.parse(item["purgedate"]),
            firstuser: item["firstuser"],
            lastuser: item["lastuser"],
            purgeuser: item["purgeuser"],
            contrato: item["contrato"],
            titulo: item["titulo"],
            descricao: item["descricao"],
            responsavel: item["responsavel"],
            situacao: item["situacao"],
            progresso: item["progresso"],
          );
        });
  }

  static Resource<Atividades> get update {
    return Resource(
        url: globals.ATIVIDADES_URL,
        parse: (response) {
          final result = json.decode(response.body);
          Iterable list = result;

          var item = list.first;
          return new Atividades(
            id: item["id"],
            firstdate: item["firstdate"] == null ? null : DateTime.parse(item["firstdate"]),
            lastdate: item["lastdate"] == null ? null : DateTime.parse(item["lastdate"]),
            purgedate: item["purgedate"] == null ? null : DateTime.parse(item["purgedate"]),
            firstuser: item["firstuser"],
            lastuser: item["lastuser"],
            purgeuser: item["purgeuser"],
            contrato: item["contrato"],
            titulo: item["titulo"],
            descricao: item["descricao"],
            responsavel: item["responsavel"],
            situacao: item["situacao"],
            progresso: item["progresso"],
          );
        });
  }
}
