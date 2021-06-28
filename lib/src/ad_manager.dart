// Copyright 2021 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// https://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

// ignore_for_file: public_member_api_docs

// ignore_for_file: deprecated_member_use_from_same_package

import 'dart:async';
import 'dart:collection';

import 'package:eyu_open_sdk_flutter/src/ad_listeners.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'ad_containers.dart';

EyuAdManager adManager = EyuAdManager(
  'com.eyu.opensdk/ad',
);

class EyuAdManager {
  EyuAdManager(String channelName) : channel =
  MethodChannel(channelName, StandardMethodCodec(AdMessageCodec())) {
    channel.setMethodCallHandler((MethodCall call) async {
      assert(call.method == 'onAdEvent');
      final EyuAd ad = call.arguments['ad'];
      final eventName = call.arguments['eventName'];
      _onAdEvent(ad,eventName,call.arguments);
    });
  }

  /// Invokes load and dispose calls.
  final MethodChannel channel;
  EyuAdListener? eyuAdListener;
  void _onAdEvent(EyuAd ad,String eventName,Map<dynamic, dynamic> arguments) {
    _onAdEventAndroid(ad,eventName, arguments);
  }

  void _onAdEventAndroid(EyuAd ad, String eventName,
      Map<dynamic, dynamic> arguments) {
    switch (eventName) {
      case 'onAdLoaded':
        eyuAdListener?.onAdLoaded?.call(ad);
        break;
      case 'onAdLoadFailed':
        eyuAdListener?.onAdLoadFailed?.call(ad,arguments["error"]);
        break;
      case 'onAdShowed':
        eyuAdListener?.onAdShowed?.call(ad);
        break;
      case 'onAdClosed':
        eyuAdListener?.onAdClosed?.call(ad);
        break;
      case 'onAdClicked':
        eyuAdListener?.onAdClicked?.call(ad);
        break;
      case 'onAdReward':
        eyuAdListener?.onAdReward?.call(ad);
        break;
      case 'onAdImpression':
        eyuAdListener?.onAdImpression?.call(ad);
        break;
      case 'onAdShowFailed':
        eyuAdListener?.onAdShowFailed?.call(ad);
        break;
      case 'onAdRevenuePained':
        eyuAdListener?.onAdRevenuePained?.call(ad);
        break;
      default:
        debugPrint('invalid ad event name: $eventName');
    }
  }

}

class AdMessageCodec extends StandardMessageCodec {
  const AdMessageCodec();

  // The type values below must be consistent for each platform.
  static const int _valueAdRequest = 128;
  static const int _valueAdError = 129;

  @override
  dynamic readValueOfType(dynamic type, ReadBuffer buffer) {
    switch (type) {
      case _valueAdRequest:
        return EyuAd(
          readValueOfType(buffer.getUint8(), buffer),
          readValueOfType(buffer.getUint8(), buffer),
          readValueOfType(buffer.getUint8(), buffer),
          readValueOfType(buffer.getUint8(), buffer),
          readValueOfType(buffer.getUint8(), buffer),
          readValueOfType(buffer.getUint8(), buffer),
        );

      case _valueAdError:
        return AdError(
            readValueOfType(buffer.getUint8(), buffer),
            readValueOfType(buffer.getUint8(), buffer));

      default:
        return super.readValueOfType(type, buffer);
    }
  }

}
