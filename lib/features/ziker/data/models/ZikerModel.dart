

import 'package:azkar/features/ziker/domain/entities/Hadith.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/Ziker.dart';

class ZikerResponse extends Ziker {

  const ZikerResponse(
     int id,
     String name,
     List<Hadith> arr
  ):super(id,name,arr);



}
