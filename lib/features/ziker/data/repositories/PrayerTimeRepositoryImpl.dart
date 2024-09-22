// lib/data/repositories/prayer_time_repository_impl.dart

import 'package:azkar/core/utils/InternetConnection.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/utils/Status.dart';
import '../../domain/entities/PrayerTime.dart';
import '../../domain/repositories/PrayerTimeRepository.dart';
import '../datasources/PrayerTimesDataSource.dart';

class PrayerTimeRepositoryImpl implements PrayerTimeRepository {
  final PrayerTimesRemoteDataSource remoteDataSource;

  PrayerTimeRepositoryImpl({required this.remoteDataSource});

  @override
  Future<NetworkState<PrayerTime>> getPrayerTimes(String city, String country) async {

    if(!await checkInternetConnection())
      return NetworkState.error('تاكد من اتصال الانترنت');

    try {
      final response = await remoteDataSource.getPrayerTimes(city, country);
      return NetworkState.success(response.toDomain());
    } catch (e) {
      print("e: ${e}");
      return NetworkState.error('مشكلة في السيرفر, اعد المحاولة لاحقا');
    }
  }
}
