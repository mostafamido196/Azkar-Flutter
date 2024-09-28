
import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/Ziker.dart';
import '../../domain/repositories/ZikerRepository.dart';
import '../datasources/ZikerLocalDataSource.dart';


class Zikerrepositoryimpl implements ZikerRepository {
  final ZikerLocalDataSource zikerDataSource;

  Zikerrepositoryimpl(
      {
        required this.zikerDataSource,
       });

  @override
  Future<Either<Failure, List<Ziker>>> getAllAzkar()  async {
      try {
        final localPosts = await zikerDataSource.getZikerList();
        return Right(localPosts);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
  }
}
