import 'package:bidmad_plugin/FlutterBaseBannerRefined.dart';
import 'package:bidmad_plugin/BidmadBannerRefinedWidget.dart';
import 'package:bidmad_plugin/FlutterBidmadCommon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' as foundation;

class BannerRefinedWidgetSample extends StatefulWidget {
  @override
  _BannerRefinedWidgetState createState() => _BannerRefinedWidgetState();
}
class _BannerRefinedWidgetState extends State<BannerRefinedWidgetSample> {
  late FlutterBaseBannerRefined bannerAd;
  FlutterBidmadCommon common = FlutterBidmadCommon();
  bool isLoaded = false;

  TextEditingController textView = TextEditingController();
  bool trigger = false;

  @override
  void initState() {
    loadBannerAd();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BannerRefinedWidgetSample"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child:  isLoaded ? BidmadBannerRefinedWidget(
                ad: bannerAd,
              ) : Text("isLoading..."),
              width: double.infinity,
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
                    style: ElevatedButton.styleFrom(minimumSize: Size(150, 35)))),
            Container(
                margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: ElevatedButton(
                    child: Text("Hide&Show AD"),
                    onPressed: () {
                      hideAndShowBanner();
                      },
                    style: ElevatedButton.styleFrom(minimumSize: Size(150, 35)))),
          ],
        ),
      ),
    );
  }

  void loadBannerAd(){
    common.initBannerRefinedChannel().then((chanNm) {
      if (foundation.defaultTargetPlatform == foundation.TargetPlatform.iOS) {
        bannerAd = FlutterBaseBannerRefined(
            channelNm: chanNm,
            zoneId: "1c3e3085-333f-45af-8427-2810c26a72fc");
      } else {
        bannerAd = FlutterBaseBannerRefined(
            channelNm: chanNm,
            zoneId: "944fe870-fa3a-4d1b-9cc2-38e50b2aed43");
      }
      bannerAd.setCallbackListener(
          onLoadAd: () {
            print("bannerAdWidget onLoad");
            textView.text = "onLoadAd";
            isLoaded = true;
            setState(() {
            });
          },
          onFailAd: (error) {
            print("bannerAdWidget onFailAd : "+error);
            textView.text = "onFailAd";
          });
      bannerAd.load();
    });
  }
  void hideAndShowBanner() {
    print("hideAndShowBanner : " + trigger.toString());
    if (trigger) {
      bannerAd.showBanner();
      trigger = false;
    } else {
      bannerAd.hideBanner();
      trigger = true;
    }
  }
  void removeBanner() {
    bannerAd.removeBanner();
  }
}