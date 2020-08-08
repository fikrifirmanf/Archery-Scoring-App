import 'dart:convert';

import 'package:scoring_panahan/api/api.dart';
import 'package:http/http.dart' as http;
import 'package:scoring_panahan/models/panitia_models.dart';
import 'package:scoring_panahan/repository/login_repo.dart';

class PanitiaProv {
  String baseUrl = Api.MAIN_URL;
  final LoginRepository loginRepository = LoginRepository();

  PanitiaModel parsePanitia(http.Response response) {
    final responseString = jsonDecode(response.body);
    print(response.body);
    if (response.statusCode == 200) {
      return PanitiaModel.fromJson(responseString);
    } else {
      throw Exception('Failed load panitia');
    }
  }

  Future<PanitiaModel> fetchPanitia() async {
    final token = await loginRepository.getToken();
    final response = await http.get(baseUrl + 'panitia', headers: {
      'Content-Type': 'application/json',
      'Accept-Language': 'application/json',
      'Authorization': 'bearer $token',
    });
    return parsePanitia(response);
  }
}
