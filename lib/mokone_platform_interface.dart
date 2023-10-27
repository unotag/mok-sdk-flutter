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


  Future<String?> requestFcmToken() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<String?> requestUpdateUser(String userId, Map<String, dynamic>? userData) {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<String?> requestLogEvent(String userId, String eventName,  Map<String, dynamic>? params) {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<bool?> requestNotificationPermission() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
