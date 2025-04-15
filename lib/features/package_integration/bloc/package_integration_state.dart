part of 'package_integration_bloc.dart';

abstract class PackageIntegrationState extends Equatable {
  const PackageIntegrationState();
  @override
  List<Object> get props => [];
}

class PackageIntegrationInitial extends PackageIntegrationState {}

class PackageIntegrationLoading extends PackageIntegrationState {}

class PackageIntegrationSuccess extends PackageIntegrationState {
  final String message;
  const PackageIntegrationSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

class PackageIntegrationError extends PackageIntegrationState {
  final String error;
  const PackageIntegrationError({required this.error});

  @override
  List<Object> get props => [error];
}
