part of 'project_selection_bloc.dart';

abstract class ProjectSelectionEvent extends Equatable {
  const ProjectSelectionEvent();
  @override
  List<Object> get props => [];
}

class ValidateProjectDirectory extends ProjectSelectionEvent {
  final String directoryPath;
  const ValidateProjectDirectory({required this.directoryPath});
  @override
  List<Object> get props => [directoryPath];
}
