import 'package:equatable/equatable.dart';

abstract class SkorEvent extends Equatable {
  const SkorEvent();
  @override
  List<Object> get props => [];
}

class InsertSkorEvent extends SkorEvent {
  final String sesi;
  final String seri;
  final String uuidRules;
  final String uuidPeserta;
  final int totalSeri;
  final int totalX;
  final int totalTen;

  const InsertSkorEvent(
      {this.sesi,
      this.seri,
      this.uuidRules,
      this.uuidPeserta,
      this.totalSeri,
      this.totalX,
      this.totalTen});
  @override
  List<Object> get props =>
      [sesi, seri, uuidRules, uuidPeserta, totalSeri, totalX];

  @override
  String toString() => 'InsertSkorEvent ';
}
