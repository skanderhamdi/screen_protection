import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'screen_protection_method_channel.dart';

abstract class ScreenProtectionPlatform extends PlatformInterface {
  /// Constructs a ScreenProtectionPlatform.
  ScreenProtectionPlatform() : super(token: _token);

  static final Object _token = Object();

  static ScreenProtectionPlatform _instance = MethodChannelScreenProtection();

  /// The default instance of [ScreenProtectionPlatform] to use.
  ///
  /// Defaults to [MethodChannelScreenProtection].
  static ScreenProtectionPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [ScreenProtectionPlatform] when
  /// they register themselves.
  static set instance(ScreenProtectionPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
