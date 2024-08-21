import 'package:azkar/features/ziker/data/datasources/SettingDataSorce.dart';
import 'package:azkar/features/ziker/data/datasources/ZikerLocalDataSource.dart';
import 'package:azkar/features/ziker/data/models/SettingModel.dart';
import 'package:azkar/features/ziker/data/repositories/SettingRepositoryImpl.dart';
import 'package:azkar/features/ziker/domain/repositories/SettingRepository.dart';
import 'package:azkar/features/ziker/domain/repositories/ZikerRepository.dart';
import 'package:azkar/features/ziker/domain/usecases/GetAllAzkarUsecase.dart';
import 'package:azkar/features/ziker/domain/usecases/SetNewSettingUsecase.dart';
import 'package:azkar/features/ziker/presentation/bloc/azkar/setting/SettingBloc.dart';
import 'package:get_it/get_it.dart';

import 'features/ziker/data/repositories/ZikerRepositoryImpl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/ziker/domain/usecases/GetOldSettingUsecase.dart';
import 'features/ziker/presentation/bloc/azkar/azkar/AzkarTitlesBloc.dart';

final sl = GetIt.instance;

Future<void> init() async {

  // Bloc
  sl.registerFactory(() => AzkarTitlesBloc(getAzkarTitles: sl()));
  sl.registerFactory(() => SettingBloc(getSettingUsecase: sl(), updateSettingUsecase: sl()));

  // Usecases
  sl.registerLazySingleton(() => GetAllAzkarUsecase(sl()));
  sl.registerLazySingleton(() => GetOldSettingUsecase(sl()));
  sl.registerLazySingleton(() => UpdateSettingUsecase(sl()));

  // Repository
  sl.registerLazySingleton<ZikerRepository>(() => Zikerrepositoryimpl( zikerDataSource: sl()));
  sl.registerLazySingleton<SettingRepository>(() => SettingRepositoryImpl(settingDataSource: sl()));

  // Datasources
  sl.registerLazySingleton<ZikerLocalDataSource>(
      () => ZikerLocalDataSourceImpl());
  sl.registerLazySingleton<SettingDataSource>(
          () => SettingDataSourceImpl(sharedPreferences: sl()));

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}
