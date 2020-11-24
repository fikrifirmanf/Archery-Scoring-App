import 'package:bloc/bloc.dart';
import 'package:scoring_panahan/bloc/skor_bloc/skor_event.dart';
import 'package:scoring_panahan/bloc/skor_bloc/skor_state.dart';
import 'package:scoring_panahan/repository/skor_repo.dart';

class SkorBloc extends Bloc<SkorEvent, SkorState> {
  final SkorRepo skorRepo;

  SkorBloc({this.skorRepo}) : assert(skorRepo != null);

  @override
  SkorState get initialState => Uninitializeder();

  @override
  Stream<SkorState> mapEventToState(
    SkorEvent event,
  ) async* {
    if (event is InsertSkorEvent) {
      yield Loading();
      try {
        var insertSkor = await skorRepo.insertSkor(
            event.sesi,
            event.seri,
            event.uuidRules,
            event.uuidPeserta,
            event.totalSeri,
            event.totalX,
            event.totalTen);
        if (insertSkor == true) {
          yield Success();
        } else if (insertSkor == 'gagal') {
          yield Failed(error: "Anda sudah input");
        }
        // }  else {
        //   yield Failed(error: "Insert presensi gagal!");
        // }
      } catch (_) {
        print(_.toString());
        yield Error();
      }
    }
  }
}
