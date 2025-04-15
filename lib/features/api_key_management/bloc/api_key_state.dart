part of 'api_key_bloc.dart';

abstract class ApiKeyState extends Equatable {
  const ApiKeyState();
  @override
  List<Object> get props => [];
}

class ApiKeyInitial extends ApiKeyState {}

class ApiKeyLoading extends ApiKeyState {}

class ApiKeySuccess extends ApiKeyState {
  final String apiKey;
  const ApiKeySuccess({required this.apiKey});

  @override
  List<Object> get props => [apiKey];
}

class ApiKeyError extends ApiKeyState {
  final String error;
  const ApiKeyError({required this.error});

  @override
  List<Object> get props => [error];
}
