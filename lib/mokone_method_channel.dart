import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'mokone_platform_interface.dart';

/// An implementation of [MokonePlatform] that uses method channels.
class MethodChannelMokone extends MokonePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('mokone');


  @override
  Future<String?> requestFcmToken() async {
    final fcmToken = await methodChannel.invokeMethod<String>('getFcmToken');
    return fcmToken;
  }

  @override
  Future<String?> requestUpdateUser(String userId, Map<String, dynamic>? userData) async {
    var arguments = {
      'userId': userId,
      'userData': userData,
    };
    final result = await methodChannel.invokeMethod<String>('updateUser', arguments);
    return result;
  }

  @override
  Future<String?> requestLogEvent(String userId, String eventName, Map<String, dynamic>? params) async {
    var arguments = {'userId': userId,
      'eventName': eventName,
      'params': params};
    final result = await methodChannel.invokeMethod<String>('logEvent', arguments);
    return result;
  }

  @override
  Future<bool?> requestNotificationPermission() async{
    final result = await methodChannel.invokeMethod<bool>('notificationPermission');
    return result;
  }
}
