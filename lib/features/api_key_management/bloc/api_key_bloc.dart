import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'api_key_event.dart';
part 'api_key_state.dart';

class ApiKeyBloc extends Bloc<ApiKeyEvent, ApiKeyState> {
  final String selectedDirectory;
  ApiKeyBloc(this.selectedDirectory) : super(ApiKeyInitial()) {
    on<SubmitApiKeyEvent>(_onSubmitApiKey);
    on<SkipApiKeyEvent>(_onSkipApiKey);
  }

  Future<void> _onSubmitApiKey(SubmitApiKeyEvent event, Emitter<ApiKeyState> emit) async {
    emit(ApiKeyLoading());

    if (event.apiKey.trim().isEmpty) {
      emit(const ApiKeyError(error: 'API key cannot be empty.'));
      return;
    }

    await Future.delayed(const Duration(milliseconds: 500));
    emit(ApiKeySuccess(apiKey: event.apiKey));
  }

  Future<void> _onSkipApiKey(SkipApiKeyEvent event, Emitter<ApiKeyState> emit) async {
    emit(const ApiKeySuccess(apiKey: ''));
  }
}
