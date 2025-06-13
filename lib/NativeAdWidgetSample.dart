import 'package:bidmad_plugin_for_myb/BidmadFlutterPlugin.dart';
import 'package:bidmad_plugin_for_myb/BidmadInfo.dart';
import 'package:flutter/material.dart';
import 'package:bidmad_plugin_for_myb/BidmadNativeAdWidget.dart';

import 'package:flutter/foundation.dart' as foundation;

class NativeAdWidgetSample extends StatelessWidget {
  late FlutterBaseNativeAd nativeAd;
  TextEditingController textView = TextEditingController();
  bool trigger = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Native Ad Sample"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: BidmadNativeAdWidget(
                layoutName: "nativead",
                onBidmadNativeAdWidgetCreated: _onBidmadNativeAdWidgetCreated,
                width: 400,
                height: 400
              ),
            ),
            Container(
              child: TextField(
                controller: textView,
                textAlign: TextAlign.center,
                enabled: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Callback Print',
                ),
              ),
            ),
            Container(
              child: ElevatedButton(
                child: Text("Remove AD"),
                onPressed: removeNativeAd,
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(150, 35),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onBidmadNativeAdWidgetCreated(FlutterBaseNativeAd controller) {
    nativeAd = controller;

    if (foundation.defaultTargetPlatform == foundation.TargetPlatform.iOS) {
      controller.setAdInfo("7fe8f6de-cd99-4769-9ae6-a471cfd7e2b1");
    } else {
      controller.setAdInfo("2d04afb5-99e9-4739-9970-2303da2be24c");
    }

    controller.setCallbackListener(
      onLoadAd: (BidmadInfo? info) {
        print("nativeAd onLoadAd");
        textView.text = "onLoadAd";
      },
      onClickAd : (BidmadInfo? info){
        print("nativeAd onClickAd");
        textView.text = "onClickAd";
      },
      onFailAd: (String error) {
        print("nativeAd onFailAd");
        textView.text = "onFailAd";
      }
    );

    controller.loadWidget();
  }

  void removeNativeAd() {
    nativeAd.removeWidget();
  }
}
