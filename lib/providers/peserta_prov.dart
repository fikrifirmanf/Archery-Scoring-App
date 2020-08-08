import 'dart:convert';

import 'package:scoring_panahan/api/api.dart';
import 'package:http/http.dart' as http;
import 'package:scoring_panahan/models/peserta_models.dart';
import 'package:scoring_panahan/repository/login_repo.dart';

class PesertaProv {
  String baseUrl = Api.MAIN_URL;
  final LoginRepository loginRepository = LoginRepository();

  PesertaModel parsePeserta(http.Response response) {
    final responseString = jsonDecode(response.body);
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      return PesertaModel.fromJson(responseString);
    } else {
      throw Exception('Failed load peserta!');
    }
  }

  Future<PesertaModel> fetchPeserta() async {
    final token = await loginRepository.getToken();
    final response = await http.get(baseUrl + 'peserta', headers: {
      'Content-Type': 'application/json',
      'Accept-Language': 'application/json',
      'Authorization': 'bearer $token',
    });
    return parsePeserta(response);
  }
}
