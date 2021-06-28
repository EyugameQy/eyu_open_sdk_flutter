import 'dart:async';

import 'package:eyu_open_sdk_flutter/eyu_open_sdk_flutter.dart';
import 'package:eyu_open_sdk_flutter_example/page2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: Home()
      ),
    );
  }
}


class Home extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {
  String _loaded = 'Unknown';
  EyuAd? _ad;

  @override
  void initState() {
    super.initState();
    EyuSdk.init();
    EyuSdk.setListener(EyuAdListener(
        onAdLoaded: (EyuAd ad) {
          setState(() {
            _ad = ad;
            _loaded = ad.mediator;
          });
        },
        onAdLoadFailed: (EyuAd ad, AdError error) {},
        onAdClosed: (EyuAd ad) {},
        onAdShowed: (EyuAd ad) {},
        onAdShowFailed: (EyuAd ad) {},
        onAdReward: (EyuAd ad) {},
        onAdImpression: (EyuAd ad) {},
        onAdClicked: (EyuAd ad) {},
        onAdRevenuePained: (EyuAd ad) {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('page 1'),
        ),
        body: Center(
          child: Column(
            children: [
              Text('Running on: ${_ad?.adFormat}\n'),
              Text('Running on: $_loaded\n'),
              MaterialButton(
                onPressed: () {
                  EyuSdk.show("reward_ad");
                },
                child: Text("激励视频"),
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (BuildContext context) {
                        return MyApp2();
                      }
                  ));
                },
                child: Text("next"),
              )
              ,
            ]
            ,
          )
          ,
        )
    );
  }

}
