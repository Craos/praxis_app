import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class Resource<T> {
  final String url;
  T Function(Response response) parse;

  Resource({this.url,this.parse});
}

class Webservice {

  Future<T> load<T>(Resource<T> resource) async {

    // Define some headers and query parameters
    Map<String, String> headers = {
      "Accept": "application/json"
    };
    Map<String, String> queryParameters = {
      "campos": "*",
    };

    Uri uri = Uri.parse(resource.url);
    final newURI = uri.replace(queryParameters: queryParameters);

    final response = await http.get(newURI, headers: headers);
    if(response.statusCode == 200) {
      return resource.parse(response);
    } else {
      throw Exception('Failed to load data!');
    }
  }

}