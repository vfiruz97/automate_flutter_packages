import 'dart:io';

import 'package:yaml/yaml.dart';
import 'package:yaml_edit/yaml_edit.dart';

class PackageIntegrationService {
  static const String packageName = 'google_maps_flutter';

  /// Integrates google_maps_flutter into the given Flutter project's pubspec.yaml.
  /// Returns a success message with the output of `flutter pub get` or an informational message
  /// if the dependency already exists.
  Future<String> integratePackage(String projectPath) async {
    final pubspecPath = '$projectPath/pubspec.yaml';
    final pubspecFile = File(pubspecPath);

    // Validate pubspec.yaml exists
    if (!await pubspecFile.exists()) {
      throw Exception('pubspec.yaml not found at path: $pubspecPath');
    }

    try {
      final String content = await pubspecFile.readAsString();
      final YamlMap pubspecYaml = loadYaml(content);

      if (!pubspecYaml.containsKey('dependencies')) {
        throw Exception('Dependencies section not found in pubspec.yaml.');
      }

      // Check if the package is already listed in dependencies
      final dependencies = pubspecYaml['dependencies'];
      if (dependencies is YamlMap && dependencies.containsKey(packageName)) {
        return '$packageName dependency is already present in pubspec.yaml.';
      }

      final yamlEditor = YamlEditor(content);
      // TODO: Fetch the latest version of the package from pub API and update accordingly
      yamlEditor.update(['dependencies', packageName], 'any');

      // Write the modified content back to pubspec.yaml
      await pubspecFile.writeAsString(yamlEditor.toString());

      // Run `flutter pub get` in the project directory
      final result = await Process.run('flutter', ['pub', 'get'], workingDirectory: projectPath, runInShell: true);

      if (result.exitCode != 0) {
        final errorMessage = result.stderr.toString().trim();
        throw Exception('Error during flutter pub get: $errorMessage');
      }

      return 'Dependency $packageName added successfully and flutter pub get completed:\n${result.stdout}';
    } catch (e) {
      if (e is Exception) {
        rethrow;
      }
      throw Exception('Failed to integrate package: $e');
    }
  }
}
