## Introduce
BidmadPlugin is a plugin for using Bidmad, a mobile app advertisement SDK, in Flutter.<br>
You can use the plugin to serve banner/interstitial/reward ads in your flutter mobile app.<br>

[Bidmad Flutter Plugin Pub.dev](https://pub.dev/packages/bidmad_plugin)

## Programming Guide

### 1. Android Setting

*If you are using a version lower than 1.0.0, please check [here](https://github.com/bidmad/Bidmad-Flutter/wiki/Flutter-Bidmad_Plugin-1.0.0-Migration-Guide%5BKOR%5D) first before proceeding to the guide below.

#### 1.1 gradle.properties Setting
Add the options below to gradle.properties
```java
...
android.enableDexingArtifactTransform=false
```

#### 1.2 Proguard Settings
If you are using Proguard, add the rule below.
```java
...
-keep class com.adop.sdk.** { *; }
-keep class ad.helper.openbidding.** { *; }
-keepnames class * implements java.io.Serializable
-keepclassmembers class * implements java.io.Serializable {
    static final long serialVersionUID;
    private static final java.io.ObjectStreamField[] serialPersistentFields;
    !static !transient <fields>;
    private void writeObject(java.io.ObjectOutputStream);
    private void readObject(java.io.ObjectInputStream);
    java.lang.Object writeReplace();
    java.lang.Object readResolve();
}

# Tapjoy
-keep class com.tapjoy.** { *; }
-keep class com.moat.** { *; }
-keepattributes JavascriptInterface
-keepattributes *Annotation*
-keep class * extends java.util.ListResourceBundle {
protected Object[][] getContents();
}
-keep public class com.google.android.gms.common.internal.safeparcel.SafeParcelable {
public static final *** NULL;
}
-keepnames @com.google.android.gms.common.annotation.KeepName class *
-keepclassmembernames class * {
@com.google.android.gms.common.annotation.KeepName *;
}
-keepnames class * implements android.os.Parcelable {
public static final ** CREATOR;
}
-keep class com.google.android.gms.ads.identifier.** { *; }
-dontwarn com.tapjoy.**
```

### 2. iOS Setting

#### 2.1 import BidmadSDK-iOS CocoaPods
After fetching our plugin into your app by "flutter pub get", a "Podfile" will be generated in your project's iOS Folder. <br>
1.  In Podfile, set the platform requirement to iOS 11.<br>
    ![Bidmad-Guide-Flutter-1](https://i.imgur.com/1uXp8jR.png)<br>
2.  Install our CocoaPods iOS Framework with command "pod install"<br>
    ![Bidmad-Guide-Flutter-2](https://i.imgur.com/BgmCdA3.png)<br>
3.  Now, open the Xcode Workspace file with the name "Runner.xcworkspace" and proceed to guide 2.2 below.
    ![Bidmad-Guide-Flutter-3](https://i.imgur.com/UClvij3.png)<br>

#### 2.2 Xcode Build Setting
Select "No" for Enable Bitcode under your Build Setting. 

#### 2.3 Setting SKAdNetwork
To use AdNetworks provided by BidmadSDK, you need to add SKAdNetworkIdentifier to Info.plist. Please add SKAdNetworkItems below to info.plist.
```java
<key>SKAdNetworkItems</key>
<array>
    <dict>
      <key>SKAdNetworkIdentifier</key>
      <string>cstr6suwn9.skadnetwork</string>
    </dict>
    <dict>
      <key>SKAdNetworkIdentifier</key>
      <string>v9wttpbfk9.skadnetwork</string>
    </dict>
    <dict>
      <key>SKAdNetworkIdentifier</key>
      <string>n38lu8286q.skadnetwork</string>
    </dict>
    <dict>
      <key>SKAdNetworkIdentifier</key>
      <string>4dzt52r2t5.skadnetwork</string>
    </dict>
    <dict>
      <key>SKAdNetworkIdentifier</key>
      <string>bvpn9ufa9b.skadnetwork</string>
    </dict>
    <dict>
      <key>SKAdNetworkIdentifier</key>
      <string>2u9pt9hc89.skadnetwork</string>
    </dict>
    <dict>
      <key>SKAdNetworkIdentifier</key>
      <string>4468km3ulz.skadnetwork</string>
    </dict>
    <dict>
      <key>SKAdNetworkIdentifier</key>
      <string>4fzdc2evr5.skadnetwork</string>
    </dict>
    <dict>
      <key>SKAdNetworkIdentifier</key>
      <string>7ug5zh24hu.skadnetwork</string>
    </dict>
    <dict>
      <key>SKAdNetworkIdentifier</key>
      <string>8s468mfl3y.skadnetwork</string>
    </dict>
    <dict>
      <key>SKAdNetworkIdentifier</key>
      <string>9rd848q2bz.skadnetwork</string>
    </dict>
    <dict>
      <key>SKAdNetworkIdentifier</key>
      <string>9t245vhmpl.skadnetwork</string>
    </dict>
    <dict>
      <key>SKAdNetworkIdentifier</key>
      <string>av6w8kgt66.skadnetwork</string>
    </dict>
    <dict>
      <key>SKAdNetworkIdentifier</key>
      <string>f38h382jlk.skadnetwork</string>
    </dict>
    <dict>
      <key>SKAdNetworkIdentifier</key>
      <string>hs6bdukanm.skadnetwork</string>
    </dict>
    <dict>
      <key>SKAdNetworkIdentifier</key>
      <string>kbd757ywx3.skadnetwork</string>
    </dict>
    <dict>
      <key>SKAdNetworkIdentifier</key>
      <string>ludvb6z3bs.skadnetwork</string>
    </dict>
    <dict>
      <key>SKAdNetworkIdentifier</key>
      <string>m8dbw4sv7c.skadnetwork</string>
    </dict>
    <dict>
      <key>SKAdNetworkIdentifier</key>
      <string>mlmmfzh3r3.skadnetwork</string>
    </dict>
    <dict>
      <key>SKAdNetworkIdentifier</key>
      <string>prcb7njmu6.skadnetwork</string>
    </dict>
    <dict>
      <key>SKAdNetworkIdentifier</key>
      <string>t38b2kh725.skadnetwork</string>
    </dict>
    <dict>
      <key>SKAdNetworkIdentifier</key>
      <string>tl55sbb4fm.skadnetwork</string>
    </dict>
    <dict>
      <key>SKAdNetworkIdentifier</key>
      <string>wzmmz9fp6w.skadnetwork</string>
    </dict>
    <dict>
      <key>SKAdNetworkIdentifier</key>
      <string>yclnxrl5pm.skadnetwork</string>
    </dict>
    <dict>
      <key>SKAdNetworkIdentifier</key>
      <string>ydx93a7ass.skadnetwork</string>
    </dict>
    <dict>
      <key>SKAdNetworkIdentifier</key>
      <string>238da6jt44.skadnetwork</string>
    </dict>
    <dict>
      <key>SKAdNetworkIdentifier</key>
      <string>22mmun2rn5.skadnetwork</string>
    </dict>
</array>
```

Also, please add NSUserTrackingUsageDescription with your own description of why you would like to track user data (e.g. "App would like to access IDFA for tracking purpose") into info.plist
```java
...
<key>NSUserTrackingUsageDescription</key>
<string>App would like to access IDFA for tracking purpose</string>
...
```

### 3. Using Plugin

#### 3.1 InitializeSDK
At the starting point of your app, please call initializeSdk().<br>
If initializeSdk method is not called, SDK initializes itself on your first loading, which subsequently may delay your first ad loading.
```
FlutterBidmadCommon().initializeSdk();
```

For interstitial and rewarded ads, instead of calling initializeSdk(), <br>
load your first ad at the starting point of your app by following the interstitial and rewarded ad loading guide below,<br>
and show your ad at the point of your choice.

#### 3.1 Banner AD
The following is an example of requesting a Banner ad.

##### 3.1.1 Banner placement based on position
```dart
....//Banner init
    FlutterBidmadCommon common = FlutterBidmadCommon();
    FlutterBaseBanner banner;

    common.initBannerChannel().then((value) {
      String _channelNm = value;

      banner = FlutterBaseBanner(
          channelName: _channelNm
      );

      banner.setAdInfo("Your Zone Id");

      banner.setCallbackListener(
          onLoadAd: (String zoneId){
            print("banner onLoadAd");
          },
          onFailAd: (String zoneId){
            print("banner onFailAd");
          }
      );

      //option 
      //banner.setInterval(120); //banner refresh time(60s~120s)
    });

....//Banner Load
    banner.load(300); //set Position Y(height)

....//Banner Remove
    banner.removeAdView();
```
##### 3.1.2 Banner Widget
```dart
....//Banner Widget init
    Container(
      child: BidmadBannerWidget(
        onBidmadBannerWidgetCreated: _onWidgetTestCreated,
      ),
      height: 50.0, //Banner Height(50, 100, 250)
    ),

....//onBidmadBannerWidgetCreated 
  void _onWidgetTestCreated(FlutterBaseBanner controller){
    controller.setAdInfo("Your Zone Id");

    controller.setCallbackListener(
        onLoadAd: (String zoneId){
          print("banner onLoadAd");
        },
        onFailAd: (String zoneId){
          print("banner onFailAd");
        }
    );

    controller.loadWidget();
  }
```

#### 3.2 Interstitial AD
The following is an example of requesting a Interstitial ad.
```dart
....//Interstitial init
    FlutterBidmadCommon common = FlutterBidmadCommon();
    FlutterBaseInterstitial interstitial;

    common.initInterstitialChannel().then((value) {
      String _channelNm = value;

      interstitial = FlutterBaseInterstitial(
          channelName: _channelNm
      );

      interstitial.setAdInfo("Your Zone Id");

      interstitial.setCallbackListener(
          onLoadAd: (String zoneId){
            print("interstitial onLoadAd");
          },
          onShowAd: (String zoneId){
            print("interstitial onShowAd" );
            interstitial.load(); //Ad Reload
          },
          onCloseAd: (String zoneId){
            print("interstitial onCloseAd");
          },
          onFailAd: (String zoneId){
            print("interstitial onFailAd");
          }
      );
    });

....//Interstitial Load
    interstitial.load();

....//Interstitial Show
    interstitial.isLoaded().then((value){
      if(value){
        interstitial.show();
      }
    });
```
#### 3.3 Reward AD
The following is an example of requesting a Reward ad.
```dart
....//Reward init
    FlutterBidmadCommon common = FlutterBidmadCommon();
    FlutterBaseReward reward;

    common.initRewardChannel().then((value) {
      String _channelNm = value;
      reward = FlutterBaseReward(
          channelName: _channelNm
      );

      reward.setAdInfo("Your Zone Id");

      reward.setCallbackListener(
          onLoadAd: (String zoneId){
            print("reward onLoadAd");
          },
          onShowAd: (String zoneId){
            print("reward onShowAd");

            reward.load();
          },
          onCompleteAd: (String zoneId){
            print("reward onCompleteAd");
          },
          onSkipAd: (String zoneId){
            print("reward onSkippedAd");
          },
          onCloseAd: (String zoneId){
            print("reward onCloseAd");
          },
          onClickAd: (String zoneId){
            print("reward onClickAd");
          },
          onFailAd: (String zoneId){
            print("reward onFailAd");
          }
      );
    });

....//Reward Load
    reward.load();

....//Reward Show
    reward.isLoaded().then((value){
      if(value){
        reward.show();
      }
    });
```

#### 3.4 ATT Functions
reqAdTrackingAuthorization() displays a popup, requesting for App Tracking Consent from user.<br>
And the function will return set of number string values, showing the result.
```java
FlutterBidmadCommon common = FlutterBidmadCommon();
    common.reqAdTrackingAuthorization().then(
      (value) {
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
            print("user is on lower version than iOS 14");
            break;
        }
      }
    );
```
For App Tracking Not Determined, the function will return 0,<br>
For App Tracking Restricted Authoriziation Status, the function will return 1, <br>
For App Tracking Denied Authorization Status, the function will return 2,<br>
For App Tracking Authorized Authorization Status the function will return 3,<br>
and Lastly, if the user is on lower version than iOS 14 then it will return 4.<br>

If you wish to obtain app tracking consent through a method other than what's provided by Plugin,<br>
If the user agrees, True, and if rejected, pass False to setAdvertiserTrackingEnabled.

```java
    common.setAdvertiserTrackingEnabled(false);
    print(common.getAdvertiserTrackingEnabled());
```

### 4. Plugin Interface
#### 4.1 FlutterBaseBanner

*Banner ads are handled through FlutterBaseBanner and this is a list of functions for that.

Function|Description
---|---
FlutterBaseBanner(@required String channelName)|This is the FlutterBaseBanner constructor, Receives the Name for Channel creation as a Param.
Future(void) load(int y)|Request a banner ad. When a banner ad is exposed, the banner is exposed at height y (center alignment).
Future(void) loadWidget()|Request a banner ad. In order for the function to function properly, FlutterBaseBanner object must be obtained through the BidmadBannerWidget Class.
Future(void) setInterval(int sec)|Set the banner refresh cycle.(60s~120s)
Future(void) setAdInfo(String zoneId)|Set the issued ZoneId.
Future(void) setCUID(String cuid)|Set the CUID property of each ad type. recommend encrypting text using sha256 or higher.
Future(void) hideBanner()|Hide the banner View
Future(void) showBanner()|Show the banner View.
Future(void) removeBanner()|Remove the exposed banner.
void Function(String zoneId) onLoadAd|If a listener is registered, the registered function is called when ad load.
void Function(String zoneId) onFailAd|If a listener is registered, the registered function is called when ad load fail.

#### 4.2 BidmadBannerWidget
*For banner ads in the form of a widget, it must be processed through BidmadBannerWidget, and this is a list of functions for that.

Function|Description
---|---
BidmadBannerWidget(BidmadBannerWidgetCreatedCallback onBidmadBannerWidgetCreated)|This is the BidmadBannerWidget constructor. After creating the widget, it receives a callback for processing.
onBidmadBannerWidgetCreated(FlutterBaseBanner controller)|It is a callback that can receive a FlutterBaseBanner and handle banner related processing.

#### 4.3 FlutterBaseInterstitial

*Interstitial ads are handled through FlutterBaseInterstitial and this is a list of functions for that.

Function|Description
---|---
FlutterBaseInterstitial(@required String channelName)|This is the FlutterBaseInterstitial constructor, Receives the Name for Channel creation as a Param.
Future(void) load()|Request a interstitial ad
Future(void) show()|Display the loaded interstitial ad
Future(bool) isLoaded()|Check if the ad is loaded.
Future(void) setAdInfo(String zoneId)|Set the issued ZoneId.
Future(void) setCUID(String cuid)|Set the CUID property of each ad type. recommend encrypting text using sha256 or higher.
void Function(String zoneId) onLoadAd|If a listener is registered, the registered function is called when ad load.
void Function(String zoneId) onShowAd|If a listener is registered, the registered function is called when ad show.
void Function(String zoneId) onFailAd|If a listener is registered, the registered function is called when ad load fail.
void Function(String zoneId) onCloseAd|If a listener is registered, the registered function is called when ad close.

#### 4.4 FlutterBaseReward

*Reward ads are handled through FlutterBaseReward and this is a list of functions for that.

Function|Description
---|---
FlutterBaseReward(@required String channelName)|This is the FlutterBaseReward constructor, Receives the Name for Channel creation as a Param.
Future(void) load()|Request a reward ad.
Future(void) show()|Display the loaded reward ad.
Future(bool) isLoaded()|Check if the ad is loaded.
Future(void) setAdInfo(String zoneId)|Set the issued ZoneId.
Future(void) setCUID(String cuid)|Set the CUID property of each ad type. recommend encrypting text using sha256 or higher.
void Function(String zoneId) onLoadAd|If a listener is registered, the registered function is called when ad load.
void Function(String zoneId) onShowAd|If a listener is registered, the registered function is called when ad show.
void Function(String zoneId) onFailAd|If a listener is registered, the registered function is called when ad load fail.
void Function(String zoneId) onCompleteAd|If a listener is registered, the registered function is called when ad complate.
void Function(String zoneId) onCloseAd|If a listener is registered, the registered function is called when ad close.
void Function(String zoneId) onClickAd|If a listener is registered, the registered function is called when ad click.
void Function(String zoneId) onSkipAd|If a listener is registered, the registered function is called when ad skip.

#### 4.5 FlutterBidmadCommon
*This is a list of functions available through BidmadCommon.

Function|Description
---|---
FlutterBidmadCommon()|This is the FlutterBidmadCommon constructor
Future(void) setDebugging(bool isDebug)|Debugging log output
Future(void) initializeSdk()|Initialize BidmadSDK's supported ad networks
Future(String) initBannerChannel()|Creating a channel for controlling banner ad
Future(String) initInterstitialChannel()|Creating a channel for controlling interstitial ad
Future(String) initRewardChannel()|Creating a channel for controlling reward ad
Future(String) reqAdTrackingAuthorization()|Requesting for App Tracking Consent from user
Future(void) setAdvertiserTrackingEnabled(bool enable)|Setting ATT Setting manually
Future(bool) getAdvertiserTrackingEnabled()|Getting ATT Setting, true if consent and false if not consent
