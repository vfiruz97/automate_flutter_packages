import 'dart:io';

class iOSConfigurationService {
  Future<String> updateInfoPlist(String projectPath, String apiKey) async {
    final infoPlistPath = '$projectPath/ios/Runner/Info.plist';
    final infoPlistFile = File(infoPlistPath);

    if (!await infoPlistFile.exists()) {
      throw Exception('Info.plist not found at $infoPlistPath');
    }

    String content = await infoPlistFile.readAsString();

    if (content.contains('<key>GMSApiKey</key>')) {
      return 'Info.plist already contains the GMSApiKey configuration.';
    }

    final apiKeyEntry = '    <key>GMSApiKey</key>\n    <string>$apiKey</string>\n';

    int lastIndex = content.lastIndexOf('</dict>');
    if (lastIndex == -1) {
      throw Exception('Malformed Info.plist: missing </dict> tag.');
    }

    final updatedContent = content.substring(0, lastIndex) + apiKeyEntry + content.substring(lastIndex);

    await infoPlistFile.writeAsString(updatedContent);
    return 'Info.plist updated successfully.';
  }
}
