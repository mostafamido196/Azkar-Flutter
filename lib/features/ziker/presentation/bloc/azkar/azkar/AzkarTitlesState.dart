
part of 'AzkarTitlesBloc.dart';


abstract class AzkarState extends Equatable {
  const AzkarState();

  @override
  List<Object> get props => [];
}

class AzkarInitial extends AzkarState {}

class LoadingAzkarState extends AzkarState {}

class LoadedAzkarState extends AzkarState {
  final List<Ziker> azkar;

  const LoadedAzkarState({required this.azkar});

  @override
  List<Object> get props => [azkar];
}

class ErrorAzkarState extends AzkarState {
  final String message;

  const ErrorAzkarState({required this.message});

  @override
  List<Object> get props => [message];
}