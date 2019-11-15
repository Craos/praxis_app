import 'dart:convert';
import 'package:praxis/servicos/webservice.dart';
import 'package:praxis/utilidades/constants.dart';

class Solicitacoes {

  int id;
  DateTime firstdate;
  dynamic lastdate;
  dynamic purgedate;
  String firstuser;
  dynamic lastuser;
  dynamic purgeuser;
  int fornecedor;
  dynamic contrato;
  String titulo;
  String descricao;
  String responsavel;
  int situacao;
  int progresso;

  Solicitacoes({
    this.id,
    this.firstdate,
    this.lastdate,
    this.purgedate,
    this.firstuser,
    this.lastuser,
    this.purgeuser,
    this.fornecedor,
    this.contrato,
    this.titulo,
    this.descricao,
    this.responsavel,
    this.situacao,
    this.progresso,
  });

  factory Solicitacoes.fromJson(Map<String, dynamic> json) {
    return Solicitacoes(
      id: json["id"],
      firstdate: DateTime.parse(json["firstdate"]),
      lastdate: json["lastdate"],
      purgedate: json["purgedate"],
      firstuser: json["firstuser"],
      lastuser: json["lastuser"],
      purgeuser: json["purgeuser"],
      fornecedor: json["fornecedor"],
      contrato: json["contrato"],
      titulo: json["titulo"],
      descricao: json["descricao"],
      responsavel: json["responsavel"],
      situacao: json["situacao"],
      progresso: json["progresso"],
    );
  }

  static Resource<List<Solicitacoes>> get all {
    return Resource(
        url: Constants.SOLICITACOES_URL,
        parse: (response) {
          final result = json.decode(response.body);
          Iterable list = result;
          return list.map((model) => Solicitacoes.fromJson(model)).toList();
        }
    );
  }

  static Resource<List<Solicitacoes>> get update {

    return Resource(
        url: Constants.SOLICITACOES_URL,
        parse: (response) {
          final result = json.decode(response.body);
          Iterable list = result;
          return list.map((model) => Solicitacoes.fromJson(model)).toList();
        }
    );
  }
}