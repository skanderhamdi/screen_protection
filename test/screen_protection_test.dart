import 'package:flutter_test/flutter_test.dart';
import 'package:screen_protection/screen_protection.dart';
import 'package:screen_protection/screen_protection_platform_interface.dart';
import 'package:screen_protection/screen_protection_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockScreenProtectionPlatform
    with MockPlatformInterfaceMixin
    implements ScreenProtectionPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final ScreenProtectionPlatform initialPlatform = ScreenProtectionPlatform.instance;

  test('$MethodChannelScreenProtection is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelScreenProtection>());
  });

  test('getPlatformVersion', () async {
    ScreenProtection screenProtectionPlugin = ScreenProtection();
    MockScreenProtectionPlatform fakePlatform = MockScreenProtectionPlatform();
    ScreenProtectionPlatform.instance = fakePlatform;

    expect(await screenProtectionPlugin.getPlatformVersion(), '42');
  });
}
