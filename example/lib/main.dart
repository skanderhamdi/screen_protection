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
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      init();
    });
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
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Screen Protection state: ${screenProtectionState.name}\n'),
              const SizedBox(height: 20),
              TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25)
                  ),
                  onPressed: () async {
                    print("tapped");
                    await screenProtectionPlugin.toggleScreenSecurity();
                    init();
                    print("end tapped");
                  },
                  child: Text("Toggle Screen Protection", style: TextStyle(color: Colors.white))
              )
            ]
          )
        )
      )
    );
  }
}
