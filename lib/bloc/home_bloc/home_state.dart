import 'package:equatable/equatable.dart';

import 'package:meta/meta.dart';
import 'package:scoring_panahan/models/panitia_models.dart';
import 'package:scoring_panahan/models/peserta_models.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeUninitializedState extends HomeState {}

class HomeFetchingState extends HomeState {}

class HomeFetchedState extends HomeState {
  final PesertaModel pesertaModel;
  final PanitiaModel panitiaModel;

  HomeFetchedState({
    @required this.panitiaModel,
    @required this.pesertaModel,
  }) : assert(pesertaModel != null, panitiaModel != null);

  @override
  List<Object> get props => [pesertaModel];
}

class HomeErrorState extends HomeState {}

class HomeEmptyState extends HomeState {}
