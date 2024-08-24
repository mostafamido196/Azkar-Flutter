import 'package:azkar/features/ziker/data/datasources/SettingDataSorce.dart';
import 'package:azkar/features/ziker/data/models/SettingModel.dart';
import 'package:azkar/features/ziker/domain/entities/Setting.dart';
import 'package:azkar/features/ziker/domain/usecases/SetNewSettingUsecase.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/repositories/SettingRepository.dart';

class SettingRepositoryImpl implements SettingRepository {
  final SettingDataSource settingDataSource;

  SettingRepositoryImpl({
    required this.settingDataSource,
  });

  @override
  Future<Either<Failure, SettingResponse>> getOldSetting() async {
    try {
      final localPosts = await settingDataSource.getOldSetting();
      return Right(localPosts as SettingResponse);
    } on EmptyCacheException {
      return Left(EmptyCacheFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updateSetting(Setting setting) async {
    try {
      await settingDataSource.updateSetting(SettingResponse(fontSize:setting.fontSize,noisy:setting.noisy,vibrate:setting.vibrate,notify:setting.notify,transfer: setting.transfer));
      return Right(unit);
    } catch (e) {
      return Left(UnKnownFailure(message:e.toString()));

    }
  }
}
