import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../features/package_integration/bloc/package_integration_bloc.dart';
import '../features/package_integration/services/package_integration_service.dart';
import '../features/package_integration/views/package_integration_screen.dart';
import '../features/project_selection/bloc/project_selection_bloc.dart';
import '../features/project_selection/views/project_selection_screen.dart';

class AppRouter {
  static GlobalKey<NavigatorState> routeKey = GlobalKey<NavigatorState>();

  static const String home = '/';
  static const String integration = '/integration';

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
      default:
        return MaterialPageRoute(builder: (_) => const Scaffold(body: Center(child: Text('Page not found'))));
    }
  }
}
