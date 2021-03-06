import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:remita_flutter_sdk/generic/apiList.dart';

///helper methods for http requests
///TODO: Map httpCalls to Singleton Class
class GenericHttp {
  ///Generic Post function to make Post API calls
  static Future<Map> postToDB(
      {required String api,
      required Map<String, dynamic> body,
      Map<String, String>? headers}) async {
    final http.Response response = await http.post(
      Uri.parse(api),
      headers: headers,
      body: jsonEncode(body),
    );

    try {
      return jsonDecode(response.body.split('(')[1].split(')').first);
    } catch (e) {
      return jsonDecode(response.body.split('(')[0].split(')').first);
    }
  }

  ///Generic Get function to make Get API calls
  static Future<dynamic> getFromDB(
      {required String api,
      String? apiKey,
      Map<String, String>? headers,
      bool isHtml = false}) async {
    final http.Response response =
        await http.get(Uri.parse(api), headers: headers);

    // return jsonDecode(response.body);

    try {
      return !isHtml
          ? jsonDecode(response.body.split('(')[1].split(')').first)
          : response.body;
    } catch (e) {
      print(response.body);
      return !isHtml
          ? jsonDecode(response.body.split('(')[0].split(')').first)
          : response.body;
    }
  }

  ///Generic Put function to make Put API calls
  static Future<Map> putOnDB(
      {required String api, required String apiKey, required Map body}) async {
    final http.Response response = await http.put(Uri.parse(api),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'X-CC-Version': '2018-03-22',
          'X-CC-Api-Key': apiKey,
        },
        body: jsonEncode(body));
    return jsonDecode(response.body);
  }

  ///Generic Delete function to make delete API calls
  static Future<Map> deleteFromDB(
      {required String api, required String apiKey}) async {
    final http.Response response = await http.delete(
      Uri.parse(api),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'X-CC-Version': '2018-03-22',
        'X-CC-Api-Key': apiKey,
      },
    );
    return jsonDecode(response.body);
  }
}
