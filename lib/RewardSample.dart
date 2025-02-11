import 'package:bidmad_plugin/BidmadInfo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:bidmad_plugin/FlutterBidmadCommon.dart';
import 'package:bidmad_plugin/FlutterBaseReward.dart';

import 'package:flutter/foundation.dart' as foundation;

class RewardSample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BidmadRewardSample reward = BidmadRewardSample();
    return Scaffold(
      appBar: AppBar(
        title: Text("RewardSample"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                margin: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                child: TextField(
                  controller: reward.textView,
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
                      reward.loadRewardAD();
                    },
                    style:
                        ElevatedButton.styleFrom(minimumSize: Size(150, 35)))),
            Container(
                margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: ElevatedButton(
                    child: Text("Show AD"),
                    onPressed: () {
                      reward.showRewardAD();
                    },
                    style:
                        ElevatedButton.styleFrom(minimumSize: Size(150, 35)))),
          ],
        ),
      ),
    );
  }
}

class BidmadRewardSample {
  late FlutterBaseReward reward;
  FlutterBidmadCommon common = FlutterBidmadCommon();
  TextEditingController textView = TextEditingController();

  BidmadRewardSample() {
    common.setDebugging(true);
    common.initRewardChannel().then((value) {
      print("initRewardChannel then : " + value);
      String _channelNm = value;
      reward = FlutterBaseReward(channelName: _channelNm);

      if (foundation.defaultTargetPlatform == foundation.TargetPlatform.iOS) {
        reward.setAdInfo("29e1ef67-98d2-47b3-9fa2-9192327dd75d");
      } else {
        reward.setAdInfo("7d9a2c9e-5755-4022-85f1-6d4fc79e4418");
      }

      // Bidmad Reward Ads can be set with Custom User ID with the following method.
      // reward.setCUID("YOUR ENCRYPTED CUID");

      reward.setCallbackListener(
        onLoadAd: (BidmadInfo? info) {
          print("reward onLoadAd : ");
          textView.text = "onLoadAd";
        }, onShowAd: (BidmadInfo? info) {
          print("reward onShowAd : ");
          textView.text = "onShowAd";

          reward.load();
        }, onCompleteAd: (BidmadInfo? info) {
          print("reward onCompleteAd : ");
          textView.text = "onCompleteAd";
        }, onSkipAd: (BidmadInfo? info) {
          print("reward onSkipAd : ");
          textView.text = "onSkipAd";
        }, onCloseAd: (BidmadInfo? info) {
          print("reward onCloseAd : ");
          textView.text = "onCloseAd";
        }, onClickAd: (BidmadInfo? info) {
          print("reward onClickAd : ");
          textView.text = "onClickAd";
        }, onFailAd: (String error) {
          print("reward onFailAd : " + error);
          textView.text = "onFailAd";
        }
      );
    });
  }

  void loadRewardAD() {
    reward.load();
  }

  void showRewardAD() {
    reward.isLoaded().then((value) {
      if (value) {
        reward.show();
      }
    });
  }
}
