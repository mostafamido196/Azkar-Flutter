import 'package:azkar/features/ziker/domain/entities/Hadith.dart';
import 'package:azkar/features/ziker/domain/entities/Setting.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/utils/FontSize.dart';
import '../../domain/entities/Ziker.dart';

class ZikerResponse extends Ziker {
  const ZikerResponse(
      int id, String name, List<Hadith> arr)
      : super(id, name, arr, );
}
