import 'dart:async';
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../models/SettingModel.dart';

abstract class SettingDataSource {
  Future<SettingResponse> getOldSetting();

  Future<Either<Failure, Unit>> updateSetting(SettingResponse setting);
}

const CACHED_SETTING = "CACHED_SETTING";

class SettingDataSourceImpl implements SettingDataSource {
  final SharedPreferences sharedPreferences;

  SettingDataSourceImpl({required this.sharedPreferences});

  @override
  Future<SettingResponse> getOldSetting() async {
    String? jsonString = sharedPreferences.getString(CACHED_SETTING);

    if (jsonString != null) {
      Map<String, dynamic> jsonMap = jsonDecode(jsonString);
      SettingResponse setting = SettingResponse.fromJson(jsonMap);
      print('data source setting: $setting');

      return Future.value(setting);
    } else {
      print('data source error EmptyCacheException');
      throw EmptyCacheException();
    }
  }


  @override
  Future<Either<Failure, Unit>> updateSetting(SettingResponse settingModel) async {
    try {
      final jsonString = jsonEncode(settingModel.toJson());
      await sharedPreferences.setString(CACHED_SETTING, jsonString);
      print('data source setting: done update : ${settingModel}');
      return Right(unit);
    } catch (e) {
      print('data source setting: UnKnownFailure');
      return Left(UnKnownFailure(message: e.toString()));
    }
  }

}
