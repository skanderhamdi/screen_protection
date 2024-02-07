import 'package:flutter/services.dart';
import 'screen_protection_platform_interface.dart';

/// An implementation of [ScreenProtectionPlatform] that uses method channels.
class MethodChannelScreenProtection extends ScreenProtectionPlatform {
  /// The method channel [channel] that will be used to communicate with Android Native platform
  final channel = const MethodChannel('screen_protection');

  /// The function [secureScreen] that activates the screen security (preventing screenshots and screen recording)
  @override
  Future<bool?> secureScreen() async => await channel.invokeMethod<bool?>('secureScreen');

  /// The function [unsecureScreen] that deactivates the screen security (allowing screenshots and screen recording)
  @override
  Future<bool?> unsecureScreen() async => await channel.invokeMethod<bool?>('unsecureScreen');
  @override

  /// The function [isScreenSecured] that returns true if  the screen security is activated, and false otherwise
  Future<bool?> isScreenSecured() async => await channel.invokeMethod<bool?>('isScreenSecured');
  @override

  /// The function [toggleScreenSecurity] that turns screen security ON if it is disabled and inverse
  Future<bool?> toggleScreenSecurity() async => await channel.invokeMethod<bool?>('toggleScreenSecurity');
}
