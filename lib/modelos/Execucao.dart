import 'dart:convert';
import 'package:praxis/servicos/webservice.dart';
import 'package:praxis/utilidades/globals.dart' as globals;

class Execucao {

  int id;
  DateTime firstdate;
  DateTime lastdate;
  DateTime purgedate;
  String firstuser;
  String lastuser;
  String purgeuser;
  int pmo;
  String observacoes;
  String documento;
  String documentoTipo;

  Execucao({
    this.id,
    this.firstdate,
    this.lastdate,
    this.purgedate,
    this.firstuser,
    this.lastuser,
    this.purgeuser,
    this.pmo,
    this.observacoes,
    this.documento,
    this.documentoTipo,
  });

  factory Execucao.fromJson(Map<String, dynamic> json) => Execucao(
    id: json["id"],
    firstdate: DateTime.parse(json["firstdate"]),
    lastdate: json["lastdate"] == null ? null : DateTime.parse(json["lastdate"]),
    purgedate: json["purgedate"] == null ? null : DateTime.parse(json["purgedate"]),
    firstuser: json["firstuser"],
    lastuser: json["lastuser"] == null ? null : json["lastuser"],
    purgeuser: json["purgeuser"] == null ? null : json["purgeuser"],
    pmo: json["pmo"],
    observacoes: json["observacoes"],
    documento: json["documento"] == null ? null : json["documento"],
    documentoTipo: json["documento_tipo"] == null ? null : json["documento_tipo"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "firstdate": firstdate.toIso8601String(),
    "lastdate": lastdate == null ? null : lastdate.toIso8601String(),
    "purgedate": purgedate == null ? null : purgedate.toIso8601String(),
    "firstuser": firstuser,
    "lastuser": lastuser == null ? null : lastuser,
    "purgeuser": purgeuser == null ? null : purgeuser,
    "pmo": pmo,
    "observacoes": observacoes,
    "documento": documento == null ? null : documento,
    "documento_tipo": documentoTipo == null ? null : documentoTipo,
  };

  static Resource<List<Execucao>> get all {
    return Resource(
        url: globals.EXECUCAO_URL,
        parse: (response) {
          final result = json.decode(response.body);
          Iterable list = result;
          return list.map((model) => Execucao.fromJson(model)).toList();
        }
    );
  }

  static Resource<Execucao> get insert {
    return Resource(
        url: globals.EXECUCAO_URL,
        parse: (response) {
          final result = json.decode(response.body);
          Iterable list = result;

          var item = list.first;
          return new Execucao(
            id: item["id"],
            firstdate: DateTime.parse(item["firstdate"]),
            lastdate: item["lastdate"] == null ? null : DateTime.parse(item["lastdate"]),
            purgedate: item["purgedate"] == null ? null : DateTime.parse(item["purgedate"]),
            firstuser: item["firstuser"],
            lastuser: item["lastuser"] == null ? null : item["lastuser"],
            purgeuser: item["purgeuser"] == null ? null : item["purgeuser"],
            pmo: item["pmo"],
            observacoes: item["observacoes"],
            documento: item["documento"] == null ? null : item["documento"],
            documentoTipo: item["documento_tipo"] == null ? null : item["documento_tipo"],
          );
        }
    );
  }

  static Resource<List<Execucao>> get update {

    return Resource(
        url: globals.EXECUCAO_URL,
        parse: (response) {
          final result = json.decode(response.body);
          Iterable list = result;
          return list.map((model) => Execucao.fromJson(model)).toList();
        }
    );
  }
}