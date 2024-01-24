import 'dart:ffi';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:mokone/carousel_banner/carousel_banner.dart';
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
  TextEditingController _userIdController = TextEditingController();
  TextEditingController _enterEventNameController = TextEditingController();
  TextEditingController _enterParamsController = TextEditingController();
  String _platformVersion = 'Unknown';
  bool _isNotificationPermissionGranted = false;

  final _mokonePlugin = Mokone();

  @override
  void initState() {
    super.initState();

    //initPlatformState();
    initMokSdk();

    _userIdController.text = "MOFSDK_002";
  }

  initMokSdk() async {
    await _mokonePlugin.initMokSdk(false, 6000, 5);
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

      //todo
      // isNotificationPermissionGranted =
      //     await _mokonePlugin.requestNotificationPermission() ?? false;
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
      _isNotificationPermissionGranted = false;
      // _isNotificationPermissionGranted = false??isNotificationPermissionGranted;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Mokone SDK'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              MokCarouselBanner(),
              _updateUserId(),
              _logEvent(),
              _fcmToken(""),
              _notificationPermissionStatus(_isNotificationPermissionGranted ? "Granted" : "Denied"),
              _inAppMsg(10),
            ],
          ),
        ),
      ),
    );
  }

  Widget _updateUserId() {
    return Container(
      decoration: BoxDecoration(color: Colors.deepPurple.shade100),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextFormField(
            controller: _userIdController,
            decoration: const InputDecoration(label: Text("Enter User ID")),
          ),
          const SizedBox(
            height: 16,
          ),
          MaterialButton(
            minWidth: double.maxFinite,
            onPressed: () async {
              await _mokonePlugin.requestUpdateUser(userId: _userIdController.text, userData: {'name': 'karan'});
              await _mokonePlugin.requestIAMFromServerAndShow();
            },
            color: Colors.deepPurple,
            child: const Text(
              "UPDATE USER ID",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }

  Widget _logEvent() {
    return Container(
      decoration: BoxDecoration(color: Colors.green.shade100),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextFormField(
            controller: _enterEventNameController,
            decoration: const InputDecoration(label: Text("Enter Event Name")),
          ),
          const SizedBox(
            height: 16,
          ),
          TextFormField(
            controller: _enterParamsController,
            decoration: const InputDecoration(
                label: Text("Enter Params"),
                helperText: "Add key value pair with comma separator\nEg - {'points':'100','pageName':'dashboard'} "),
          ),
          const SizedBox(
            height: 16,
          ),
          MaterialButton(
            minWidth: double.maxFinite,
            onPressed: () {},
            color: Colors.green,
            child: const Text(
              "LOG EVENT",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }

  Widget _fcmToken(String fcmtoken) {
    return Container(
      decoration: BoxDecoration(color: Colors.red.shade100),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("FCM Token: $fcmtoken"),
          const SizedBox(
            height: 16,
          ),
          MaterialButton(
            minWidth: double.maxFinite,
            onPressed: () {},
            color: Colors.red,
            child: const Text(
              "FETCH FCM",
              style: TextStyle(color: Colors.white),
            ),
          ),
          MaterialButton(
            minWidth: double.maxFinite,
            onPressed: () {},
            color: Colors.red,
            child: const Text(
              "UPDATE FCM",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _notificationPermissionStatus(String status) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(color: Colors.pink.shade100),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Notification Permission Status : $status"),
          const SizedBox(
            height: 16,
          ),
          MaterialButton(
            minWidth: double.maxFinite,
            onPressed: () {},
            color: Colors.pink,
            child: const Text(
              "ASK NOTIFICATION PERMISSION",
              style: TextStyle(color: Colors.white),
            ),
          ),
          MaterialButton(
            minWidth: double.maxFinite,
            onPressed: () {},
            color: Colors.pink,
            child: const Text(
              "OPEN NOTIFICATION SETTINGS",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _inAppMsg(int msgCount) {
    return Container(
      decoration: BoxDecoration(color: Colors.blue.shade100),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("In App MSG Count : $msgCount"),
          const SizedBox(
            height: 16,
          ),
          MaterialButton(
            minWidth: double.maxFinite,
            onPressed: () {},
            color: Colors.blue,
            child: const Text(
              "SHOW IN APP MESSAGE",
              style: TextStyle(color: Colors.white),
            ),
          ),
          MaterialButton(
            minWidth: double.maxFinite,
            onPressed: () {},
            color: Colors.blue,
            child: const Text(
              "DELETE ALL IN APP MESSAGE",
              style: TextStyle(color: Colors.white),
            ),
          ),
          MaterialButton(
            minWidth: double.maxFinite,
            onPressed: () {},
            color: Colors.blue,
            child: const Text(
              "RESET ALL IN APP MESSAGE",
              style: TextStyle(color: Colors.white),
            ),
          ),
          MaterialButton(
            minWidth: double.maxFinite,
            onPressed: () {},
            color: Colors.blue,
            child: const Text(
              "FETCH IN APP MESSAGE",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
