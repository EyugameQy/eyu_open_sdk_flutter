import 'dart:async';

import 'package:eyu_open_sdk_flutter/src/ad_listeners.dart';
import 'package:eyu_open_sdk_flutter/src/ad_manager.dart';
import 'package:flutter/services.dart';

class EyuSdk {
  static const MethodChannel _channel =
      const MethodChannel('com.eyu.opensdk/ad');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static init() async {
    await _channel.invokeMethod('init');
  }

  static show(String adPlaceId) async {
    await _channel.invokeMethod('show', {"adPlaceId": adPlaceId});
  }

  static Future<bool?> isAdLoaded(String adPlaceId) async {
    return _channel.invokeMethod<bool>('isAdLoaded', {"adPlaceId": adPlaceId});
  }

  static setListener(EyuAdListener adListener) async {
    adManager.eyuAdListener = adListener;
  }

  static logEvent(String eventName, {Map<String, dynamic>? params}) {
    return _channel.invokeMethod<bool>(
        'logEvent', {"eventName": eventName, "params": params});
  }
}
