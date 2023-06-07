## Introduce
BidmadPlugin is a plugin for using Bidmad, a mobile app advertisement SDK, in Flutter.<br>
You can use the plugin to serve banner/interstitial/reward ads in your flutter mobile app.<br>

[Bidmad Flutter Plugin Pub.dev](https://pub.dev/packages/bidmad_plugin)

## Programming Guide

### 1. Android Setting

*If you are using a version lower than 1.0.0, please check [here](https://github.com/bidmad/Bidmad-Flutter/wiki/Flutter-Bidmad_Plugin-1.0.0-Migration-Guide%5BENG%5D) first before proceeding to the guide below.

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
        -keep class com.adop.adapter.fc.** { *; }
        -keep class com.adop.adapter.fnc.** { *; }
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
        -keepclassmembers class * {
@android.webkit.JavascriptInterface <methods>;
}

        #prebid
        -keep class com.adop.prebid.** {*;}

        # Pangle
        -keep class com.bytedance.sdk.** { *; }
        -keep class com.bykv.vk.openvk.component.video.api.** { *; }

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

#### 1.3 Admob Application ID Settings
Declare the code below under the application tag in AndroidManifest.xml inside the Android app module.([Guide](https://github.com/bidmad/SDK/wiki/Find-your-app-key%5BEN%5D#app-id-from-admob-dashboard))<br>
*Check the value of com.google.android.gms.ads.APPLICATION_ID in the Admob dashboard.

```xml
<application>
   ...
   <meta-data android:name="com.google.android.gms.ads.APPLICATION_ID" android:value="APPLICATION_ID"/>
   ...
</application>
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

<details markdown="1">
<summary>SKAdNetworkItems List</summary>
<br>

```
<key>SKAdNetworkItems</key>
<array>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>4pfyvq9l8r.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>yclnxrl5pm.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>v72qych5uu.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>tl55sbb4fm.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>t38b2kh725.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>prcb7njmu6.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>ppxm28t8ap.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>mlmmfzh3r3.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>klf5c3l5u5.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>hs6bdukanm.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>c6k4g5qg8m.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>9t245vhmpl.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>9rd848q2bz.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>8s468mfl3y.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>7ug5zh24hu.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>4fzdc2evr5.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>4468km3ulz.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>3rd42ekr43.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>2u9pt9hc89.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>m8dbw4sv7c.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>7rz58n8ntl.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>ejvt5qm6ak.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>5lm9lj6jb7.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>44jx6755aq.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>mtkv5xtk9e.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>6g9af3uyq4.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>uw77j35x4d.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>u679fj5vs4.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>rx5hdcabgc.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>g28c52eehv.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>cg4yq2srnc.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>9nlqeag3gk.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>275upjj5gd.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>a7xqa6mtl2.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>r45fhb6rf7.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>2fnua5tdw4.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>ydx93a7ass.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>84993kbrcf.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>44n7hlldy6.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>cj5566h2ga.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>kbd757ywx3.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>e5fvkxwrpn.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>kbmxgpxpgc.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>n9x2a789qt.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>g2y4y55b64.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>6964rsfnh4.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>5l3tpt7t6e.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>pwdxu55a5a.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>n6fk4nfna4.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>294l99pt4k.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>qqp299437r.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>wzmmz9fp6w.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>pwa73g5rt2.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>74b6s63p6l.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>523jb4fst2.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>gta9lk7p23.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>wg4vff78zm.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>cstr6suwn9.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>5a6flpkh64.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>p78axxw29g.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>s39g8k73mm.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>3qy4746246.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>3sh42y64q3.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>f38h382jlk.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>av6w8kgt66.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>424m5254lk.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>zq492l623r.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>v4nxqhlyqp.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>578prtvx9j.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>4dzt52r2t5.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>8c4e2ghe7u.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>3qcr597p9d.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>ludvb6z3bs.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>k674qkevps.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>ggvn48r87g.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>32z4fx6l9h.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>9b89h5y424.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>24t9a8vw3c.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>feyaarzu9v.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>xy9t38ct57.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>6xzpu9s2p8.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>54nzkqm89y.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>79pbpufp6p.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>glqzh8vgby.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>zmvfpc5aq8.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>c3frkrj4fj.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>rvh3l7un93.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>x8jxxk4ff5.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>nzq8sh4pbs.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>dkc879ngq3.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>x44k69ngh6.skadnetwork</string>
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
        <string>f73kdq92p3.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>w9q455wk68.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>bvpn9ufa9b.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>b9bk5wbcq9.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>97r2b46745.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>mls7yz5dvl.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>su67r6k2v3.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>krvm3zuq6h.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>a2p9lx4jpn.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>bmxgpxpgc.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>x8uqf25wch.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>252b5q8x7y.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>9g2aggbj52.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>wzmmZ9fp6w.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>hdw39hrw9y.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>y45688jllp.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>dzg6xy7pwj.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>22mmun2rn5.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>5tjdwbrq8w.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>4w7y6s5ca2.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>737z793b9f.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>r26jy69rpl.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>238da6jt44.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>ecpz2srf59.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>z4gj7hsk7h.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>52fl2v3hgk.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>yrqqpx2mcb.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>gvmwg8q7h5.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>lr83yxwka7.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>pu4na253f3.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>n66cz3y3bx.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>v79kvwwj4g.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>9yg77x724h.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>488r3q3dtq.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>f7s53z58qe.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>mp6xlyr22a.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>7953jerfzd.skadnetwork</string>
    </dict>
</array>
```

</details>

Also, please add NSUserTrackingUsageDescription with your own description of why you would like to track user data (e.g. "App would like to access IDFA for tracking purpose") into info.plist
```java
...
<key>NSUserTrackingUsageDescription</key>
<string>App would like to access IDFA for tracking purpose</string>
...
```

### 3. Using Plugin

#### 3.1 Initializing BidmadSDK
Performs tasks required to run BidmadSDK. The SDK won't allow ads to load unless you call the initializeSdk method.<br>
The initializeSdk method receives the App Key that can be checked in ADOP Insight as a parameter. You can import the App Key by referring to the [Find Your App Key](https://github.com/bidmad/SDK/wiki/Find-your-app-key%5BEN%5D) guide.<br>
Before loading ads, call the initializeSdk method as shown in the following example at the beginning of app execution.

```
if (foundation.defaultTargetPlatform == foundation.TargetPlatform.android) {
    FlutterBidmadCommon().initializeSdk("ANDROID APP KEY");
} else if (foundation.defaultTargetPlatform == foundation.TargetPlatform.iOS) {
    FlutterBidmadCommon().initializeSdk("IOS APP KEY");
}
```

Also, for v1.6.0 or above, you can receive a callback, indicating whether the initialization is successfully or unsuccessfully done.

```
FlutterBidmadCommon common = FlutterBidmadCommon();

if (foundation.defaultTargetPlatform == foundation.TargetPlatform.android) {
  common.setInitializeCallbackListener(onInitialized: (bool isInitialized) {
    print("Android Initialization Done: $isInitialized");
  });
  common.initializeSdkWithCallback("ANDROID APP KEY");
} else if (foundation.defaultTargetPlatform == foundation.TargetPlatform.iOS) {
  common.setInitializeCallbackListener(onInitialized: (bool isInitialized) {
    print("IOS Initialization Done: $isInitialized");
  });
  common.initializeSdkWithCallback("IOS APP KEY");
}
```

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
##### 3.1.3 Load the ad first and show the banner widget later (Supported only in v1.6.0 or later versions)
```dart
....//Load the banner ad first
  FlutterBidmadCommon common = FlutterBidmadCommon();
  FlutterBaseBannerRefined bannerAd;
  
  common.initBannerRefinedChannel().then((chanNm) {
    bannerAd = FlutterBaseBannerRefined(
      channelNm: chanNm,
      zoneId: "Your Zone Id");
    bannerAd.setCallbackListener(onLoadAd: () {
      print("bannerAdWidget onLoad");
    }, onFailAd: (error) {
      print("bannerAdWidget onFailAd : " + error);
    });
    bannerAd.load();
  });

....//Show the banner ad widget later by adding the Bidmad
  Container(
    child: BidmadBannerRefinedWidget(ad: bannerAd,),
    height: 50, // banner can have the height of 50, 100, 250
  ),
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

#### 3.4 NativeAd Widget
Native ads are ad formats that are displayed to users through app-specific UI components.
Since the UI design unique to the internal app is required to display native ads, additional settings for Android and iOS are required to use this function.

<details markdown="1">
<summary>Android Settings</summary>
<br>

1. Create an XML file by referring to [XML Layout Setting Guide](https://github.com/adop-devel/Bidmad-Flutter/wiki/Andorid-NativeAd-Layout-Example) for Android.
2. Create a layout folder under the resource file and put the XML file in it.<br>
   ![Android-NativeAd-1](https://i.imgur.com/q8nhvPf.png) <br>
3. Copy the name without the extension of the XML file you created and pass it to the BidmadNativeAdWidget constructor layoutName as shown below.
    ```
    BidmadNativeAdWidget(
        onBidmadNativeAdWidgetCreated: _onBidmadNativeAdWidgetCreated,
        layoutName: "nativead_layout"
    ),
    ```

</details>

<details markdown="1">
<summary>iOS Settings</summary>
<br>

1. Create an XIB file by referring to [XIB Layout Setting Guide](https://github.com/bidmad/Bidmad-iOS/wiki/Native-Ad-Layout-Setting-Guide-%5BENG%5D) for iOS.<br>
2. Open Runner.xcworkspace.<br>
   ![iOS-Native-1](https://i.imgur.com/TS7b4vY.png)
3. Put the created XIB file under the project Runner folder inside the Navigation Area.<br>
   ![iOS-Native-2](https://i.imgur.com/zAUopg7.gif)
4. Copy the name without the extension of the XIB file you created and pass it to the BidmadNativeAdWidget constructor layoutName as shown below.<br>
     ```
     BidmadNativeAdWidget(
         onBidmadNativeAdWidgetCreated: _onBidmadNativeAdWidgetCreated,
         layoutName: "IOSNativeAd"
     ),
     ```

</details>

Here's an example requesting native ads:
```dart
....// Banner Widget Init
    Container(
      child: BidmadNativeAdWidget(
        onBidmadNativeAdWidgetCreated: _onBidmadNativeAdWidgetCreated,
        layoutName:"YourXMLorXIBFileName", // Please enter the name of XIB or XML file
      ),
      height: 400,
    ),
    
....// After Banner Widget is fully created, the _onBidmadNativeAdWidgetCreated callback will be called
    void _onBidmadNativeAdWidgetCreated(FlutterBaseNativeAd controller) {
        controller.setAdInfo("Your Zone ID");
        
        controller.setCallbackListener(
          onLoadAd: () {
            print("NativeAd onLoadAd");
          },
          onFailAd: (String error) {
            print("NativeAd onFailAd" + error);
          },
          onClickAd: (() {
            print("NativeAd onClickAd");
          }),
        );
        
        controller.loadWidget();
    }
```

#### 3.5 ATT Functions
reqAdTrackingAuthorization() displays a popup, requesting for App Tracking Consent from user.<br>
And the function will return set of number string values, showing the result.
```dart
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

#### 4.3 FlutterBaseBannerRefined

*Preloaded banner ads are handled through FlutterBaseBannerRefined, and this is a list of features.

Function|Description
---|---
FlutterBaseBannerRefined(String channelNm, String zoneId)|ZoneID, the constructor of the class that initializes the channel name.
load|Call the "load" method.
showBanner|Call the "showBanner" method on the loaded ad.
hideBanner|Call the "hideBanner" method on the loaded ad.
removeBanner|Call the "removeBanner" method on the loaded ad.
setCallbackListener|Set a callback function when an ad loads successfully or fails to load.

#### 4.4 BidmadBannerRefinedWidget

*This is a widget class to show the loaded FlutterBaseBannerRefined instance in the form of a widget.

Function|Description
---|---
BidmadBannerRefinedWidget(FlutterBaseBannerRefined ad)|FlutterBaseBannerRefined instance is passed and the loaded ad is added to the widget tree in the form of a widget.

#### 4.5 FlutterBaseInterstitial

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

#### 4.6 FlutterBaseReward

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

#### 4.7 BidmadNativeAdWidget

*Native ads are provided in the form of widgets and processed through BidmadNativeAdWidget. Below is a list of their features.

Function|Description
----|---
BidmadNativeAdWidget(layoutName, onBidmadNativeAdWidgetCreated)|BidmadNativeAdWidget Constructor. After creating a widget, receive a callback for processing as a param.
onBidmadNativeAdWidgetCreated(FlutterBaseNativeAd controller)|Callback that can receive FlutterBaseNativeAd and handle native ad-related processing.

#### 4.8 FlutterBaseNativeAd

Function|Description
----|---
Future<void> setAdInfo(String zoneId)|Set the issued ZoneId.
Future<void> setCallbackListener(onLoadAd, onFailAd, onClickAd)|Set the callback
void Function() onLoadAd|If a listener is registered, the registered function will be called when the ad loads.
void Function(String errorMsg) onFailAd|If a listener is registered, the registered function will be called when the ad fails to load.
void Function() onClickAd|If a listener is registered, the registered function will be called when the ad is clicked.
Future<void> loadWidget()|Request a native ad.
Future<void> removeWidget()|Remove native ads.

#### 4.9 FlutterBidmadCommon
*This is a list of functions available through BidmadCommon.

Function|Description
---|---
FlutterBidmadCommon()|This is the FlutterBidmadCommon constructor
Future(void) setDebugging(bool isDebug)|Debugging log output
Future(void) initializeSdk(String appKey)|Initialize the BidmadSDK support network. <b>If you do not enter the appKey, advertisements will not be sent.
Future(void) setInitializeCallbackListener(onInitialized)|set the callback listener
Future(void) initializeSdkWithCallback(String appKey)|Initialize the BidmadSDK support network, receiving callback indicating the status
Future(void) setCUID(String cuid)|Enter your custom ID.
Future(String) initBannerChannel()|Creating a channel for controlling banner ad
Future(String) initInterstitialChannel()|Creating a channel for controlling interstitial ad
Future(String) initRewardChannel()|Creating a channel for controlling reward ad
Future(String) reqAdTrackingAuthorization()|Requesting for App Tracking Consent from user
Future(void) setAdvertiserTrackingEnabled(bool enable)|Setting ATT Setting manually
Future(bool) getAdvertiserTrackingEnabled()|Getting ATT Setting, true if consent and false if not consent
