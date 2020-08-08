import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:scoring_panahan/auth/bloc.dart';
import 'package:scoring_panahan/bloc/login_event.dart';
import 'package:scoring_panahan/bloc/login_state.dart';
import 'package:scoring_panahan/repository/login_repo.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository loginRepository;
  final AuthBloc authenticationBloc;

  LoginBloc({
    @required this.loginRepository,
    @required this.authenticationBloc,
  })  : assert(loginRepository != null),
        assert(authenticationBloc != null);

  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginButtonPressed) {
      yield LoginLoading();

      try {
        final login = await loginRepository.authenticate(
          username: event.username,
          password: event.password,
        );

        String token;

        if (login.token != null) {
          token = login.token;
          authenticationBloc.add(LoggedIn(token: token));
        } else {
          yield LoginFailed(error: login);
        }

        yield LoginInitial();
      } catch (error) {
        print(error);
        yield LoginFailure(error: 'Gagal login karena terjadi kesalahan');
      }
    }
  }
}
