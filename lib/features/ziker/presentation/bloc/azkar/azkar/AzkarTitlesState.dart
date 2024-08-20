
part of 'AzkarTitlesBloc.dart';


abstract class AzkarTitlesState extends Equatable {
  const AzkarTitlesState();

  @override
  List<Object> get props => [];
}

class AzkarTitlesInitial extends AzkarTitlesState {}

class LoadingAzkarTitlesState extends AzkarTitlesState {}

class LoadedAzkarTitlesState extends AzkarTitlesState {
  final List<Ziker> azkar;

  const LoadedAzkarTitlesState({required this.azkar});

  @override
  List<Object> get props => [azkar];
}

class ErrorAzkarTitlesState extends AzkarTitlesState {
  final String message;

  const ErrorAzkarTitlesState({required this.message});

  @override
  List<Object> get props => [message];
}