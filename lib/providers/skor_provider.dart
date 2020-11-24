import 'dart:convert';

import 'package:scoring_panahan/api/api.dart';
import 'package:http/http.dart' as http;
import 'package:scoring_panahan/repository/login_repo.dart';

class SkorProv {
  String baseUrl = Api.MAIN_URL;
  final LoginRepository loginRepository = LoginRepository();

  Future<dynamic> insertSkor(String sesi, String seri, String uuidRules,
      String uuidPeserta, int totalSeri, int totalX, int totalTen) async {
    final token = loginRepository.getToken();
    Map<String, dynamic> body = {
      'seri': totalSeri,
      'total_x': totalX,
      'total_10': totalTen
    };
    final response = await http.put(
        baseUrl +
            'skor/' +
            sesi +
            '/seri_' +
            seri +
            '/' +
            uuidRules +
            '/' +
            uuidPeserta,
        headers: {
          'Content-Type': 'application/json',
          'Accept': '*/*',
          'Authorization': 'bearer $token',
        },
        body: jsonEncode(body),
        encoding: Encoding.getByName("gzip, deflate, br"));
    print(body);
    print(response.request);
    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 201) {
      return true;
    } else if (response.statusCode == 428) {
      return 'gagal';
    } else if (response.statusCode == 503) {
      return false;
    } else {
      throw Exception('Failed input skor');
    }
  }
}
