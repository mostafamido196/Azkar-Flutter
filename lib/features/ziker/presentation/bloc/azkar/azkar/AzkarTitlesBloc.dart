import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/error/failures.dart';
import '../../../../../../core/strings/failures.dart';
import '../../../../domain/entities/Ziker.dart';
import '../../../../domain/usecases/GetAllAzkarUsecase.dart';

part 'AzkarTitlesEvent.dart';
part 'AzkarTitlesState.dart';

class AzkarBloc extends Bloc<AzkarTitlesEvent, AzkarState> {

  final GetAllAzkarUsecase getAzkarTitles;
  AzkarBloc({
    required this.getAzkarTitles,
  }) : super(AzkarInitial()) {
    on<AzkarTitlesEvent>((event, emit) async {
      if (event is GetAllAzkarTitlesEvent) {
        emit(LoadingAzkarState());
        final failureOrPosts = await getAzkarTitles();
        emit(_mapFailureOrAzkarToState(failureOrPosts));
      }

    });
  }

  AzkarState _mapFailureOrAzkarToState(Either<Failure, List<Ziker>> either) {
    return either.fold(
          (failure) => ErrorAzkarState(message: _mapFailureToMessage(failure)),
          (azkar) => LoadedAzkarState(
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