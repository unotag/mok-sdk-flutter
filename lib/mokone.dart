import 'dart:ffi';

import 'mokone_platform_interface.dart';

class Mokone {

  Future<void> initMokSdk(bool isProdEnv, int duration, int maxDisplayedIAMs) async {
    return await MokonePlatform.instance.initMokSdk(isProdEnv, duration, maxDisplayedIAMs);
  }

 Future<void> enableProductionEnvironment(bool isProdEnv) async {
    return await MokonePlatform.instance.enableProductionEnvironment(isProdEnv);
  }


  Future<String?> requestUpdateUser(
      {required String userId, Map<String, dynamic>? userData}) async {
    return await MokonePlatform.instance.requestUpdateUser(userId, userData);
  }

  Future<String?> requestUserId() async {
    return await MokonePlatform.instance.requestUserId();
  }

  Future<void> requestLogoutUser() async {
    await MokonePlatform.instance.requestLogoutUser();
  }

  Future<String?> requestFcmToken() async {
    return await MokonePlatform.instance.requestFcmToken();
  }

  Future<void> requestNotificationPermission() async {
    return await MokonePlatform.instance.requestNotificationPermission();
  }

  Future<void> openNotificationSettings() async {
    return await MokonePlatform.instance.openNotificationSettings();
  }

  Future<bool?> isNotificationPermissionGranted() async {
    return await MokonePlatform.instance.isNotificationPermissionGranted();
  }

  Future<void> requestIAMFromServerAndShow() async {
    await MokonePlatform.instance.requestIAMFromServerAndShow();
  }

  Future<String?> requestLogEvent(
      {required String userId,
      required String eventName,
      Map<String, dynamic>? params}) async {
    return await MokonePlatform.instance
        .requestLogEvent(userId, eventName, params);
  }

  Future<String?> getCarouselData() async {
    return await MokonePlatform.instance.requestCarouselData();
  }

  Future<void> handleBannerClick(String url) async {
    return await MokonePlatform.instance.handleBannerClick(url);
  }
}
