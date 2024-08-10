
import 'package:azkar/features/ziker/data/datasources/Ziker_LocalDataSource.dart';
import 'package:azkar/features/ziker/domain/entities/Ziker.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/repositories/ZikerRepository.dart';


class Zikerrepositoryimpl implements ZikerRepository {
  final ZikerLocaldatasource localDataSource;

  Zikerrepositoryimpl(
      {
        required this.localDataSource,
       });

  @override
  Future<Either<Failure, List<Ziker>>> getAllAzkar()  async {
      try {
        final localPosts = await localDataSource.getZikerList();
        return Right(localPosts);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
  }
}
