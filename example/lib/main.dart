import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:mokone/mokone.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  bool _isNotificationPermissionGranted = false;

  final _mokonePlugin = Mokone();

  @override
  void initState() {
    super.initState();

    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    bool isNotificationPermissionGranted;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      var userID = "abc123";
      var eventName = "testEvent";
      var params = {"name": "sohel", "fcm": "token"};
      platformVersion = await _mokonePlugin.requestFcmToken() ?? 'Unknown platform version';
      isNotificationPermissionGranted = await _mokonePlugin.requestNotificationPermission() ?? false;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
      isNotificationPermissionGranted = false;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
      _isNotificationPermissionGranted = isNotificationPermissionGranted;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Mokone SDK'),
        ),
        body: Column(
          children: [
            Text('notification permission status : $_isNotificationPermissionGranted\n'),
          ],
        ),
      ),
    );
  }
}
