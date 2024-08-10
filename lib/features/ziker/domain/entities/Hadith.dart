
import 'package:equatable/equatable.dart';


class Hadith extends Equatable {
  final int id;
  final String matn;
  final String isnad;
  final int no_repeat;
  int state;

  Hadith(
       this.id,
       this.matn,
       this.isnad,
       this.no_repeat,
       this.state);

  @override
  List<Object?> get props => [id, matn, isnad, no_repeat, state];
}
