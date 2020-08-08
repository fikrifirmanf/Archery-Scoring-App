import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends AuthEvent {}

class LoggedIn extends AuthEvent {
  final String token;
  const LoggedIn({@required this.token});

  @override
  List<Object> get props => [token];

  @override
  String toString() => 'LoggedIn';
}

class LoggedOut extends AuthEvent {
   @override
  String toString() => 'LoggedOut';
}
