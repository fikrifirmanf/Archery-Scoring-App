import 'package:flutter/material.dart';
import 'package:scoring_panahan/auth/bloc.dart';
import 'package:scoring_panahan/bloc/home_bloc/bloc.dart';
import 'package:scoring_panahan/repository/home_repo.dart';
import 'package:scoring_panahan/repository/login_repo.dart';
import 'package:scoring_panahan/repository/skor_repo.dart';
import 'package:scoring_panahan/screen/home.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scoring_panahan/screen/login_page.dart';
import 'package:scoring_panahan/screen/splashscreen.dart';

import 'bloc/skor_bloc/bloc.dart';

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    print(error);
  }
}

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final loginRepository = LoginRepository();
  initializeDateFormatting().then((_) => runApp(
        BlocProvider<AuthBloc>(
          create: (context) {
            return AuthBloc(loginRepository: loginRepository)
              ..add(AppStarted());
          },
          child: MyApp(loginRepository: loginRepository),
        ),
      ));
}

class MyApp extends StatelessWidget {
  final LoginRepository loginRepository;
  final HomeRepository homeRepository = HomeRepository();
  final SkorRepo skorRepo = SkorRepo();
  MyApp({
    Key key,
    @required this.loginRepository,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, //top bar color
      statusBarIconBrightness: Brightness.dark, //top bar icons
      systemNavigationBarColor: Colors.white, //bottom bar color
      systemNavigationBarIconBrightness: Brightness.dark, //bottom bar icons
    ));
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>(
          create: (context) => HomeBloc(homeRepository: homeRepository),
        ),
        BlocProvider<SkorBloc>(
          create: (context) => SkorBloc(skorRepo: skorRepo),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Scoring Panahan',
        theme: ThemeData(
          backgroundColor: Colors.white,
          fontFamily: 'Konnect',
          textTheme: TextTheme(
              body1: TextStyle(fontFamily: 'Konnect', color: Colors.black54)),
        ),
        home: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthUnintialized) {
              return SplashScreen();
            }
            if (state is AuthAuthenticated) {
              return Home();
            }
            if (state is AuthUnauthenticated) {
              return LoginPage(
                loginRepository: loginRepository,
              );
            }

            if (state is AuthLoading) {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
