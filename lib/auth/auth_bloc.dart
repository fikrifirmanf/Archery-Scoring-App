import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:scoring_panahan/api/api.dart';
import 'package:scoring_panahan/auth/auth_event.dart';
import 'package:scoring_panahan/auth/auth_state.dart';
import 'package:scoring_panahan/repository/login_repo.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginRepository loginRepository;
  String baseUrl = Api.MAIN_URL;

  AuthBloc({@required this.loginRepository}) : assert(loginRepository != null);

  @override
  AuthState get initialState => AuthUnintialized();

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AppStarted) {
      final bool hasToken = await loginRepository.hasToken();
      if (hasToken) {
        yield AuthAuthenticated();
      } else {
        yield AuthUnauthenticated();
      }
    }
    if (event is LoggedIn) {
      yield AuthLoading();
      await loginRepository.persistToken(event.token);
      yield AuthAuthenticated();
    }
    if (event is LoggedOut) {
      yield AuthLoading();
      await loginRepository.delToken();
      yield AuthUnauthenticated();
    }
  }
}
