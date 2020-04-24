import 'dart:async';

import 'package:flutter/services.dart';

class FlutterPushBadge {
  static const MethodChannel _channel =
      const MethodChannel('flutter_push_badge');

  /// 设置角标
  static Future<void> setBadgeNumber(String number) async {
    await _channel.invokeMethod(
      'setBadgeNumber',
      {"number": number},
    );
  }

  /// 获取角标
  static Future<String> get badgeNumber async {
    final String version = await _channel.invokeMethod('getBadgeNumber');
    return version;
  }
}
