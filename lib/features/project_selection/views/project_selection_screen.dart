import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../router/app_router.dart';
import '../bloc/project_selection_bloc.dart';

class ProjectSelectionScreen extends StatelessWidget {
  const ProjectSelectionScreen({super.key});

  Future<void> _pickProjectDirectory(BuildContext context) async {
    // Open file picker to select a directory.
    String? directoryPath = await FilePicker.platform.getDirectoryPath();

    if (!context.mounted) return;
    if (directoryPath != null) {
      context.read<ProjectSelectionBloc>().add(ValidateProjectDirectory(directoryPath: directoryPath));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('No directory selected.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Flutter Project')),
      body: BlocConsumer<ProjectSelectionBloc, ProjectSelectionState>(
        listener: (context, state) {
          if (state is ProjectSelectionError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.errorMessage)));
          } else if (state is ProjectSelectionSuccess) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('Project directory selected:\n${state.projectDirectory}')));
            Navigator.pushNamed(context, AppRouter.integration, arguments: state.projectDirectory);
          }
        },
        builder: (context, state) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => _pickProjectDirectory(context),
                  child: const Text('Select Project Directory'),
                ),
                const SizedBox(height: 20),
                if (state is ProjectSelectionLoading) const CircularProgressIndicator(),
                if (state is ProjectSelectionSuccess) Text('Selected: ${state.projectDirectory}'),
                if (state is ProjectSelectionError)
                  Text('Error: ${state.errorMessage}', style: const TextStyle(color: Colors.red)),
              ],
            ),
          );
        },
      ),
    );
  }
}
