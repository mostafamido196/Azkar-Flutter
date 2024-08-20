

import 'package:azkar/features/ziker/domain/entities/Setting.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../repositories/SettingRepository.dart';

class UpdateSettingUsecase {
  final SettingRepository repository;

  UpdateSettingUsecase(this.repository);

  Future<Either<Failure, Unit>> call(Setting setting) async {
    return await repository.updateSetting(setting);
  }
}