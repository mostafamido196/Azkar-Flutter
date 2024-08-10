
import 'package:azkar/features/ziker/domain/entities/Ziker.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

abstract class ZikerRepository {
  Future<Either<Failure, List<Ziker>>> getAllAzkar();
}
