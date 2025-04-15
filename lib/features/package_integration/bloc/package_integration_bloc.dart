import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../services/package_integration_service.dart';

part 'package_integration_event.dart';
part 'package_integration_state.dart';

class PackageIntegrationBloc extends Bloc<PackageIntegrationEvent, PackageIntegrationState> {
  final PackageIntegrationService integrationService;

  PackageIntegrationBloc({required this.integrationService}) : super(PackageIntegrationInitial()) {
    on<IntegratePackageEvent>(_onIntegratePackage);
  }

  Future<void> _onIntegratePackage(IntegratePackageEvent event, Emitter<PackageIntegrationState> emit) async {
    emit(PackageIntegrationLoading());
    try {
      final resultMessage = await integrationService.integratePackage(event.projectDirectory);
      emit(PackageIntegrationSuccess(message: resultMessage));
    } catch (e) {
      emit(PackageIntegrationError(error: e.toString()));
    }
  }
}
