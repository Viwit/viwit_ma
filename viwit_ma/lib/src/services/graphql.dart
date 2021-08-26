import 'dart:convert';
import 'package:http/http.dart' as http;

class Graphql{

  // ignore: non_constant_identifier_names
  final String _HttpLink = "http://ec2-35-171-23-100.compute-1.amazonaws.com:3000/graphql";

  String get getHttpLink => this._HttpLink;


  Future<Map> queryOrMutation(String query) async {


      print("${query}");

    Map data = {
        'query': query,
      };

    var body = json.encode(data);

    var response = await http.post(_HttpLink,
          headers: {"Content-Type": "application/json"},
          body: body
      );

      print("${response.statusCode}");
      print("${response.body}");

      return jsonDecode(response.body);
  }

  bool verifyLogin(String token, String userId) {
    
  }

}