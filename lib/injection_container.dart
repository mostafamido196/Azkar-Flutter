import 'package:azkar/features/ziker/data/datasources/Ziker_LocalDataSource.dart';
import 'package:azkar/features/ziker/domain/repositories/ZikerRepository.dart';
import 'package:azkar/features/ziker/domain/usecases/GetAllAzkarUsecase.dart';
import 'package:azkar/features/ziker/presentation/bloc/AzkarTitlesBloc.dart';
import 'package:get_it/get_it.dart';

import 'features/ziker/data/repositories/ZikerRepositoryImpl.dart';

final sl = GetIt.instance;

Future<void> init() async {

  // Bloc
  sl.registerFactory(() => AzkarTitlesBloc(getAzkarTitles: sl()));

  // Usecases
  sl.registerLazySingleton(() => GetAllAzkarUsecase(sl()));

  // Repository
  sl.registerLazySingleton<ZikerRepository>(() => Zikerrepositoryimpl( localDataSource: sl()));

  // Datasources
  sl.registerLazySingleton<ZikerLocaldatasource>(
      () => ZikerLocaldatasourceImpl());
}
