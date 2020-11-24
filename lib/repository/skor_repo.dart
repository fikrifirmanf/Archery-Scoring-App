import 'package:scoring_panahan/providers/skor_provider.dart';

class SkorRepo {
  SkorProv _skorProv = SkorProv();
  Future<dynamic> insertSkor(String sesi, String seri, String uuidRules,
      String uuidPeserta, int totalSeri, int totalX, int totalTen) async {
    return await _skorProv.insertSkor(
        sesi, seri, uuidRules, uuidPeserta, totalSeri, totalX, totalTen);
  }
}
