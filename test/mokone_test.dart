import 'package:flutter_test/flutter_test.dart';
import 'package:mokone/mokone.dart';
import 'package:mokone/mokone_platform_interface.dart';
import 'package:mokone/mokone_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockMokonePlatform
    with MockPlatformInterfaceMixin
    implements MokonePlatform {


  @override
  Future<String?> requestFcmToken() {
    throw UnimplementedError();
  }

  @override
  Future<String?> requestUpdateUser(String userId, Map<String, dynamic>? userData) {
    throw UnimplementedError();
  }

  @override
  Future<String?> requestLogEvent(String userId, String eventName, Map<String, dynamic>? params) {
    throw UnimplementedError();
  }

  @override
  Future<bool?> requestNotificationPermission() {
    // TODO: implement requestNotificationPermission
    throw UnimplementedError();
  }
}

void main() {
  final MokonePlatform initialPlatform = MokonePlatform.instance;

  test('$MethodChannelMokone is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelMokone>());
  });
}
