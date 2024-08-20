
import 'package:azkar/features/ziker/data/datasources/ZikerLocalDataSource.dart';
import 'package:azkar/features/ziker/domain/entities/Ziker.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/repositories/ZikerRepository.dart';


class Zikerrepositoryimpl implements ZikerRepository {
  final ZikerLocalDataSource zikerDataSource;

  Zikerrepositoryimpl(
      {
        required this.zikerDataSource,
       });

  @override
  Future<Either<Failure, List<Ziker>>> getAllAzkar()  async {
    // print('Zikerrepositoryimpl');
      try {
        final localPosts = await zikerDataSource.getZikerList();
        return Right(localPosts);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
  }
}
