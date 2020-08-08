import 'package:scoring_panahan/models/panitia_models.dart';
import 'package:scoring_panahan/models/peserta_models.dart';
import 'package:scoring_panahan/providers/panitia_prov.dart';
import 'package:scoring_panahan/providers/peserta_prov.dart';

class HomeRepository {
  PesertaProv _pesertaProv = PesertaProv();
  PanitiaProv _panitiaProv = PanitiaProv();

  Future<PesertaModel> fetchPeserta() {
    return _pesertaProv.fetchPeserta();
  }

  Future<PanitiaModel> fetchPanitia() {
    return _panitiaProv.fetchPanitia();
  }
}
