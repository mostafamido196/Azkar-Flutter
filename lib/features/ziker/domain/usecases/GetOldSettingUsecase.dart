

import 'package:azkar/features/ziker/domain/repositories/SettingRepository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/Setting.dart';

class GetOldSettingUsecase {
  final SettingRepository repository;

  GetOldSettingUsecase(this.repository);

  Future<Either<Failure, Setting>> call() async {
    return await repository.getOldSetting();
  }
}