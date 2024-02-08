# screen_protection
An awesome plugin that secures your Flutter app's screen from screenshot &amp; screen record

[![Android](https://img.shields.io/badge/Platform-Android-green.svg)](https://developer.android.com/)
[![iOS](https://img.shields.io/badge/Platform-iOS-blue.svg)](https://developer.apple.com/ios/)
[![Flutter SDK](https://img.shields.io/badge/Flutter-SDK-blue.svg)](https://flutter.dev/)
[![Dart](https://img.shields.io/badge/Dart-Language-blue.svg)](https://dart.dev/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Contributions welcome](https://img.shields.io/badge/Contributions-Welcome-brightgreen.svg)](CONTRIBUTING.md)

The **Screen Protection Plugin** is a Flutter plugin that provides functionality to control and monitor screen security on both Android and iOS platforms. It allows you to prevent or allow screenshots and screen recording, giving you control over the security of your Flutter app' screen.
___

## Features

- **Prevent/Allow Screenshots and Screen Recording:** Choose whether to allow or prevent users from taking screenshots and screen recordings within your Flutter application.

- **Cross-Platform Support:** The plugin is designed to work seamlessly on both Android and iOS platforms, ensuring consistent behavior across devices.

- **Enable/Disable Screen Protection:** Easily toggle screen protection on and off based on your application's requirements.

- **Get Screen Protection State:** Retrieve the current state of screen protection to dynamically adapt your app's behavior.

- **Good news! iOS 17 Compatibility:** The plugin continues to offer its functionality even on iOS 17 and above, addressing the reported lack of support in the latest iOS versions.

#### Demonstration for Screenshots and Screen recording prevention

<div style="display:flex; justify-content:start;">
  <img style="margin-right: 30px" src="https://i.ibb.co/XksqQWq/flutter-screen-protection-screenshot.gif" alt="Screenshot Protection" width="250"/>
  <img src="https://i.ibb.co/yBdwLW6/flutter-screen-protection-screen-record.gif" alt="Screen Recording Protection" width="250"/>
</div>

To use the **Screen Protection Plugin** in your Flutter project, follow these simple steps:

1. Add the following dependency to your `pubspec.yaml` file:

```yaml
dependencies:
  screen_protection_plugin:
    git: 
      url: https://github.com/skanderhamdi/screen_protection.git
      ref: master
```

2. Run `flutter pub get` in your terminal to fetch the new dependency.

3. Import the package in your Dart code:

```dart
import 'package:screen_protection_plugin/screen_protection_plugin.dart';
```

3. Create an instance of `ScreenProtection`

```dart
final screenProtectionPlugin = ScreenProtection();
```
___

## Usage

#### Retrieve the state of the screen protection `ScreenProtectionState`

```dart
final state = screenProtectionPlugin.isScreenSecured();
```

#### Enable Screen Protection

```dart
bool? enable = await screenProtectionPlugin.secureScreen();
```

#### Disable Screen Protection

```dart
bool? disable = await screenProtectionPlugin.unsecureScreen();
```

#### Toggle Screen Protection

```dart
bool? toggle = await screenProtectionPlugin.toggleScreenSecurity();
```

___

## Full usage example

```dart
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:screen_protection/screen_protection.dart';
import 'package:screen_protection/screen_security_enum.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  ScreenProtectionState screenProtectionState = ScreenProtectionState.unknown;
  final screenProtectionPlugin = ScreenProtection();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => init());
  }

  Future<void> init() async {
    late ScreenProtectionState state;
    try {
      state = await screenProtectionPlugin.isScreenSecured();
    } on PlatformException {
      state = ScreenProtectionState.unknown;
    }
    if (!mounted) return;
    setState(() {
      screenProtectionState = state;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: const Text('Flutter Screen Protection'),
            ),
            body: Center(
                child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Screen Protection state: ${screenProtectionState.name}\n'),
                      const SizedBox(height: 20),
                      const Text('Try making Screenshot or Screen record'),
                      const SizedBox(height: 20),
                      TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.blue,
                              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25)
                          ),
                          onPressed: () async {
                            await screenProtectionPlugin.toggleScreenSecurity();
                            init();
                          },
                          child: const Text("Toggle Screen Protection", style: TextStyle(color: Colors.white))
                      )
                    ]
                )
            )
        )
    );
  }
}
```
___
## Contribution
Contributions are welcome! Feel free to open issues, submit pull requests, or provide feedback.

We appreciate your help in making this package better!