import 'package:azkar/core/utils/Status.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../../../core/utils/location_helper.dart';
import '../../../domain/usecases/GetPrayerTimesUsecase.dart';
import 'PrayerTimeState.dart';

class PrayerTimesCubit extends Cubit<PrayerTimesState> {
  final GetPrayerTimesUsecase getPrayerTimesUsecase;

  PrayerTimesCubit({required this.getPrayerTimesUsecase})
      : super(const PrayerTimesIdle());

  Future<void> fetchPrayerTimesUsingLocation() async {
    print('cubit fech data');
    emit(const PrayerTimesLoading());
    try {
      // Get current location
      final locationData = await LocationUtils.getCurrentCityAndCountry();
      // Use the location data with default values if null
      final city = locationData['city'] ?? 'Cairo';
      final country = locationData['country'] ?? 'Egypt';
      final result = await getPrayerTimesUsecase.call(city, country);
      if(result.isError){
        emit(PrayerTimesError(result.message!!) );
      }
      else if (result.data != null)
        emit(PrayerTimesSuccess(result.data!!));
      else
        emit(PrayerTimesError('حاول مرة اخرى'));
    } catch (e) {
      print('cubit e: ${e.toString()}');
      emit(PrayerTimesError(e.toString()));
    }
  }

}
