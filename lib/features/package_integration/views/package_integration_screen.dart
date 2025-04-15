import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/package_integration_bloc.dart';

class PackageIntegrationScreen extends StatelessWidget {
  final String projectDirectory;

  const PackageIntegrationScreen({super.key, required this.projectDirectory});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Package Integration')),
      body: BlocConsumer<PackageIntegrationBloc, PackageIntegrationState>(
        listener: (context, state) {
          if (state is PackageIntegrationError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error), backgroundColor: Colors.red));
          } else if (state is PackageIntegrationSuccess) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message), backgroundColor: Colors.green));
          }
        },
        builder: (context, state) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (state is PackageIntegrationLoading) const CircularProgressIndicator(),
                  if (state is PackageIntegrationInitial)
                    ElevatedButton(
                      onPressed: () {
                        context.read<PackageIntegrationBloc>().add(
                          IntegratePackageEvent(projectDirectory: projectDirectory),
                        );
                      },
                      child: const Text('Integrate google_maps_flutter Package'),
                    ),
                  if (state is PackageIntegrationSuccess) Text('Success: ${state.message}'),
                  if (state is PackageIntegrationError)
                    Text('Error: ${state.error}', style: const TextStyle(color: Colors.red)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
