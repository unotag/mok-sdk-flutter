import 'dart:ffi';

import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'mokone_method_channel.dart';

abstract class MokonePlatform extends PlatformInterface {
  /// Constructs a MokonePlatform.
  MokonePlatform() : super(token: _token);

  static final Object _token = Object();

  static MokonePlatform _instance = MethodChannelMokone();

  /// The default instance of [MokonePlatform] to use.
  ///
  /// Defaults to [MethodChannelMokone].
  static MokonePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [MokonePlatform] when
  /// they register themselves.
  static set instance(MokonePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<void> initMokSdk(bool isProdEnv, int duration) {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }


  Future<void> enableProductionEnvironment(bool isProdEnv) {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  //region user
  Future<String?> requestUpdateUser(
      String userId, Map<String, dynamic>? userData) {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<String?> requestUserId() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<void> requestLogoutUser() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  //endregion

  //region notification
  Future<String?> requestFcmToken() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<void> requestNotificationPermission() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<void> openNotificationSettings() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<bool?> isNotificationPermissionGranted() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  //endregion

  Future<void> requestIAMFromServerAndShow() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  //log event
  Future<String?> requestLogEvent(
      String userId, String eventName, Map<String, dynamic>? params) {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
