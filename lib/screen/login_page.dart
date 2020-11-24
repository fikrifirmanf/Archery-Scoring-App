import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:scoring_panahan/auth/bloc.dart';
import 'package:scoring_panahan/bloc/bloc.dart';
import 'package:scoring_panahan/repository/login_repo.dart';

class LoginPage extends StatelessWidget {
  final LoginRepository loginRepository;

  LoginPage({Key key, @required this.loginRepository})
      : assert(loginRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocProvider(
        create: (context) {
          return LoginBloc(
            authenticationBloc: BlocProvider.of<AuthBloc>(context),
            loginRepository: loginRepository,
          );
        },
        child: SafeArea(top: false, child: LoginForm()),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obsecure = true;
  bool _isMockLocation;

  String _errorUsername;
  String _errorPassword;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _onLoginButtonPressed() {
      print(_isMockLocation);

      setState(() {
        _errorUsername = null;
        _errorPassword = null;
      });

      BlocProvider.of<LoginBloc>(context).add(
        LoginButtonPressed(
          username: _usernameController.text,
          password: _passwordController.text,
        ),
      );
    }

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          Scaffold.of(context).hideCurrentSnackBar();

          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text('${state.error}'),
              backgroundColor: Colors.red,
            ),
          );
        }

        if (state is LoginFailed) {
          String message;
          if (state.error.message == 'The given data was invalid.') {
            message = 'Harap periksa dan lengkapi data';
          } else {
            message = state.error.message;
          }

          Scaffold.of(context).hideCurrentSnackBar();
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text('${message}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Stack(children: [
            Positioned(
              top: -200,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage("assets/img/borobudur.jpg"),
                  fit: BoxFit.fill,
                )),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                height: MediaQuery.of(context).size.height / 1.65,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40))),
                padding: EdgeInsets.symmetric(
                  horizontal: 32.0,
                  vertical: 48.0,
                ),
                child: ListView(
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Welcome back, ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 24),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              'Login',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 24),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                image: AssetImage("assets/img/logo.png"),
                                fit: BoxFit.fill,
                              )),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              "Archery Scoring",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            style: TextStyle(color: Color(0xFF003466)),
                            decoration: InputDecoration(
                              errorStyle: TextStyle(
                                color: Colors.yellow,
                              ),
                              errorText: _errorUsername,
                              hintText: 'Username',
                              filled: true,
                              fillColor: Colors.white,
                              labelStyle: TextStyle(color: Colors.blueGrey),
                              contentPadding: EdgeInsets.all(15.0),
                              // border: OutlineInputBorder(
                              //   borderRadius: BorderRadius.circular(5.0),
                              //   borderSide: BorderSide(
                              //       width: 0, style: BorderStyle.none),
                              // ),
                            ),
                            controller: _usernameController,
                          ),
                          SizedBox(height: 10.0),
                          TextFormField(
                            style: TextStyle(color: Color(0xFF003466)),
                            obscureText: _obsecure,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(Icons.remove_red_eye),
                                color: _obsecure ? Colors.grey : Colors.black,
                                onPressed: () {
                                  setState(() {
                                    _obsecure = !_obsecure;
                                  });
                                },
                              ),
                              errorText: _errorPassword,
                              errorStyle: TextStyle(
                                color: Colors.yellow,
                              ),
                              hintText: 'Password',
                              filled: true,
                              fillColor: Colors.white,
                              labelStyle: TextStyle(color: Colors.blueGrey),
                              contentPadding: EdgeInsets.all(15.0),
                              // border: OutlineInputBorder(
                              //   borderRadius: BorderRadius.circular(5.0),
                              //   borderSide: BorderSide(
                              //       width: 0, style: BorderStyle.none),
                              // ),
                            ),
                            controller: _passwordController,
                          ),
                          SizedBox(height: 32.0),
                          MaterialButton(
                            height: 45,
                            minWidth: MediaQuery.of(context).size.width,
                            color: Colors.purple,
                            onPressed: () {
                              (state is! LoginLoading)
                                  ? _onLoginButtonPressed()
                                  : null;
                            },
                            child: Text(
                              'Login',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          // Scaffold(
                          //   body: state is LoginLoading
                          //       ? CircularProgressIndicator()
                          //       : null,
                          // ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]);
        },
      ),
    );
  }
}
