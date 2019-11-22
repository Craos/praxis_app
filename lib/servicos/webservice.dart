import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class Resource<T> {
  final String url;
  T Function(Response response) parse;
  Resource({this.url, this.parse});
}

class Webservice {


  Future<T> get<T>(Resource<T> resource, [Map<String, String> queryParameters]) async {

    Uri uri = Uri.parse(resource.url);

    var newURI = null;

    if (queryParameters != null) {
      newURI = uri.replace(queryParameters: queryParameters);
    } else {
      newURI = uri;
    }

    Map<String, String> headers = {"Accept": "application/json"};
    final response = await http.get(newURI, headers: headers);

    if (response.statusCode == HttpStatus.ok) {
      return resource.parse(response);
    } else {
      var codigo = response.statusCode;
      var uri = resource.url;
      throw Exception(
          "Falha na requisição: $codigo  $uri");
    }
  }

  Future<T> post<T>(Resource<T> resource,
      {Map<String, String> queryParameters, Map<String, String> params}) async {
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Prefer': 'return=representation'
    };

    Uri uri = Uri.parse(resource.url);
    final newURI = uri.replace(queryParameters: queryParameters);
    final body = json.encode(params);
    final response = await http.post(newURI, body: body, headers: headers);

    var codigo = response.statusCode;

    if (response.statusCode == HttpStatus.created) {
      return resource.parse(response);
    } else {
      throw Exception(
          "Falha na requisição o servidor retornou o erro: $codigo");
    }
  }

  Future<T> patch<T>(Resource<T> resource,
      {Map<String, String> queryParameters, Map<String, String> params}) async {
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Prefer': 'return=representation'
    };

    Uri uri = Uri.parse(resource.url);

    final newURI = uri.replace(queryParameters: queryParameters);
    final body = json.encode(params);
    final response = await http.patch(newURI, body: body, headers: headers);

    int codigo = response.statusCode;

    if (response.statusCode == HttpStatus.ok) {
      return resource.parse(response);
    } else {
      throw Exception(
          "Falha na requisição. O servidor retornou o erro: $codigo");
    }
  }
}
