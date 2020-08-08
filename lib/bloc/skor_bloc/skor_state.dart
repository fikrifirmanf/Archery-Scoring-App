import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class SkorState extends Equatable {
  const SkorState();

  @override
  List<Object> get props => [];
}

class Uninitializeder extends SkorState {}

class Loading extends SkorState {}

class Error extends SkorState {}

class Loaded extends SkorState {
  @override
  List<Object> get props => [];
}

class Failed extends SkorState {
  final String error;

  Failed({@required this.error}) : assert(error != null);
  @override
  List<Object> get props => [error];

  @override
  String toString() => 'Error $error';
}

class Success extends SkorState {}
