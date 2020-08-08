import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:scoring_panahan/models/login_models.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginFailure extends LoginState {
  final String error;

  const LoginFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'LoginFailure { error: $error }';
}

class LoginFailed extends LoginState {
  final LoginError error;

  LoginFailed({@required this.error}) : assert(error != null);

  @override
  List<Object> get props => [error];

  @override
  String toString() => '$error';
}
