import 'package:bidmad_plugin_for_myb/BidmadInfo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:bidmad_plugin_for_myb/FlutterBidmadCommon.dart';
import 'package:bidmad_plugin_for_myb/FlutterBaseBanner.dart';

import 'package:flutter/foundation.dart' as foundation;

class BannerSample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BidmadBannerSample banner = BidmadBannerSample();
    return Scaffold(
      appBar: AppBar(
        title: Text("BannerSample"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                margin: const EdgeInsets.fromLTRB(0, 250, 0, 0),
                child: TextField(
                  controller: banner.textView,
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
                    child: Text("Load AD"),
                    onPressed: () {
                      banner.loadBannerAD();
                    },
                    style:
                        ElevatedButton.styleFrom(minimumSize: Size(150, 35)))),
            Container(
                margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: ElevatedButton(
                    child: Text("Remove AD"),
                    onPressed: () {
                      banner.removeBanner();
                    },
                    style:
                        ElevatedButton.styleFrom(minimumSize: Size(150, 35)))),
            Container(
                margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: ElevatedButton(
                    child: Text("Hide&Show AD"),
                    onPressed: () {
                      banner.hideAndShowBanner();
                    },
                    style:
                        ElevatedButton.styleFrom(minimumSize: Size(150, 35)))),
          ],
        ),
      ),
    );
  }
}

class BidmadBannerSample {
  late FlutterBaseBanner banner;
  FlutterBidmadCommon common = FlutterBidmadCommon();
  TextEditingController textView = TextEditingController();

  bool trigger = false;

  BidmadBannerSample() {
    common.setDebugging(true);
    common.initBannerChannel().then((value) {
      print("initBannerChannel then : " + value);
      String _channelNm = value;
      banner = FlutterBaseBanner(channelName: _channelNm);

      if (foundation.defaultTargetPlatform == foundation.TargetPlatform.iOS) {
        banner.setAdInfo("1c3e3085-333f-45af-8427-2810c26a72fc");
      } else {
        banner.setAdInfo("944fe870-fa3a-4d1b-9cc2-38e50b2aed43");
      }

      banner.setCallbackListener(
        onLoadAd: (BidmadInfo? info) {
          print("banner onLoadAd : ");
          textView.text = "onLoadAd";
        }, onFailAd: (String error) {
          print("banner onFailAd : " + error);
          textView.text = "onFailAd";
        }
      );

      banner.setInterval(60);

      // Ads can be set with Custom User ID with the following method.
      // common.setCUID("YOUR ENCRYPTED CUID");
    });
  }

  void loadBannerAD() {
    banner.load(350);
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
