// lib/domain/usecases/get_prayer_times.dart

import 'package:azkar/core/utils/Status.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/PrayerTime.dart';
import '../repositories/PrayerTimeRepository.dart';

class GetPrayerTimesUsecase {
  final PrayerTimeRepository repository;

  GetPrayerTimesUsecase(this.repository);

  Future<NetworkState<PrayerTime>> call(String city, String country) async {
    return await repository.getPrayerTimes(city, country);
  }
}
