import 'package:bloc/bloc.dart';
import 'package:scoring_panahan/bloc/home_bloc/home_event.dart';
import 'package:scoring_panahan/bloc/home_bloc/home_state.dart';
import 'package:scoring_panahan/models/panitia_models.dart';
import 'package:scoring_panahan/models/peserta_models.dart';
import 'package:scoring_panahan/repository/home_repo.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository homeRepository;

  HomeBloc({this.homeRepository}) : assert(homeRepository != null);

  @override
  HomeState get initialState => HomeUninitializedState();

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is FetchHome) {
      yield HomeFetchingState();
      try {
        PesertaModel pesertaModel;
        PanitiaModel panitiaModel;
        panitiaModel = await homeRepository.fetchPanitia();
        pesertaModel = await homeRepository.fetchPeserta();
        yield HomeFetchedState(
            pesertaModel: pesertaModel, panitiaModel: panitiaModel);
      } catch (_) {
        print(_.toString());
        yield HomeErrorState();
      }
    }
    if (event is RefreshHome) {
      try {
        PesertaModel pesertaModel;
        PanitiaModel panitiaModel;
        panitiaModel = await homeRepository.fetchPanitia();
        pesertaModel = await homeRepository.fetchPeserta();
        yield HomeFetchedState(
            pesertaModel: pesertaModel, panitiaModel: panitiaModel);
      } catch (_) {
        print(_.toString());
        yield HomeErrorState();
      }
    }
  }
}
