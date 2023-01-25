import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:bidmad_plugin/FlutterBidmadCommon.dart';
import 'package:bidmad_plugin/FlutterBaseInterstitial.dart';

import 'package:flutter/foundation.dart' as foundation;

class InterstitialSample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BidmadInterstitialSample interstitial = BidmadInterstitialSample();
    return Scaffold(
      appBar: AppBar(
        title: Text("InterstitialSample"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                margin: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                child: TextField(
                  controller: interstitial.textView,
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
                      interstitial.loadInterstitialAD();
                    },
                    style:
                        ElevatedButton.styleFrom(minimumSize: Size(150, 35)))),
            Container(
                margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: ElevatedButton(
                    child: Text("Show AD"),
                    onPressed: () {
                      interstitial.showInterstitialAD();
                    },
                    style:
                        ElevatedButton.styleFrom(minimumSize: Size(150, 35)))),
          ],
        ),
      ),
    );
  }
}

class BidmadInterstitialSample {
  late FlutterBaseInterstitial interstitial;
  FlutterBidmadCommon common = FlutterBidmadCommon();
  TextEditingController textView = TextEditingController();

  BidmadInterstitialSample() {
    common.setDebugging(true);
    common.initInterstitialChannel().then((value) {
      print("initInterstitialChannel then : " + value);
      String _channelNm = value;
      interstitial = FlutterBaseInterstitial(channelName: _channelNm);

      // Bidmad Interstitial Ads can be set with Custom User ID with the following method.
      // interstitial.setCUID("YOUR ENCRYPTED CUID");

      if (foundation.defaultTargetPlatform == foundation.TargetPlatform.iOS) {
        interstitial.setAdInfo("228b95a9-6f42-46d8-a40d-60f17f751eb1");
      } else {
        interstitial.setAdInfo("e9acd7fc-a962-40e4-aaad-9feab1b4f821");
      }

      interstitial.setCallbackListener(onLoadAd: () {
        print("interstitial onLoadAd : ");
        textView.text = "onLoadAd";
      }, onShowAd: () {
        print("interstitial onShowAd : ");
        textView.text = "onShowAd";
        interstitial.load();
      }, onCloseAd: () {
        print("interstitial onCloseAd : ");
        textView.text = "onCloseAd";
      }, onFailAd: (String error) {
        print("interstitial onFailAd : " + error);
        textView.text = "onFailAd";
      });
    });
  }

  void loadInterstitialAD() {
    interstitial.load();
  }

  void showInterstitialAD() {
    interstitial.isLoaded().then((value) {
      if (value) {
        interstitial.show();
      }
    });
  }
}
