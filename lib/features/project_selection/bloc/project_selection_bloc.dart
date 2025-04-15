import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'project_selection_event.dart';
part 'project_selection_state.dart';

class ProjectSelectionBloc extends Bloc<ProjectSelectionEvent, ProjectSelectionState> {
  ProjectSelectionBloc() : super(ProjectSelectionInitial()) {
    on<ValidateProjectDirectory>(_onValidateProjectDirectory);
  }

  Future<void> _onValidateProjectDirectory(ValidateProjectDirectory event, Emitter<ProjectSelectionState> emit) async {
    emit(ProjectSelectionLoading());

    try {
      final directory = Directory(event.directoryPath);
      final pubspec = File('${directory.path}/pubspec.yaml');

      if (await pubspec.exists()) {
        emit(ProjectSelectionSuccess(projectDirectory: directory.path));
      } else {
        emit(const ProjectSelectionError(errorMessage: 'The selected folder does not contain a pubspec.yaml file.'));
      }
    } catch (e) {
      emit(ProjectSelectionError(errorMessage: 'An error occurred: $e'));
    }
  }
}
