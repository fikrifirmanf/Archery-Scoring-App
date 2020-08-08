import 'dart:convert';

import 'package:scoring_panahan/api/api.dart';
import 'package:http/http.dart' as http;
import 'package:scoring_panahan/models/login_models.dart';

class LoginProv {
  String baseUrl = Api.MAIN_URL;

  Future<dynamic> login(String username, String password) async {
    var data = {'username': username, 'password': password};

    final response = await http.post(baseUrl + 'login',
        headers: {
          'content-type': 'application/json',
          'Accept': 'application/json'
        },
        body: jsonEncode(data));
    final responseString = jsonDecode(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      print('Login success');
      return LoginModel.fromJson(responseString);
    } else if (response.statusCode == 401) {
      print('unauthorized');
      return LoginError.fromJson(responseString);
    } else {
      Exception('Login gagal!');
    }
  }
}
