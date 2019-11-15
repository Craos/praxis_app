import 'dart:convert';
import 'package:praxis/servicos/webservice.dart';
import 'package:praxis/utilidades/constants.dart';

class Atividades {

  int id;
  DateTime firstdate;
  DateTime lastdate;
  dynamic purgedate;
  String firstuser;
  String lastuser;
  dynamic purgeuser;
  int pmo;
  String observacoes;
  dynamic documento;
  dynamic documentoTipo;

  Atividades({
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

  factory Atividades.fromJson(Map<String, dynamic> json) {

    return Atividades(
      id: json["id"],
      firstdate: DateTime.parse(json["firstdate"]),
      lastdate: json["lastdate"] == null ? null : DateTime.parse(json["lastdate"]),
      purgedate: json["purgedate"],
      firstuser: json["firstuser"],
      lastuser: json["lastuser"] == null ? null : json["lastuser"],
      purgeuser: json["purgeuser"],
      pmo: json["pmo"],
      observacoes: json["observacoes"],
      documento: json["documento"],
      documentoTipo: json["documento_tipo"],
    );
  }

  static Resource<List<Atividades>> get all {
    return Resource(
        url: Constants.ATIVIDADES_URL,
        parse: (response) {
          final result = json.decode(response.body);
          Iterable list = result;
          return list.map((model) => Atividades.fromJson(model)).toList();
        }
    );
  }

  static Resource<Atividades> get insert {
    return Resource(
        url: Constants.ATIVIDADES_URL,
        parse: (response) {
          final result = json.decode(response.body);
          Iterable list = result;

          var item = list.first;
          return new Atividades(
            id: item["id"],
            firstdate: DateTime.parse(item["firstdate"]),
            lastdate: item["lastdate"] == null ? null : DateTime.parse(item["lastdate"]),
            purgedate: item["purgedate"],
            firstuser: item["firstuser"],
            lastuser: item["lastuser"] == null ? null : item["lastuser"],
            purgeuser: item["purgeuser"],
            pmo: item["pmo"],
            observacoes: item["observacoes"],
            documento: item["documento"].toString(),
            documentoTipo: item["documento_tipo"].toString()
          );
        }
    );
  }

  static Resource<Atividades> get update {
    return Resource(
        url: Constants.ATIVIDADES_URL,
        parse: (response) {
          final result = json.decode(response.body);
          Iterable list = result;

          var item = list.first;
          return new Atividades(
            id: item["id"],
            firstdate: DateTime.parse(item["firstdate"]),
            lastdate: item["lastdate"] == null ? null : DateTime.parse(item["lastdate"]),
            purgedate: item["purgedate"],
            firstuser: item["firstuser"],
            lastuser: item["lastuser"] == null ? null : item["lastuser"],
            purgeuser: item["purgeuser"],
            pmo: item["pmo"],
            observacoes: item["observacoes"],
            documento: item["documento"].toString(),
            documentoTipo: item["documento_tipo"].toString()
          );
        }
    );
  }
}