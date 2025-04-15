import 'package:flutter/material.dart';

import '../services/platform_configuration_service.dart';

class PlatformConfigurationScreen extends StatelessWidget {
  final String projectDirectory;
  final String apiKey;

  const PlatformConfigurationScreen({super.key, required this.projectDirectory, required this.apiKey});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Platform Configuration")),
      body: FutureBuilder<String>(
        future: PlatformConfigurationService().configurePlatforms(projectDirectory, apiKey),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}", style: const TextStyle(color: Colors.red)));
          }
          return Center(child: Text("Configuration result:\n${snapshot.data}", textAlign: TextAlign.center));
        },
      ),
    );
  }
}
