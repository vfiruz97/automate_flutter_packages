part of 'package_integration_bloc.dart';

abstract class PackageIntegrationEvent extends Equatable {
  const PackageIntegrationEvent();
  @override
  List<Object> get props => [];
}

class IntegratePackageEvent extends PackageIntegrationEvent {
  final String projectDirectory;
  const IntegratePackageEvent({required this.projectDirectory});

  @override
  List<Object> get props => [projectDirectory];
}
