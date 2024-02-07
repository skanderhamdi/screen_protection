import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'screen_protection_platform_interface.dart';

/// An implementation of [ScreenProtectionPlatform] that uses method channels.
class MethodChannelScreenProtection extends ScreenProtectionPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('screen_protection');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
