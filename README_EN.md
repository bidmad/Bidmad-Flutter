> [!IMPORTANT]
> Starting with version 1.11.0, the previously used Appkey has been changed to AppDomain.<br>
> **AppDomain is not compatible with existing Appkeys, so a new AppDomain must be issued to initiaize.**<br>
> If you are updating to version 1.11.0, please contact **Techlabs Platform Operations Team.**<br>
>
> **⚠️ Changed in 1.14.0**
>
> - Ad network adapters, AdMob bidding and `BidmadPartners` are **no longer bundled with the plugin** — your app now declares the ad networks it serves. The Dart API is unchanged and no Flutter code needs editing, but an app upgraded without declaring adapters has **no ad network to fill from**. Please read [Migrating to 1.14.0](#migrating-to-1140) and apply the native changes in the same upgrade.
>
> **⚠️ Changed in 1.13.0**
>
> - `BidmadBannerRefinedWidget` now always renders the ad at the **full width** of its parent constraint. A height no longer shrinks the ad to fit; it only clips whatever does not fit. The rule is: **if the width is dynamic, do not set a height** and let the widget derive its own height; **if the width is decided, you may set a height.** For example, a fixed 320dp-wide box with `height: 50` still renders a 320x50 creative in full.
>
>   ![Before and after 1.13.0: previously the ad was nested inside the container, shrunk to fit and leaving empty space at both ends; now it scales to the width of the container and the bottom is clipped by the height of the container](https://i.imgur.com/0b9FgSr.jpg)
>
> - Every `onFailAd` callback now receives an error code as its second argument. The signature changed from `void Function(String errorMsg)` to `void Function(String errorMsg, int errorCode)`, and this applies to banner, refined banner, interstitial, reward and native ads. Handlers written against the previous signature will no longer compile, so add the second parameter when upgrading.

## Introduce
BidmadPlugin is a plugin for using Bidmad, a mobile app advertisement SDK, in Flutter.<br>
You can use the plugin to serve banner/interstitial/reward ads in your flutter mobile app.<br>

[Bidmad Flutter Plugin Pub.dev](https://pub.dev/packages/bidmad_plugin)<br>
[Flutter Sample Download](https://github.com/bidmad/Bidmad-Flutter)

## Migrating to 1.14.0

Through 1.13.x the plugin bundled every ad network adapter, AdMob bidding and `BidmadPartners`. From 1.14.0 the plugin ships **core only**, and your app declares the adapters it serves. This lets you choose your own ad network list, keeps networks you never serve out of your build, and lets you update a single adapter without waiting for a plugin release.

**The Dart API has not changed.** No Dart or Flutter code needs editing — the whole migration happens in your native build files.

### What the plugin still provides

| Platform | Kept in the plugin |
| --- | --- |
| Android | `ad.helper.openbidding:admob-obh`, `com.adop.sdk:bidmad-androidx` |
| iOS | `BidmadSDK`, `OpenBiddingHelper`, `BidmadFlutterBridge`, `BidmadGoogleGDPRAdapter` |

### What moved into your app

| | Android | iOS |
| --- | --- | --- |
| Ad network adapters | every `com.adop.sdk.adapter:*` | every `Bidmad*Adapter` pod |
| AdMob bidding | `com.adop.sdk.partners:admobbidding` | `BidmadPartners/AdMobBidding` |

On Android the plugin also stopped injecting the network-specific maven repositories (Kakao, Pangle, Mintegral, Taboola, PremiumAds) into your project. It still injects `google()`, `mavenCentral()` and the Bidmad repository, which its own core dependencies need.

### Migration steps

1. **Update the plugin.** Set `bidmad_plugin: ^1.14.0` in `pubspec.yaml` and run `flutter pub get`.
2. **Android.** Add the network repositories and the adapters you serve — see [1.4 Ad Network Adapters](#14-ad-network-adapters).
3. **iOS.** Add the adapter pods you serve — see [2.5 Ad Network Adapters](#25-ad-network-adapters) — then run `pod install --repo-update` in the `ios` folder.
4. **Verify.** Build both platforms, call `FlutterBidmadCommon().setDebugging(true)` before requesting an ad, and check that every ad network you expect appears in the debug log. A network missing from the log has no adapter declared.

> [!TIP]
> To make the upgrade behaviour-neutral, start by declaring the **full** list in [1.4](#14-ad-network-adapters) / [2.5](#25-ad-network-adapters) — that is exactly the set the plugin bundled through 1.13.x. Once you have confirmed that ads still fill, delete the networks you do not serve.

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
-keep class com.adop.sdk.adapter.**{ *; }
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

#### 1.4 Ad Network Adapters
As of 1.14.0 the plugin does not bundle ad network adapters. Declare the ad networks you serve in your own app. If you are upgrading from 1.13.x, read [Migrating to 1.14.0](#migrating-to-1140) first.

**1.4.1 Repositories**<br>
Add the repositories your networks need to `allprojects.repositories` in `android/build.gradle`. `google()`, `mavenCentral()` and the Bidmad repository are already injected by the plugin, so only the network-specific entries are required.

```groovy
allprojects {
    repositories {
        google()
        mavenCentral()
        maven { url 'https://devrepo.kakao.com/nexus/content/groups/public/' }                        // AdFit
        maven { url 'https://artifact.bytedance.com/repository/pangle/' }                             // Pangle
        maven { url 'https://dl-maven-android.mintegral.com/repository/mbridge_android_sdk_oversea' } // AdMob bidding
        maven { url 'https://taboolapublic.jfrog.io/artifactory/mobile-release' }                     // Taboola
        maven { url 'https://repo.premiumads.net/artifactory/mobile-ads-sdk/' }                       // PremiumAds
    }
}
```

<details>
<summary>Kotlin DSL — <code>android/build.gradle.kts</code> on newer Flutter templates</summary>

```kotlin
allprojects {
    repositories {
        google()
        mavenCentral()
        maven { url = uri("https://devrepo.kakao.com/nexus/content/groups/public/") }                        // AdFit
        maven { url = uri("https://artifact.bytedance.com/repository/pangle/") }                             // Pangle
        maven { url = uri("https://dl-maven-android.mintegral.com/repository/mbridge_android_sdk_oversea") } // AdMob bidding
        maven { url = uri("https://taboolapublic.jfrog.io/artifactory/mobile-release") }                     // Taboola
        maven { url = uri("https://repo.premiumads.net/artifactory/mobile-ads-sdk/") }                       // PremiumAds
    }
}
```

</details>

**1.4.2 Adapters**<br>
Add the ad networks you serve to `dependencies` in `android/app/build.gradle`. On newer Flutter templates the file is `android/app/build.gradle.kts`, where the same entries are written as `implementation("com.adop.sdk.adapter:admob:25.4.0.0")`.

```groovy
dependencies {
    implementation 'com.adop.sdk.adapter:adfit:3.21.17.1'      // AdFit
    implementation 'com.adop.sdk.adapter:admob:25.4.0.0'       // AdMob
    implementation 'com.adop.sdk.adapter:applovin:13.6.2.1'    // AppLovin
    implementation 'com.adop.sdk.adapter:coupang:1.0.0.7'      // Coupang
    implementation 'com.adop.sdk.adapter:fyber:8.4.6.0'        // Fyber (DT Exchange)
    implementation 'com.adop.sdk.adapter:mobwith:2.0.3'        // MobWith
    implementation 'com.adop.sdk.adapter:ortb:1.0.3'           // oRTB
    implementation 'com.adop.sdk.adapter:pangle:8.1.0.3.0'     // Pangle
    implementation 'com.adop.sdk.adapter:premiumads:1.0.10.0'  // PremiumAds
    implementation 'com.adop.sdk.adapter:taboola:4.0.38.0'     // Taboola
    implementation 'com.adop.sdk.adapter:unityads:4.19.0.0'    // Unity Ads
    implementation 'com.adop.sdk.adapter:vungle:7.7.7.0'       // Vungle (Liftoff)

    implementation 'com.adop.sdk.partners:admobbidding:1.1.6'  // AdMob bidding
}
```

> [!NOTE]
> - **`compileSdk` 36.** `com.adop.sdk.partners:admobbidding` requires the app to compile against API 36. Recent Flutter templates already do, through `compileSdk = flutter.compileSdkVersion`. If your build fails with `requires libraries and applications that depend on it to compile against version 36 or later`, set `compileSdk 36` explicitly in `android/app/build.gradle`.
> - **AdMob Application ID.** The `AndroidManifest.xml` entry in [1.3](#13-admob-application-id-settings) is required whenever you declare the AdMob adapter or AdMob bidding.
> - **Proguard / R8.** The rules in [1.2](#12-proguard-settings) already cover `com.adop.sdk.adapter.**` and stay unchanged. Ad network SDKs also carry optional references to libraries they do not depend on, which R8 reports as `Missing class ...` when you build a release APK. Add the rules that the Android Gradle plugin writes to `build/app/outputs/mapping/release/missing_rules.txt` to your `proguard-rules.pro` — this is expected and does not mean an adapter is missing.

### 2. iOS Setting

#### 2.1 Xcode Version & Privacy Manifest
- Please use Xcode 26.0 or higher for app builds & distribution.
- When submitting your application to the App Store, use the following guide to properly set up your privacy survey: [Guide for Privacy Manifest & Privacy Survey](https://github.com/bidmad/Bidmad-iOS/wiki/Guide-for-Privacy-Manifest-&-Privacy-Survey-%5BEN%5D)

#### 2.2 import BidmadSDK-iOS CocoaPods
After fetching our plugin into your app by "flutter pub get", a "Podfile" will be generated in your project's iOS Folder. <br>
1.  In Podfile, set the platform requirement to iOS 14.<br>
    ![Bidmad-Guide-Flutter-1](https://i.imgur.com/1uXp8jR.png)<br>
2.  Install our CocoaPods iOS Framework with command "pod install"<br>
    ![Bidmad-Guide-Flutter-2](https://i.imgur.com/BgmCdA3.png)<br>
3.  Now, open the Xcode Workspace file with the name "Runner.xcworkspace" and proceed to guide 2.2 below.
    ![Bidmad-Guide-Flutter-3](https://i.imgur.com/UClvij3.png)<br>

#### 2.3 Xcode Build Setting
Select "No" for Enable Bitcode under your Build Setting.

#### 2.4 Info.plist Settings
- In order for ad networks to properly control the UI, please add the following key / value to Info.plist settings

```
<key>UIViewControllerBasedStatusBarAppearance</key>
<true/>
```

- To use AdNetworks provided by BidmadSDK, you need to add SKAdNetworkIdentifier to Info.plist. Please add SKAdNetworkItems below to info.plist.

📄 Please refer to the following wiki page for the up-to-date **SKAdNetworkItems** list: [Preparing for iOS 14 (ENG)](https://github.com/bidmad/Bidmad-iOS/wiki/Preparing-for-iOS-14%5BENG%5D)

- Also, please add NSUserTrackingUsageDescription with your own description of why you would like to track user data (e.g. "App would like to access IDFA for tracking purpose") into info.plist
```java
...
<key>NSUserTrackingUsageDescription</key>
<string>App would like to access IDFA for tracking purpose</string>
...
```

#### 2.5 Ad Network Adapters
As of 1.14.0 the plugin does not bundle ad network adapters. Declare the ad networks you serve inside `target 'Runner'` in `ios/Podfile`, then run `pod install --repo-update` in the `ios` folder. If you are upgrading from 1.13.x, read [Migrating to 1.14.0](#migrating-to-1140) first.

Every Bidmad adapter pod is published on the public CocoaPods trunk, so no extra `source` line is needed.

```ruby
target 'Runner' do
  use_frameworks!

  flutter_install_all_ios_pods File.dirname(File.realpath(__FILE__))

  pod 'BidmadAdFitAdapter', '3.18.3.14.1'            # AdFit
  pod 'BidmadAppLovinAdapter', '13.6.2.14.1'         # AppLovin
  pod 'BidmadFyberAdapter', '8.4.6.14.1'             # Fyber (DT Exchange)
  pod 'BidmadGoogleAdManagerAdapter', '13.2.0.14.1'  # Google Ad Manager
  pod 'BidmadGoogleAdMobAdapter', '13.2.0.14.1'      # AdMob
  pod 'BidmadMobwithAdapter', '2.0.0.14.1'           # MobWith
  pod 'BidmadORTBAdapter', '1.0.0.14.1'              # oRTB
  pod 'BidmadPangleAdapter', '7.9.0.8.14.1'          # Pangle
  pod 'BidmadPremiumAdsGoogleAdapter', '1.0.6.14.1'  # PremiumAds
  pod 'BidmadTaboolaAdapter', '3.9.12.14.1'          # Taboola
  pod 'BidmadTeadsAdapter', '6.1.0.14.1'             # Teads
  pod 'BidmadUnityAdsAdapter', '4.17.0.14.1'         # Unity Ads
  pod 'BidmadVungleAdapter', '7.7.2.14.1'            # Vungle (Liftoff)

  pod 'BidmadPartners/AdMobBidding', '1.0.13'        # AdMob bidding

  target 'RunnerTests' do
    inherit! :search_paths
  end
end
```

> [!NOTE]
> The bundled sets were not identical across platforms. iOS ships AdMob and Google Ad Manager as separate pods, while Android serves Google demand through the single `admob` adapter. Coupang is Android-only, and Teads was bundled on iOS only. Contact the **Techlabs Platform Operations Team** for any network not listed here.

### 3. Using Plugin

#### 3.1 Initializing BidmadSDK
Performs tasks required to run BidmadSDK. The SDK won't allow ads to load unless you call the initializeSdk method.<br>
The initializeSdk method receives App Domain as a parameter.<br> 
Before loading ads, call the initializeSdk method as shown in the following example at the beginning of app execution.<br>
(*To check the App Domain, please contact the Techlabs platform operation team.)

```
if (foundation.defaultTargetPlatform == foundation.TargetPlatform.android) {
    FlutterBidmadCommon().initializeSdk("ANDROID APP Domain");
} else if (foundation.defaultTargetPlatform == foundation.TargetPlatform.iOS) {
    FlutterBidmadCommon().initializeSdk("IOS APP Domain");
}
```

Also, for v1.6.0 or above, you can receive a callback, indicating whether the initialization is successfully or unsuccessfully done.

```
FlutterBidmadCommon common = FlutterBidmadCommon();

if (foundation.defaultTargetPlatform == foundation.TargetPlatform.android) {
  common.setInitializeCallbackListener(onInitialized: (bool isInitialized) {
    print("Android Initialization Done: $isInitialized");
  });
  common.initializeSdkWithCallback("ANDROID APP Domain");
} else if (foundation.defaultTargetPlatform == foundation.TargetPlatform.iOS) {
  common.setInitializeCallbackListener(onInitialized: (bool isInitialized) {
    print("IOS Initialization Done: $isInitialized");
  });
  common.initializeSdkWithCallback("IOS APP Domain");
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
          onLoadAd: (BidmadInfo? info){
            print("banner onLoadAd");
          },
          onFailAd: (String error, int errorCode){
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
        onLoadAd: (BidmadInfo? info){
          print("banner onLoadAd");
        },
        onFailAd: (String error, int errorCode){
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
    FlutterBaseBannerRefined.create(channelNm: chanNm, zoneId: "Your Zone Id").then((ad) {
      bannerAd = ad;
      bannerAd.setCallbackListener(
          onLoadAd: (BidmadInfo? info) {
            print("bannerAdWidget onLoad");
            textView.text = "onLoadAd";
            setState(() {
              isLoaded = true;
            });
          },
          onFailAd: (String error, int errorCode) {
            print("bannerAdWidget onFailAd : "+error);
            textView.text = "onFailAd";
          },
          onClickAd: (BidmadInfo? info) {
            print("bannerAdWidget onClickAd");
            textView.text = "onClickAd";
          });
      bannerAd.load();
    });
  });

....//Show the banner ad widget later by adding the Bidmad
  Container(
    child:  isLoaded ? BidmadBannerRefinedWidget(ad: bannerAd) : Text("isLoading..."),
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
          onLoadAd: (BidmadInfo? info){
            print("interstitial onLoadAd");
          },
          onShowAd: (BidmadInfo? info){
            print("interstitial onShowAd" );
            interstitial.load(); //Ad Reload
          },
          onClickAd: (BidmadInfo? info){
            print("interstitial onClickAd");
          },
          onCloseAd: (BidmadInfo? info){
            print("interstitial onCloseAd");
          },
          onFailAd: (String error, int errorCode){
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
          onLoadAd: (BidmadInfo? info){
            print("reward onLoadAd");
          },
          onShowAd: (BidmadInfo? info){
            print("reward onShowAd");

            reward.load();
          },
          onCompleteAd: (BidmadInfo? info){
            print("reward onCompleteAd");
          },
          onSkipAd: (BidmadInfo? info){
            print("reward onSkippedAd");
          },
          onCloseAd: (BidmadInfo? info){
            print("reward onCloseAd");
          },
          onClickAd: (BidmadInfo? info){
            print("reward onClickAd");
          },
          onFailAd: (String error, int errorCode){
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

1. Create an XML file by referring to [XML Layout Setting Guide](https://github.com/bidmad/Bidmad-Flutter/wiki/Andorid-NativeAd-Layout-Example) for Android.
2. Create a layout folder under the resource file and put the XML file in it.<br>
   ![Android-NativeAd-1](https://i.imgur.com/q8nhvPf.png) <br>
3. Copy the name without the extension of the XML file you created and pass it to the BidmadNativeAdWidget constructor layoutName as shown below.
    ```
    BidmadNativeAdWidget(
        onBidmadNativeAdWidgetCreated: _onBidmadNativeAdWidgetCreated,
        layoutName: "nativead_layout",
        width: 400,
        height: 400
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
         layoutName: "IOSNativeAd",
         width: 400,
         height: 400
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
        width: 400,
        height: 400
      ),
    ),

....// After Banner Widget is fully created, the _onBidmadNativeAdWidgetCreated callback will be called
    void _onBidmadNativeAdWidgetCreated(FlutterBaseNativeAd controller) {
        controller.setAdInfo("Your Zone ID");

        controller.setCallbackListener(
          onLoadAd: (BidmadInfo? info) {
            print("NativeAd onLoadAd");
          },
          onFailAd: (String error, int errorCode) {
            print("NativeAd onFailAd" + error);
          },
          onClickAd: (BidmadInfo? info) {
            print("NativeAd onClickAd");
          }
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
FlutterBaseBanner(String channelName)|This is the FlutterBaseBanner constructor, Receives the Name for Channel creation as a Param.
Future\<void> load(int y)|Request a banner ad. When a banner ad is exposed, the banner is exposed at height y (center alignment).
Future\<void> loadWidget()|Request a banner ad. In order for the function to function properly, FlutterBaseBanner object must be obtained through the BidmadBannerWidget Class.
Future\<void> setInterval(int sec)|Set the banner refresh cycle.(60s~120s)
Future\<void> setAdInfo(String zoneId)|Set the issued ZoneId.
Future\<void> setCUID(String cuid)|Set the CUID property of each ad type. recommend encrypting text using sha256 or higher.
Future\<void> hideBanner()|Hide the banner View
Future\<void> showBanner()|Show the banner View.
Future\<void> removeBanner()|Remove the exposed banner.
void Function(BidmadInfo? info) onLoadAd|If a listener is registered, the registered function is called when ad load.
void Function(String errorMsg, int errorCode) onFailAd|If a listener is registered, the registered function is called when ad load fail.

#### 4.2 BidmadBannerWidget
*For banner ads in the form of a widget, it must be processed through BidmadBannerWidget, and this is a list of functions for that.

Function|Description
---|---
BidmadBannerWidget(<br>&nbsp;&nbsp;&nbsp;&nbsp;void Function(FlutterBaseBanner) onBidmadBannerWidgetCreated<br>)|This is the BidmadBannerWidget constructor. After creating the widget, it receives a callback for processing.
void Function(FlutterBaseBanner) onBidmadBannerWidgetCreated|It is a callback that can receive a FlutterBaseBanner and handle banner related processing.

#### 4.3 FlutterBaseBannerRefined

*Preloaded banner ads are handled through FlutterBaseBannerRefined, and this is a list of features.

Function|Description
---|---
Future\<FlutterBaseBannerRefined> create(String channelNm, String zoneId)|ZoneID, the constructor of the class that initializes the channel name.
void load()|Call the "load" method.
void showBanner()|Call the "showBanner" method on the loaded ad.
void hideBanner()|Call the "hideBanner" method on the loaded ad.
void removeBanner()|Call the "removeBanner" method on the loaded ad.
void Function(BidmadInfo? info) onLoadAd|If a listener is registered, the registered function is called when ad load.
void Function(String errorMsg, int errorCode) onFailAd|If a listener is registered, the registered function is called when ad load fail.
void Function(BidmadInfo? info) onClickAd|If a listener is registered, the registered function is called when ad click.

#### 4.4 BidmadBannerRefinedWidget

*This is a widget class to show the loaded FlutterBaseBannerRefined instance in the form of a widget.

Function|Description
---|---
BidmadBannerRefinedWidget(FlutterBaseBannerRefined ad)|FlutterBaseBannerRefined instance is passed and the loaded ad is added to the widget tree in the form of a widget.
void Function(Size)? onChangedSizeCallback|Returns the changed View size.

#### 4.5 FlutterBaseInterstitial

*Interstitial ads are handled through FlutterBaseInterstitial and this is a list of functions for that.

Function|Description
---|---
FlutterBaseInterstitial(String channelName)|This is the FlutterBaseInterstitial constructor, Receives the Name for Channel creation as a Param.
Future\<void> load()|Request a interstitial ad
Future\<void> show()|Display the loaded interstitial ad
Future\<bool> isLoaded()|Check if the ad is loaded.
Future\<void> setAdInfo(String zoneId)|Set the issued ZoneId.
Future\<void> setCUID(String cuid)|Set the CUID property of each ad type. recommend encrypting text using sha256 or higher.
void Function(BidmadInfo? info) onLoadAd|If a listener is registered, the registered function is called when ad load.
void Function(BidmadInfo? info) onShowAd|If a listener is registered, the registered function is called when ad show.
void Function(String errorMsg, int errorCode) onFailAd|If a listener is registered, the registered function is called when ad load fail.
void Function(BidmadInfo? info) onClickAd|If a listener is registered, the registered function is called when ad click.
void Function(BidmadInfo? info) onCloseAd|If a listener is registered, the registered function is called when ad close.

#### 4.6 FlutterBaseReward

*Reward ads are handled through FlutterBaseReward and this is a list of functions for that.

Function|Description
---|---
FlutterBaseReward(String channelName)|This is the FlutterBaseReward constructor, Receives the Name for Channel creation as a Param.
Future\<void> load()|Request a reward ad.
Future\<void> show()|Display the loaded reward ad.
Future\<bool> isLoaded()|Check if the ad is loaded.
Future\<void> setAdInfo(String zoneId)|Set the issued ZoneId.
Future\<void> setCUID(String cuid)|Set the CUID property of each ad type. recommend encrypting text using sha256 or higher.
void Function(BidmadInfo? info) onLoadAd|If a listener is registered, the registered function is called when ad load.
void Function(BidmadInfo? info) onShowAd|If a listener is registered, the registered function is called when ad show.
void Function(String errorMsg, int errorCode) onFailAd|If a listener is registered, the registered function is called when ad load fail.
void Function(BidmadInfo? info) onCompleteAd|If a listener is registered, the registered function is called when ad complate.
void Function(BidmadInfo? info) onCloseAd|If a listener is registered, the registered function is called when ad close.
void Function(BidmadInfo? info) onClickAd|If a listener is registered, the registered function is called when ad click.
void Function(BidmadInfo? info) onSkipAd|If a listener is registered, the registered function is called when ad skip.

#### 4.7 BidmadNativeAdWidget

*Native ads are provided in the form of widgets and processed through BidmadNativeAdWidget. Below is a list of their features.

Function|Description
----|---
BidmadNativeAdWidget(<br>&nbsp;&nbsp;&nbsp;&nbsp;String layoutName,<br>&nbsp;&nbsp;&nbsp;&nbsp;void Function(FlutterBaseNativeAd) onBidmadNativeAdWidgetCreated,<br>&nbsp;&nbsp;&nbsp;&nbsp;double width,<br>&nbsp;&nbsp;&nbsp;&nbsp;double height<br>)|BidmadNativeAdWidget Constructor. After creating a widget, receive a callback for processing as a param.
void Function(FlutterBaseNativeAd) onBidmadNativeAdWidgetCreated(FlutterBaseNativeAd controller)|Callback that can receive FlutterBaseNativeAd and handle native ad-related processing.

#### 4.8 FlutterBaseNativeAd

Function|Description
----|---
Future\<void> setAdInfo(String zoneId)|Set the issued ZoneId.
void Function(BidmadInfo? info) onLoadAd|If a listener is registered, the registered function will be called when the ad loads.
void Function(String errorMsg, int errorCode) onFailAd|If a listener is registered, the registered function will be called when the ad fails to load.
void Function(BidmadInfo? info) onClickAd|If a listener is registered, the registered function will be called when ad click.
Future\<void> loadWidget()|Request a native ad.
Future\<void> removeWidget()|Remove native ads.

#### 4.9 FlutterBidmadCommon
*This is a list of functions available through BidmadCommon.

Function|Description
---|---
FlutterBidmadCommon()|This is the FlutterBidmadCommon constructor
Future\<void> setDebugging(bool isDebug)|Debugging log output
Future\<void> initializeSdk(String appDomain)|Initialize the BidmadSDK support network. <b>If you do not enter the appDomain, advertisements will not be sent.
Future\<void> setInitializeCallbackListener(onInitialized)|set the callback listener
Future\<void> initializeSdkWithCallback(String appDomain)|Initialize the BidmadSDK support network, receiving callback indicating the status
Future\<void> setCUID(String cuid)|Enter your custom ID.
Future\<String> initBannerChannel()|Creating a channel for controlling banner ad
Future\<String> initInterstitialChannel()|Creating a channel for controlling interstitial ad
Future\<String> initRewardChannel()|Creating a channel for controlling reward ad
Future\<void> setAdFreeEventListener(void Function(bool) onAdStatus)|Set a callback function to receive ad-block status changes caused by the Coupang ad network.
Future\<bool> isAdFree()|Check whether ads are blocked by the Coupang ad network.
Future\<String> reqAdTrackingAuthorization()|Requesting for App Tracking Consent from user
Future\<void> setAdvertiserTrackingEnabled(bool enable)|Setting ATT Setting manually
Future\<bool> getAdvertiserTrackingEnabled()|Getting ATT Setting, true if consent and false if not consent

#### 4.10 BidmadInfo
*Provide ad information about the ad through BidmadInfo returned from the callback.

Member|Description
---|---
String adNetworkName|The advertising network name. For example, Admob
String adType|The ad type. For example banner, interstitial, reward, native
Size? requestedBannerAdSize|The requested banner ad size. Included only in banner ad type.
Size? loadedBannerAdSize|The banner ad size that was actually loaded.

#### References

- [Coupang Network Ad-Block Interface Guide](https://github.com/bidmad/Bidmad-Flutter/wiki/%EC%BF%A0%ED%8C%A1-%EB%84%A4%ED%8A%B8%EC%9B%8C%ED%81%AC-%EA%B4%91%EA%B3%A0-%EC%B0%A8%EB%8B%A8-%EC%9D%B8%ED%84%B0%ED%8E%98%EC%9D%B4%EC%8A%A4-%EA%B0%80%EC%9D%B4%EB%93%9C)
