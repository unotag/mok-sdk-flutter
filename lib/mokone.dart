import 'mokone_platform_interface.dart';

class Mokone {
  Future<String?> requestFcmToken() async {
    return await MokonePlatform.instance.requestFcmToken();
  }

  Future<String?> requestUpdateUser({required String userId, Map<String, dynamic>? userData}) async {
    return await MokonePlatform.instance.requestUpdateUser(userId, userData);
  }

  Future<String?> requestLogEvent(
      {required String userId, required String eventName, Map<String, dynamic>? params}) async {
    return await MokonePlatform.instance.requestLogEvent(userId, eventName, params);
  }

  Future<bool?> requestNotificationPermission() async {
    return await MokonePlatform.instance.requestNotificationPermission();
  }
}
