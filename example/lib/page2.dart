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
            child: ListView.builder(
                itemCount: 20,
                itemBuilder: (context, index) {
                  if (index % 4 == 0) {
                    return NativeAdWidget(
                      placeId: "main_view_native_ad",
                      height: 200,
                      page: 'page 2',
                      identifier: "index_$index",
                    );
                  }  else {
                    return Container(
                      height: 200,
                      child: Text("fsafdsfadsfafassddsfasafsdsd"),
                    );
                  }
                })),
      ),
    );
  }

  @override
  void dispose() {
    EyuSdk.dispose("page 2");
    super.dispose();
  }
}
