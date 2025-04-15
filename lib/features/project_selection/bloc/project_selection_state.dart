part of 'project_selection_bloc.dart';

abstract class ProjectSelectionState extends Equatable {
  const ProjectSelectionState();
  @override
  List<Object> get props => [];
}

class ProjectSelectionInitial extends ProjectSelectionState {}

class ProjectSelectionLoading extends ProjectSelectionState {}

class ProjectSelectionSuccess extends ProjectSelectionState {
  final String projectDirectory;
  const ProjectSelectionSuccess({required this.projectDirectory});
  @override
  List<Object> get props => [projectDirectory];
}

class ProjectSelectionError extends ProjectSelectionState {
  final String errorMessage;
  const ProjectSelectionError({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}
