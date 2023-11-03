import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'mokone_platform_interface.dart';

/// An implementation of [MokonePlatform] that uses method channels.
class MethodChannelMokone extends MokonePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('mokone');

  @override
  Future<String?> requestUpdateUser(
      String userId, Map<String, dynamic>? userData) async {
    var arguments = {
      'userId': userId,
      'userData': userData,
    };
    final result =
        await methodChannel.invokeMethod<String>('updateUser', arguments);
    return result;
  }

  @override
  Future<String?> requestUserId() async {
    final result = await methodChannel.invokeMethod<String>('getUserId');
    return result;
  }

  @override
  Future<void> requestLogoutUser() async {
    await methodChannel.invokeMethod<void>('logoutUser');
  }

  @override
  Future<String?> requestFcmToken() async {
    final fcmToken = await methodChannel.invokeMethod<String>('getFcmToken');
    return fcmToken;
  }

  @override
  Future<void> requestNotificationPermission() async {
    await methodChannel.invokeMethod<void>('getNotificationPermission');
  }

  @override
  Future<void> openNotificationSettings() async {
    await methodChannel.invokeMethod<void>('openNotificationSettings');
  }

  @override
  Future<bool?> isNotificationPermissionGranted() async {
    final result = await methodChannel
        .invokeMethod<bool>('isNotificationPermissionGranted');
    return result;
  }

  @override
  Future<void> requestIAMFromServerAndShow() async {
    await methodChannel.invokeMethod<void>('getIAMFromServerAndShow');
  }

  @override
  Future<String?> requestLogEvent(
      String userId, String eventName, Map<String, dynamic>? params) async {
    var arguments = {
      'userId': userId,
      'eventName': eventName,
      'params': params
    };
    final result =
        await methodChannel.invokeMethod<String>('logEvent', arguments);
    return result;
  }
}
