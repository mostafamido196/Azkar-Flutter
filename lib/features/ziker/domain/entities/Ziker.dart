


import 'package:azkar/features/ziker/domain/entities/Hadith.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/FontSize.dart';

class Ziker extends Equatable {
  final int id;
  final String name;
  final List<Hadith> arr;
  final FontSize font;

  const Ziker(
     this.id,
     this.name,
     this.arr,
      this.font
  );

  @override
  List<Object?> get props => [id, name, arr];
}
