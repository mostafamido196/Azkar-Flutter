
import 'package:azkar/features/ziker/domain/entities/Ziker.dart';
import 'package:azkar/features/ziker/domain/repositories/ZikerRepository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

class GetAllAzkarUsecase {
  final ZikerRepository repository;

  GetAllAzkarUsecase(this.repository);

  Future<Either<Failure, List<Ziker>>> call() async {
    return await repository.getAllAzkar();
  }
}
