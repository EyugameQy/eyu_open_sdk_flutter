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

import 'dart:developer';
import 'dart:math';

import 'package:eyu_open_sdk_flutter/eyu_open_sdk_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'ad_manager.dart';

class AdError {
  @protected
  AdError(this.code, this.message);

  final int code;
  final String message;

  @override
  String toString() {
    return '$runtimeType(code: $code, message: $message)';
  }
}

class EyuAd {
  String unitId;
  String placeId;
  String adFormat;
  double adRevenue;
  String mediator;
  String networkName;

  EyuAd(this.unitId, this.placeId, this.adFormat, this.adRevenue, this.mediator,
      this.networkName);
}

class BannerAdWidget extends StatefulWidget {
  final String placeId;

  BannerAdWidget({required this.placeId});

  @override
  State<StatefulWidget> createState() {
    return _BannerWidgetState();
  }
}

class _BannerWidgetState extends State<BannerAdWidget> {
  double _height = 0;

  @override
  void initState() {
    super.initState();
    EyuSdk.isAdLoaded(widget.placeId)
        .then((value) => {updateHeight(value ?? false)});
  }

  void updateHeight(bool loaded) {
    setState(() {
      _height = loaded ? 50 : 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_height == 0) {
      return Container(width: 0, height: 0);
    }
    return Container(
        width: MediaQuery
            .of(context)
            .size
            .width
            .truncate()
            .toDouble(),
        height: _height,
        child: AdWidget(placeId: widget.placeId));
  }
}

class NativeAdWidget extends StatefulWidget {
  final String placeId;
  final double width;
  final double height;

  NativeAdWidget({
    required this.placeId,
    required this.height,
    this.width = -1
  });

  @override
  State<StatefulWidget> createState() {
    return _NativeWidgetState();
  }
}

class _NativeWidgetState extends State<NativeAdWidget> {
  double _height = 0;
  double _width = 0;

  @override
  void initState() {
    super.initState();
    EyuSdk.isAdLoaded(widget.placeId)
        .then((value) => {updateHeight(value ?? false)});
  }

  void updateHeight(bool loaded) {
    setState(() {
      _height = loaded ? widget.height : 0;
      _width = loaded ? (widget.width < 0 ? MediaQuery.of(context).size.width.truncate().toDouble():0) : 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_height == 0) {
      return Container(width: 0, height: 0);
    }
    return Container(
        width: _width,
        height: _height,
        child: AdWidget(placeId: widget.placeId));
  }
}

class AdWidget extends StatelessWidget {
  const AdWidget({Key? key, required this.placeId}) : super(key: key);

  final String placeId;

  @override
  Widget build(BuildContext context) {
    print("${placeId}----${adManager.channel.name}/ad_widget");
    if (defaultTargetPlatform == TargetPlatform.android) {
      return PlatformViewLink(
        viewType: '${adManager.channel.name}/ad_widget',
        surfaceFactory:
            (BuildContext context, PlatformViewController controller) {
          return AndroidViewSurface(
            controller: controller as AndroidViewController,
            gestureRecognizers: const <Factory<OneSequenceGestureRecognizer>>{},
            hitTestBehavior: PlatformViewHitTestBehavior.opaque,
          );
        },
        onCreatePlatformView: (PlatformViewCreationParams params) {
          return PlatformViewsService.initSurfaceAndroidView(
            id: params.id,
            viewType: '${adManager.channel.name}/ad_widget',
            layoutDirection: TextDirection.ltr,
            creationParams: placeId,
            creationParamsCodec: StandardMessageCodec(),
          )
            ..addOnPlatformViewCreatedListener(params.onPlatformViewCreated)
            ..create();
        },
      );
    }

    return UiKitView(
      viewType: '${adManager.channel.name}/ad_widget',
      creationParams: placeId,
      creationParamsCodec: StandardMessageCodec(),
    );
  }
}
