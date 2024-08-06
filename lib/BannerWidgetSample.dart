import 'package:bidmad_plugin/BidmadInfo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:bidmad_plugin/FlutterBaseBanner.dart';
import 'package:bidmad_plugin/BidmadBannerWidget.dart';

import 'package:flutter/foundation.dart' as foundation;

class BannerWidgetSample extends StatelessWidget {
  late FlutterBaseBanner banner;
  TextEditingController textView = TextEditingController();
  bool trigger = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BannerSample"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: BidmadBannerWidget(
                onBidmadBannerWidgetCreated: _onBidmadBannerWidgetCreated,
              ),
              height: 50,
            ),
            Container(
                margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: TextField(
                  controller: textView,
                  textAlign: TextAlign.center,
                  enabled: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Callback Print',
                  ),
                )),
            Container(
                margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: ElevatedButton(
                    child: Text("Remove AD"),
                    onPressed: () {
                      removeBanner();
                    },
                    style:
                        ElevatedButton.styleFrom(minimumSize: Size(150, 35)))),
            Container(
                margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: ElevatedButton(
                    child: Text("Hide&Show AD"),
                    onPressed: () {
                      hideAndShowBanner();
                    },
                    style:
                        ElevatedButton.styleFrom(minimumSize: Size(150, 35)))),
          ],
        ),
      ),
    );
  }

  void _onBidmadBannerWidgetCreated(FlutterBaseBanner controller) {
    banner = controller;

    // Bidmad Banner Ads can be set with Custom User ID with the following method.
    // banner.setCUID("YOUR ENCRYPTED CUID");

    if (foundation.defaultTargetPlatform == foundation.TargetPlatform.iOS) {
      controller.setAdInfo("1c3e3085-333f-45af-8427-2810c26a72fc");
    } else {
      controller.setAdInfo("944fe870-fa3a-4d1b-9cc2-38e50b2aed43");
    }

    controller.setCallbackListener(
      onLoadAd: (BidmadInfo? info) {
        print("banner onLoadAd");
        textView.text = "onLoadAd";
      }, onFailAd: (String error) {
        print("banner onFailAd");
        textView.text = "onFailAd";
      }
    );

    controller.loadWidget();
  }

  void hideAndShowBanner() {
    print("hideAndShowBanner : " + trigger.toString());
    if (trigger) {
      banner.showBanner();
      trigger = false;
    } else {
      banner.hideBanner();
      trigger = true;
    }
  }

  void removeBanner() {
    banner.removeBanner();
  }
}
