import 'android_configuration_service.dart';
import 'ios_configuration_service.dart';

class PlatformConfigurationService {
  final AndroidConfigurationService androidService;
  final iOSConfigurationService iosService;

  PlatformConfigurationService({AndroidConfigurationService? androidService, iOSConfigurationService? iosService})
    : androidService = androidService ?? AndroidConfigurationService(),
      iosService = iosService ?? iOSConfigurationService();

  Future<String> configurePlatforms(String projectPath, String apiKey) async {
    final androidMessage = await androidService.updateAndroidManifest(projectPath, apiKey);
    final iosMessage = await iosService.updateInfoPlist(projectPath, apiKey);
    return 'Android: $androidMessage\n iOS: $iosMessage';
  }
}
