import 'package:azkar/core/utils/Status.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../domain/usecases/GetPrayerTimesUsecase.dart';
import 'PrayerTimeState.dart';

class PrayerTimesCubit extends Cubit<PrayerTimesState> {
  final GetPrayerTimesUsecase getPrayerTimesUsecase;

  PrayerTimesCubit({required this.getPrayerTimesUsecase})
      : super(const PrayerTimesIdle());

  Future<void> fetchPrayerTimes(String city, String country) async {
    print('cubit fech data');
    emit(const PrayerTimesLoading());
    try {
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
