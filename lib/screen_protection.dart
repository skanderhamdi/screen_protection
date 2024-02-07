import 'package:screen_protection/screen_security_enum.dart';
import 'screen_protection_platform_interface.dart';


/// [ScreenProtection] class that will be used by developers
class ScreenProtection {
  /// [secureScreen] turns on screen protection
  Future<bool?> secureScreen() async {
    return ScreenProtectionPlatform.instance.secureScreen();
  }

  /// [unsecureScreen] turns off screen protection
  Future<bool?> unsecureScreen() {
    return ScreenProtectionPlatform.instance.unsecureScreen();
  }

  /// [isScreenSecured] returns a flag [ScreenProtectionState]
  /// The flag [ScreenProtectionState] indicates the protection status
  /// [ScreenProtectionState.secured], [ScreenProtectionState.notSecured], or [ScreenProtectionState.unknown] if the native method could not complete properly
  Future<ScreenProtectionState> isScreenSecured() async {
    bool? state = await ScreenProtectionPlatform.instance.isScreenSecured();
    if(state == null) {
      return ScreenProtectionState.unknown;
    } else {
      return state ? ScreenProtectionState.secured : ScreenProtectionState.notSecured;
    }
  }

  /// [toggleScreenSecurity] turns OFF screen protection if enabled
  /// or turns ON if disabled
  Future<bool?> toggleScreenSecurity() {
    return ScreenProtectionPlatform.instance.toggleScreenSecurity();
  }
}
