import 'dart:io';

class AndroidConfigurationService {
  Future<String> updateAndroidManifest(String projectPath, String apiKey) async {
    final manifestPath = '$projectPath/android/app/src/main/AndroidManifest.xml';
    final manifestFile = File(manifestPath);

    if (!await manifestFile.exists()) {
      throw Exception('AndroidManifest.xml not found at $manifestPath');
    }

    String content = await manifestFile.readAsString();

    if (content.contains('android:name="com.google.android.geo.API_KEY"')) {
      return 'AndroidManifest.xml already contains the API key configuration.';
    }

    final metaDataTag = '    <meta-data android:name="com.google.android.geo.API_KEY" android:value="$apiKey"/>\n';

    if (!content.contains('</application>')) {
      throw Exception('Malformed AndroidManifest.xml: missing </application> tag.');
    }

    final updatedContent = content.replaceFirst('</application>', '$metaDataTag</application>');

    const internetPermissionTag = '<uses-permission android:name="android.permission.INTERNET" />';
    if (!content.contains(internetPermissionTag)) {
      final manifestMatch = RegExp(r'<manifest[^>]*>').firstMatch(content);
      if (manifestMatch != null) {
        final index = manifestMatch.end;
        content = '${content.substring(0, index)}\n    $internetPermissionTag${content.substring(index)}';
      }
    }

    await manifestFile.writeAsString(updatedContent);
    return 'AndroidManifest.xml updated successfully.';
  }
}
