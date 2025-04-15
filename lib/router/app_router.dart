import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../features/api_key_management/bloc/api_key_bloc.dart';
import '../features/api_key_management/views/api_key_screen.dart';
import '../features/package_integration/bloc/package_integration_bloc.dart';
import '../features/package_integration/services/package_integration_service.dart';
import '../features/package_integration/views/package_integration_screen.dart';
import '../features/platform_configuration/view/platform_configuration_screen.dart';
import '../features/project_selection/bloc/project_selection_bloc.dart';
import '../features/project_selection/views/project_selection_screen.dart';

class AppRouter {
  static GlobalKey<NavigatorState> routeKey = GlobalKey<NavigatorState>();

  static const String home = '/';
  static const String integration = '/integration';
  static const String apiKey = '/apiKey';
  static const String platformConfig = '/platformConfig';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(create: (_) => ProjectSelectionBloc(), child: const ProjectSelectionScreen()),
        );
      case integration:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider<PackageIntegrationBloc>(
                create: (_) => PackageIntegrationBloc(integrationService: PackageIntegrationService()),
                child: PackageIntegrationScreen(projectDirectory: settings.arguments as String),
              ),
        );
      case apiKey:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider<ApiKeyBloc>(
                create: (_) => ApiKeyBloc(settings.arguments as String),
                child: const ApiKeyScreen(),
              ),
        );
      case platformConfig:
        final args = settings.arguments as Map;
        return MaterialPageRoute(
          builder:
              (_) => PlatformConfigurationScreen(
                projectDirectory: args['projectDirectory'] as String,
                apiKey: args['apiKey'] as String,
              ),
        );
      default:
        return MaterialPageRoute(builder: (_) => const Scaffold(body: Center(child: Text('Page not found'))));
    }
  }
}
