import 'dart:convert';
import 'package:praxis/servicos/webservice.dart';
import 'package:praxis/utilidades/constants.dart';

class Atividades {

  String id;
  DateTime firstdate;
  dynamic lastdate;
  dynamic purgedate;
  String firstuser;
  dynamic lastuser;
  dynamic purgeuser;
  String pmo;
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
      lastdate: json["lastdate"],
      purgedate: json["purgedate"],
      firstuser: json["firstuser"],
      lastuser: json["lastuser"],
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

          print(response.body);

          final result = json.decode(response.body);
          Iterable list = result['data'];
          return list.map((model) => Atividades.fromJson(model)).toList();
        }
    );
  }
}