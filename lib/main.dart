import 'package:bidmad_flutter_sample/BannerRefinedWidgetSample.dart';
import 'package:bidmad_flutter_sample/NativeAdWidgetSample.dart';
import 'package:flutter/material.dart';
import 'package:bidmad_flutter_sample/BannerSample.dart';
import 'package:bidmad_flutter_sample/BannerWidgetSample.dart';
import 'package:bidmad_flutter_sample/InterstitialSample.dart';
import 'package:bidmad_flutter_sample/RewardSample.dart';
import 'package:bidmad_plugin/FlutterBidmadCommon.dart';
import 'package:flutter/foundation.dart' as foundation;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    // Please call initializeSdk method before calling Bidmad Ads.
    FlutterBidmadCommon common = FlutterBidmadCommon();

    /**
     * For v1.6.0 or above, you can receive a callback, indicating whether the initialization is successfully or unsuccessfully done.
     *
     * common.setInitializeCallbackListener(
        onInitialized : (isCompleted) {
        print("Initialize callback : "+isCompleted.toString());
        }
        );
        common.initializeSdkWithCallback("Your App Key");
     *
     * */

    if (foundation.defaultTargetPlatform == foundation.TargetPlatform.android) {

      common.setInitializeCallbackListener(
          onInitialized : (isCompleted) {
            print("Initialize callback : "+isCompleted.toString());
          }
      );
      common.initializeSdkWithCallback("6933aab2-7f78-11ed-a117-026864a21938");
      // common.initializeSdk("6933aab2-7f78-11ed-a117-026864a21938");

    } else if (foundation.defaultTargetPlatform ==
      foundation.TargetPlatform.iOS) {
      common.initializeSdk("ff8090d3-3e28-11ed-a117-026864a21938");
    }

    common.reqAdTrackingAuthorization().then((value) {
      switch (value) {
        case "0":
          print("App Tracking Not Determined");
          break;
        case "1":
          print("App Tracking Restricted Authoriziation Status");
          break;
        case "2":
          print("App Tracking Denied Authorization Status");
          break;
        case "3":
          print("App Tracking Authorized Authorization Status");
          break;
        case "4":
          print("Lower Version than iOS 14");
          break;
      }
    });

    common.setAdvertiserTrackingEnabled(false);
    print(common.getAdvertiserTrackingEnabled());

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Spacer(),
            Container(
              child: ElevatedButton(
                  child: Text("Banner Sample"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BannerSample()),
                    );
                  },
                  style: ElevatedButton.styleFrom(minimumSize: Size(150, 35))),
            ),
            Spacer(),
            Container(
              child: ElevatedButton(
                  child: Text("Banner Widget Sample"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BannerWidgetSample()),
                    );
                  },
                  style: ElevatedButton.styleFrom(minimumSize: Size(150, 35))),
            ),
            Spacer(),
            Container(
              child: ElevatedButton(
                  child: Text("Banner Refined Widget Sample"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BannerRefinedWidgetSample()),
                    );
                  },
                  style: ElevatedButton.styleFrom(minimumSize: Size(150, 35))),
            ),
            Spacer(),
            Container(
              child: ElevatedButton(
                  child: Text("Interstitial Sample"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => InterstitialSample()),
                    );
                  },
                  style: ElevatedButton.styleFrom(minimumSize: Size(150, 35))),
            ),
            Spacer(),
            Container(
              child: ElevatedButton(
                  child: Text("Reward Sample"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RewardSample()),
                    );
                  },
                  style: ElevatedButton.styleFrom(minimumSize: Size(150, 35))),
            ),
            Spacer(),
            Container(
              child: ElevatedButton(
                  child: Text("NativeAd Sample"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NativeAdWidgetSample()),
                    );
                  },
                  style: ElevatedButton.styleFrom(minimumSize: Size(150, 35))),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
