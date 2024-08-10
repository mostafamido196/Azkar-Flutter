
import 'package:azkar/features/ziker/domain/entities/Hadith.dart';
import 'package:equatable/equatable.dart';


class HadithResponse extends Hadith {

  HadithResponse(
       int id,
       String matn,
       String isnad,
       int no_repeat,
       int state
      ) :  super(id,matn,isnad,no_repeat,state);


}
