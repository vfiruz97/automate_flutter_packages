import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../features/project_selection/bloc/project_selection_bloc.dart';
import '../features/project_selection/views/project_selection_screen.dart';

class AppRouter {
  static GlobalKey<NavigatorState> routeKey = GlobalKey<NavigatorState>();

  static const String home = '/';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(create: (_) => ProjectSelectionBloc(), child: const ProjectSelectionScreen()),
        );
      default:
        return MaterialPageRoute(builder: (_) => const Scaffold(body: Center(child: Text('Page not found'))));
    }
  }
}
