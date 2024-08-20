import 'package:azkar/features/ziker/domain/usecases/GetAllAzkarUsecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/error/failures.dart';
import '../../../../../../core/strings/failures.dart';
import '../../../../domain/entities/Ziker.dart';

part 'AzkarTitlesEvent.dart';
part 'AzkarTitlesState.dart';

class AzkarTitlesBloc extends Bloc<AzkarTitlesEvent, AzkarTitlesState> {

  final GetAllAzkarUsecase getAzkarTitles;
  AzkarTitlesBloc({
    required this.getAzkarTitles,
  }) : super(AzkarTitlesInitial()) {
    on<AzkarTitlesEvent>((event, emit) async {
      if (event is GetAllAzkarTitlesEvent) {
        emit(LoadingAzkarTitlesState());
        final failureOrPosts = await getAzkarTitles();
        emit(_mapFailureOrAzkarToState(failureOrPosts));
      }

    });
  }

  AzkarTitlesState _mapFailureOrAzkarToState(Either<Failure, List<Ziker>> either) {
    return either.fold(
          (failure) => ErrorAzkarTitlesState(message: _mapFailureToMessage(failure)),
          (azkar) => LoadedAzkarTitlesState(
         azkar: azkar,
      ),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case EmptyCacheFailure:
        return EMPTY_CACHE_FAILURE_MESSAGE;
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return "Unexpected Error , Please try again later .";
    }
  }
}