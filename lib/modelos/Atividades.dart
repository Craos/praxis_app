import 'dart:convert';
import 'package:praxis/servicos/webservice.dart';
import 'package:praxis/utilidades/constants.dart';

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
    firstdate: DateTime.parse(json["firstdate"]),
    lastdate: DateTime.parse(json["lastdate"]),
    purgedate: DateTime.parse(json["purgedate"]),
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
}