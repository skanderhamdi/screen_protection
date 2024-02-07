
import 'screen_protection_platform_interface.dart';

class ScreenProtection {
  Future<String?> getPlatformVersion() {
    return ScreenProtectionPlatform.instance.getPlatformVersion();
  }
}
