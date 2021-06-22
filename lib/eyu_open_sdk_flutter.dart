
import 'dart:async';

import 'package:flutter/services.dart';

class EyuOpenSdkFlutter {
  static const MethodChannel _channel =
      const MethodChannel('eyu_open_sdk_flutter');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
