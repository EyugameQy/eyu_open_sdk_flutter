import 'package:eyu_open_sdk_flutter/eyu_open_sdk_flutter.dart';
import 'package:flutter/material.dart';

class MyApp2 extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp2> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('page 2'),
        ),
        body: Center(
          child: Column(
            children: [
              BannerAdWidget(placeId: "page_view_banner_ad"),
//              NativeAdWidget(placeId: "main_view_native_ad",height: 200)
            ],
          ),
        ),
      ),
    );
  }
}
