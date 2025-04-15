part of 'api_key_bloc.dart';

abstract class ApiKeyEvent extends Equatable {
  const ApiKeyEvent();
  @override
  List<Object> get props => [];
}

class SubmitApiKeyEvent extends ApiKeyEvent {
  final String apiKey;
  const SubmitApiKeyEvent({required this.apiKey});

  @override
  List<Object> get props => [apiKey];
}

class SkipApiKeyEvent extends ApiKeyEvent {}
