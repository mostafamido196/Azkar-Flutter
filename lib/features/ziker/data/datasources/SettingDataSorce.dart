import 'dart:async';
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../models/SettingModel.dart';

abstract class SettingDataSource {
  Future<List<SettingResponse>> getOldSetting();

  Future<Either<Failure, Unit>> UpdateSetting(SettingResponse setting);
}

const CACHED_SETTING = "CACHED_SETTING";

class SettingDataSourceImpl implements SettingDataSource {
  final SharedPreferences sharedPreferences;

  SettingDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<SettingResponse>> getOldSetting() async {
    String? jsonString = sharedPreferences.getString(CACHED_SETTING);
    if (jsonString != null) {
      return Future.value(jsonDecode(jsonString));
    } else {
      throw EmptyCacheException();
    }
  }

  @override
  Future<Either<Failure, Unit>> UpdateSetting(
      SettingResponse settingModel) async {
    try {
      await sharedPreferences.setString(
          CACHED_SETTING, jsonEncode(settingModel));
      return Right(unit);
    } catch (e) {
      return Left(UnKnownFailure(message: e.toString()));
    }
  }
}
