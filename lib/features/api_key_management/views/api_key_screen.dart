import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../router/app_router.dart';
import '../bloc/api_key_bloc.dart';

class ApiKeyScreen extends StatefulWidget {
  const ApiKeyScreen({super.key});

  @override
  State<ApiKeyScreen> createState() => _ApiKeyScreenState();
}

class _ApiKeyScreenState extends State<ApiKeyScreen> {
  final TextEditingController _apiKeyController = TextEditingController();

  @override
  void dispose() {
    _apiKeyController.dispose();
    super.dispose();
  }

  void _submitApiKey() {
    final apiKey = _apiKeyController.text;
    context.read<ApiKeyBloc>().add(SubmitApiKeyEvent(apiKey: apiKey));
  }

  void _skipApiKey() {
    context.read<ApiKeyBloc>().add(SkipApiKeyEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Google Maps API Key')),
      body: BlocConsumer<ApiKeyBloc, ApiKeyState>(
        listener: (context, state) {
          if (state is ApiKeySuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.apiKey.isNotEmpty ? 'API Key successfully saved.' : 'API Key skipped.'),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.pushNamed(
              context,
              AppRouter.platformConfig,
              arguments: {'projectDirectory': context.read<ApiKeyBloc>().selectedDirectory, 'apiKey': state.apiKey},
            );
          } else if (state is ApiKeyError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error), backgroundColor: Colors.red));
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Enter your Google Maps API Key. '
                  'If you have already configured it, you can skip.',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _apiKeyController,
                  decoration: const InputDecoration(labelText: 'API Key', border: OutlineInputBorder()),
                ),
                const SizedBox(height: 20),
                if (state is ApiKeyLoading)
                  const CircularProgressIndicator()
                else
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(onPressed: _submitApiKey, child: const Text('Submit')),
                      ElevatedButton(onPressed: _skipApiKey, child: const Text('Skip')),
                    ],
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
