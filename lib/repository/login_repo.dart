import 'package:scoring_panahan/api/api.dart';
import 'package:scoring_panahan/providers/login_prov.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

class LoginRepository {
  final LoginProv loginProv = LoginProv();

  final storage = new FlutterSecureStorage();
  String baseUrl = Api.MAIN_URL;

  Future<dynamic> authenticate(
      {@required String username, @required String password}) async {
    var doLogin = await loginProv.login(username, password);
    return doLogin;
  }

  Future<void> persistToken(String token) async {
    print('Create Token');
    await storage.write(key: 'token', value: token);
    return;
  }

  Future<void> delToken() async {
    print('Delete Token');
    await storage.delete(key: 'token');
    return;
  }

  Future<String> getToken() async {
    String token = await storage.read(key: 'token');
    print('Get Token : ' + token);
    return token;
  }

  Future<bool> hasToken() async {
    String token = await storage.read(key: 'token');
    if (token == null || token.isEmpty) {
      print('No token');
      return false;
    } else {
      try {
        final response = await http.get(baseUrl + 'panitia', headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'bearer $token'
        });
        print(response);
        if (response.statusCode == 200) {
          print('token ada');
          return true;
        } else {
          return false;
        }
      } catch (_) {
        print('error' + _.toString());
        return false;
      }
    }
  }
}
