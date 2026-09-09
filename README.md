> [!IMPORTANT]
> 1.11.0 버전부터 기존에 사용하던 Appkey가 AppDomain으로 변경되었습니다.<br>
> **AppDomain은 기존 Appkey와 호환되지 않으므로, 초기화를 위해서는 새로운 AppDomain을 발급받아야 합니다.**<br>
> 1.11.0 버전으로 업데이트하시는 경우 **테크랩스 플랫폼 운영팀**으로 문의 부탁드립니다.<br>
>
> **⚠️ 1.14.0 변경사항**
>
> - 광고 네트워크 어댑터, AdMob 비딩, `BidmadPartners`가 **더 이상 플러그인에 포함되지 않습니다.** 이제 게재하실 광고 네트워크를 앱에서 직접 선언하셔야 합니다. Dart 인터페이스는 변경되지 않았으므로 Flutter 코드를 수정하실 필요는 없으나, 어댑터를 선언하지 않고 업그레이드하신 앱은 **입찰에 참여할 광고 네트워크가 없는 상태**가 됩니다. [1.14.0 마이그레이션 가이드](#1140-마이그레이션-가이드)를 확인하시고 네이티브 설정을 함께 반영해 주십시오.
>
> **⚠️ 1.13.0 변경사항**
>
> - `BidmadBannerRefinedWidget`은 이제 항상 부모 제약조건의 **너비를 가득 채워** 광고를 표기합니다. 높이를 지정해도 더 이상 광고가 축소되지 않고, 높이를 넘어가는 부분이 잘립니다. 기준은 다음과 같습니다. **너비가 가변적이라면 높이를 지정하지 마시고** 위젯이 스스로 높이를 계산하도록 하십시오. **너비가 고정되어 있다면 높이를 지정해도 무방합니다.** 예를 들어 너비를 320dp로 고정한 경우 `height: 50`으로도 320x50 소재가 온전히 표기됩니다.
>
>   ![1.13.0 전후 비교: 기존에는 광고가 높이가 정의된 컨테이너 내부에 위치해 좌우에 빈 공간이 생겼으나, 이제는 컨테이너 가로폭에 맞게 광고 크기를 키우고 하단이 컨테이너 높이에 맞게 잘립니다](https://i.imgur.com/poyKWyT.jpg)
>
> - 모든 `onFailAd` 콜백이 두 번째 인자로 에러 코드를 전달받습니다. 시그니처가 `void Function(String errorMsg)` 에서 `void Function(String errorMsg, int errorCode)` 로 변경되었으며, 배너 / 리파인드 배너 / 전면 / 보상형 / 네이티브 광고에 모두 적용됩니다. 기존 시그니처로 작성된 핸들러는 컴파일되지 않으므로, 업그레이드 시 두 번째 파라미터를 추가해 주십시오.

## Introduce
BidmadPlugin은 모바일 앱 광고 SDK인 Bidmad를 Flutter에서 사용하기 위한 Plugin입니다.<br>
Plugin을 사용하여 Flutter 모바일 앱에서 배너 / 전면 / 보상형 광고를 게재 할 수 있습니다.<br>

[Bidmad Flutter Plugin Pub.dev](https://pub.dev/packages/bidmad_plugin)<br>
[Flutter 샘플 다운로드](https://github.com/bidmad/Bidmad-Flutter)

## 1.14.0 마이그레이션 가이드

1.13.x까지는 모든 광고 네트워크 어댑터와 AdMob 비딩, `BidmadPartners`가 플러그인에 포함되어 있었습니다. 1.14.0부터 플러그인은 **코어만** 제공하며, 게재하실 어댑터는 앱에서 직접 선언하시게 됩니다. 이를 통해 광고 네트워크 구성을 직접 결정하실 수 있고, 게재하지 않는 네트워크가 빌드에 포함되지 않으며, 플러그인 릴리스를 기다리지 않고 개별 어댑터를 업데이트하실 수 있습니다.

**Dart 인터페이스는 변경되지 않았습니다.** Dart / Flutter 코드는 수정하실 필요가 없으며, 마이그레이션은 모두 네이티브 빌드 파일에서 진행됩니다.

### 플러그인이 계속 제공하는 항목

| 플랫폼 | 플러그인에 유지되는 의존성 |
| --- | --- |
| Android | `ad.helper.openbidding:admob-obh`, `com.adop.sdk:bidmad-androidx` |
| iOS | `BidmadSDK`, `OpenBiddingHelper`, `BidmadFlutterBridge`, `BidmadGoogleGDPRAdapter` |

### 앱으로 이동된 항목

| | Android | iOS |
| --- | --- | --- |
| 광고 네트워크 어댑터 | 모든 `com.adop.sdk.adapter:*` | 모든 `Bidmad*Adapter` 파드 |
| AdMob 비딩 | `com.adop.sdk.partners:admobbidding` | `BidmadPartners/AdMobBidding` |

Android의 경우 플러그인이 네트워크별 maven 저장소(Kakao, Pangle, Mintegral, Taboola, PremiumAds)를 프로젝트에 주입하지 않도록 변경되었습니다. 코어 의존성에 필요한 `google()`, `mavenCentral()`, Bidmad 저장소는 플러그인이 계속 주입합니다.

### 마이그레이션 절차

1. **플러그인 업데이트.** `pubspec.yaml`에 `bidmad_plugin: ^1.14.0`을 지정하시고 `flutter pub get`을 실행합니다.
2. **Android.** 필요한 저장소와 게재하실 어댑터를 추가합니다. [1.4 광고 네트워크 어댑터](#14-광고-네트워크-어댑터)를 참고해 주십시오.
3. **iOS.** 게재하실 어댑터 파드를 추가하신 후([2.5 광고 네트워크 어댑터](#25-광고-네트워크-어댑터) 참고), `ios` 폴더에서 `pod install --repo-update`를 실행합니다.
4. **확인.** 양 플랫폼을 빌드하신 뒤 광고 요청 전에 `FlutterBidmadCommon().setDebugging(true)`를 호출하시고, 기대하시는 광고 네트워크가 디버그 로그에 모두 표기되는지 확인해 주십시오. 로그에 표기되지 않는 네트워크는 어댑터가 선언되지 않은 상태입니다.

> [!TIP]
> 업그레이드 전후 동작을 동일하게 유지하시려면, 먼저 [1.4](#14-광고-네트워크-어댑터) / [2.5](#25-광고-네트워크-어댑터)의 **전체 목록**을 그대로 선언해 주십시오. 이는 1.13.x에 포함되어 있던 구성과 정확히 동일합니다. 광고가 정상적으로 게재되는 것을 확인하신 후 게재하지 않는 네트워크를 제거하시는 것을 권장합니다.

## Programming Guide

### 1. Android Setting

*1.0.0 이하 버전을 사용 중이시라면 [마이그레이션 가이드](https://github.com/bidmad/Bidmad-Flutter/wiki/Flutter-Bidmad_Plugin-1.0.0-Migration-Guide%5BKOR%5D)를 확인 부탁드립니다.

#### 1.1 gradle.properties Setting
gradle.properties에 아래 옵션을 추가합니다.
```java
...
android.enableDexingArtifactTransform=false
```

#### 1.2 Proguard Settings
Proguard를 사용하는 경우 아래 규칙을 추가합니다.
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
Android 앱 모듈 내 AndroidManifest.xml의 application 태그 안에 아래 코드를 선언합니다([가이드](https://github.com/bidmad/SDK/wiki/Find-your-app-key%5BEN%5D#app-id-from-admob-dashboard))<br>
   *com.google.android.gms.ads.APPLICATION_ID의 value는 Admob 대시보드에서 확인 바랍니다.

```xml
<application>
   ...
   <meta-data android:name="com.google.android.gms.ads.APPLICATION_ID" android:value="APPLICATION_ID"/>
   ...
</application>
```

#### 1.4 광고 네트워크 어댑터
1.14.0부터 플러그인은 광고 네트워크 어댑터를 포함하지 않습니다. 게재하실 광고 네트워크를 앱에서 직접 선언해 주십시오. 1.13.x에서 업그레이드하시는 경우 [1.14.0 마이그레이션 가이드](#1140-마이그레이션-가이드)를 먼저 확인 부탁드립니다.

**1.4.1 저장소 설정**<br>
`android/build.gradle`의 `allprojects.repositories`에 사용하실 네트워크의 저장소를 추가합니다. `google()`, `mavenCentral()`, Bidmad 저장소는 플러그인이 이미 주입하므로 네트워크별 항목만 추가하시면 됩니다.

```groovy
allprojects {
    repositories {
        google()
        mavenCentral()
        maven { url 'https://devrepo.kakao.com/nexus/content/groups/public/' }                        // AdFit
        maven { url 'https://artifact.bytedance.com/repository/pangle/' }                             // Pangle
        maven { url 'https://dl-maven-android.mintegral.com/repository/mbridge_android_sdk_oversea' } // AdMob 비딩
        maven { url 'https://taboolapublic.jfrog.io/artifactory/mobile-release' }                     // Taboola
        maven { url 'https://repo.premiumads.net/artifactory/mobile-ads-sdk/' }                       // PremiumAds
    }
}
```

<details>
<summary>Kotlin DSL — 최신 Flutter 템플릿의 <code>android/build.gradle.kts</code></summary>

```kotlin
allprojects {
    repositories {
        google()
        mavenCentral()
        maven { url = uri("https://devrepo.kakao.com/nexus/content/groups/public/") }                        // AdFit
        maven { url = uri("https://artifact.bytedance.com/repository/pangle/") }                             // Pangle
        maven { url = uri("https://dl-maven-android.mintegral.com/repository/mbridge_android_sdk_oversea") } // AdMob 비딩
        maven { url = uri("https://taboolapublic.jfrog.io/artifactory/mobile-release") }                     // Taboola
        maven { url = uri("https://repo.premiumads.net/artifactory/mobile-ads-sdk/") }                       // PremiumAds
    }
}
```

</details>

**1.4.2 어댑터 설정**<br>
`android/app/build.gradle`의 `dependencies`에 게재하실 광고 네트워크를 추가합니다. 최신 Flutter 템플릿에서는 해당 파일이 `android/app/build.gradle.kts`이며, 동일한 항목을 `implementation("com.adop.sdk.adapter:admob:25.4.0.0")` 형식으로 작성합니다.

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

    implementation 'com.adop.sdk.partners:admobbidding:1.1.6'  // AdMob 비딩
}
```

> [!NOTE]
> - **`compileSdk` 36.** `com.adop.sdk.partners:admobbidding`은 앱이 API 36으로 컴파일되어야 합니다. 최신 Flutter 템플릿은 `compileSdk = flutter.compileSdkVersion`을 통해 이미 36을 사용합니다. 빌드 시 `requires libraries and applications that depend on it to compile against version 36 or later` 오류가 발생하는 경우 `android/app/build.gradle`에 `compileSdk 36`을 명시해 주십시오.
> - **AdMob Application ID.** AdMob 어댑터 또는 AdMob 비딩을 선언하시는 경우 [1.3](#13-admob-application-id-settings)의 `AndroidManifest.xml` 설정이 반드시 필요합니다.
> - **Proguard / R8.** [1.2](#12-proguard-settings)의 규칙에 `com.adop.sdk.adapter.**`가 이미 포함되어 있으며 변경 사항은 없습니다. 한편 광고 네트워크 SDK는 의존하지 않는 라이브러리를 선택적으로 참조하는 경우가 있어, release APK 빌드 시 R8이 `Missing class ...` 오류를 보고할 수 있습니다. 이 경우 Android Gradle 플러그인이 `build/app/outputs/mapping/release/missing_rules.txt`에 생성한 규칙을 `proguard-rules.pro`에 추가해 주십시오. 정상적인 동작이며 어댑터가 누락된 것은 아닙니다.

### 2. iOS Setting

#### 2.1 Xcode 버전 & Privacy Manifest
- 앱 빌드 및 배포 시 Xcode 26.0 이상을 사용해 주십시오.
- App Store에 애플리케이션을 제출할 때에는 아래 가이드를 참고해 개인정보 설문을 올바르게 설정해 주십시오: [Privacy Manifest & Privacy Survey 가이드](https://github.com/bidmad/Bidmad-iOS/wiki/Guide-for-Privacy-Manifest-&-Privacy-Survey-%5BKOR%5D)

#### 2.2 import BidmadSDK-iOS CocoaPods
"flutter pub get"으로 플러그인을 앱으로 가져오면 프로젝트의 iOS 폴더에 "Podfile"이 생성됩니다. <br>
1.  Podfile에서 플랫폼 요구 사항을 iOS 14로 설정하세요.<br>
    ![Bidmad-Guide-Flutter-1](https://i.imgur.com/1uXp8jR.png)<br>
2.  "pod install" 명령으로 CocoaPods iOS 프레임워크를 설치합니다.<br>
    ![Bidmad-Guide-Flutter-2](https://i.imgur.com/BgmCdA3.png)<br>
3.  이제 "Runner.xcworkspace"라는 이름의 Xcode Workspace 파일을 열고 아래 가이드 2.3을 진행합니다.
    ![Bidmad-Guide-Flutter-3](https://i.imgur.com/UClvij3.png)<br>

#### 2.3 Xcode Build Setting
빌드 설정에서 비트코드 활성화에 대해 "아니요"를 선택합니다.

#### 2.4 Info.plist 설정
- 광고 네트워크가 UI를 정상적으로 제어할 수 있도록, Info.plist에 아래 key / value를 추가해 주십시오.

```
<key>UIViewControllerBasedStatusBarAppearance</key>
<true/>
```

- BidmadSDK에서 제공하는 AdNetworks를 사용하려면 SKAdNetworkIdentifier를 Info.plist에 추가해야 합니다. info.plist에 아래 SKAdNetworkItems를 추가하세요.

📄 최신 **SKAdNetworkItems** 전체 목록은 아래 위키 페이지를 참고하세요: [iOS 14 준비하기 (KOR)](https://github.com/bidmad/Bidmad-iOS/wiki/Preparing-for-iOS-14%5BKOR%5D)

- 또한 사용자 데이터를 추적하려는 이유(예: "앱이 추적 목적으로 IDFA에 액세스하려고 함")에 대한 설명과 함께 NSUserTrackingUsageDescription을 info.plist에 추가하세요.
```java
...
<key>NSUserTrackingUsageDescription</key>
<string>App would like to access IDFA for tracking purpose</string>
...
```

#### 2.5 광고 네트워크 어댑터
1.14.0부터 플러그인은 광고 네트워크 어댑터를 포함하지 않습니다. `ios/Podfile`의 `target 'Runner'` 안에 게재하실 광고 네트워크를 선언하신 뒤, `ios` 폴더에서 `pod install --repo-update`를 실행해 주십시오. 1.13.x에서 업그레이드하시는 경우 [1.14.0 마이그레이션 가이드](#1140-마이그레이션-가이드)를 먼저 확인 부탁드립니다.

모든 Bidmad 어댑터 파드는 공개 CocoaPods trunk에 배포되어 있으므로 별도의 `source` 선언은 필요하지 않습니다.

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

  pod 'BidmadPartners/AdMobBidding', '1.0.13'        # AdMob 비딩

  target 'RunnerTests' do
    inherit! :search_paths
  end
end
```

> [!NOTE]
> 플랫폼별로 포함되어 있던 구성이 완전히 동일하지는 않았습니다. iOS는 AdMob과 Google Ad Manager를 별도 파드로 제공하지만, Android는 `admob` 어댑터 하나로 Google 수요를 처리합니다. Coupang은 Android에만, Teads는 iOS에만 포함되어 있었습니다. 목록에 없는 네트워크는 **테크랩스 플랫폼 운영팀**으로 문의 부탁드립니다.

### 3. Using Plugin

#### 3.1 BidmadSDK 초기화
BidmadSDK 실행에 필요한 작업을 수행합니다. SDK는 initializeSdk 메서드를 호출하지 않은 경우 광고 로드를 허용하지 않습니다.<br>
initializeSdk 메서드는 App Domain을 인자값으로 받습니다.<br>
광고를 로드하기 전, 앱 실행 초기에 다음 예시와 같이 initializeSdk 메서드를 호출해주십시오.<br>
(*App Domain 확인은 테크랩스 플랫폼 운영팀으로 문의 부탁드립니다.)

```
if (foundation.defaultTargetPlatform == foundation.TargetPlatform.android) {
    FlutterBidmadCommon().initializeSdk("ANDROID APP Domain");
} else if (foundation.defaultTargetPlatform == foundation.TargetPlatform.iOS) {
    FlutterBidmadCommon().initializeSdk("IOS APP Domain");
}
```

또한, 버전 1.6.0 이상 버전부터, 초기화 성공 여부를 나타내는 콜백을 수신할 수 있습니다.

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
다음은 배너 광고를 요청하는 예시입니다.

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
##### 3.1.3 먼저 광고를 로드하고 나중에 배너 위젯을 표시합니다. (v1.6.0 이상 버전에서만 지원합니다)
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
다음은 전면 광고를 요청하는 예입니다.
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
다음은 리워드 광고를 요청하는 예시입니다.
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
네이티브 광고는 앱 고유의 UI 구성요소를 통해 사용자에게 표시되는 광고 포맷입니다.
네이티브 광고를 표기하기 위해선 내부 앱 고유의 UI 디자인이 필요하기 때문에, 해당 기능을 사용하려면 Android 및 iOS에 대한 추가 설정이 필요합니다.

<details markdown="1">
<summary>Android 세팅</summary>
<br>

1. Android 를 위한 [XML 레이아웃 설정 가이드](https://github.com/bidmad/Bidmad-Flutter/wiki/Andorid-NativeAd-Layout-Example) 를 참고해 XML 파일을 제작하십시오.
2. Resource 파일 아래 layout 폴더를 만들고 XML 파일을 넣어주세요.<br>
   ![Android-NativeAd-1](https://i.imgur.com/q8nhvPf.png) <br>
3. 만든 XML 파일의 확장자가 제외된 이름을 복사해 아래와 같이 BidmadNativeAdWidget 생성자 layoutName에 전달하십시오.
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
<summary>iOS 세팅</summary>
<br>

1. iOS 를 위한 [XIB 레이아웃 설정 가이드](https://github.com/bidmad/Bidmad-iOS/wiki/Native-Ad-Layout-Setting-Guide-%5BKOR%5D) 를 참고해 XIB 파일을 제작하십시오.<br>
2. Runner.xcworkspace 를 오픈합니다.<br>
    ![iOS-Native-1](https://i.imgur.com/TS7b4vY.png)
3. 만든 XIB 파일을 Navigation Area 내부 프로젝트 Runner 폴더 아래로 넣어주세요.<br>
    ![iOS-Native-2](https://i.imgur.com/zAUopg7.gif)
4. 만든 XIB 파일의 확장자가 제외된 이름을 복사해 아래와 같이 BidmadNativeAdWidget 생성자 layoutName에 전달하십시오.<br>
    ```
    BidmadNativeAdWidget(
        onBidmadNativeAdWidgetCreated: _onBidmadNativeAdWidgetCreated,
        layoutName: "IOSNativeAd",
        width: 400,
        height: 400
    ),
    ```

</details>

다음은 네이티브 광고를 요청하는 예시입니다.
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
reqAdTrackingAuthorization()은 사용자에게 앱 추적 동의를 요청하는 팝업을 표시합니다.<br>
그리고 이 함수는 결과를 보여주는 일련의 숫자 문자열 값을 반환합니다.
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
앱 추적이 결정되지 않은 경우 함수는 0을 반환하고,<br>
App Tracking Restricted Authorization Status의 경우 함수는 1을 반환하고,<br>
App Tracking Denied Authorization Status의 경우 함수는 2를 반환하고,<br>
App Tracking Authorized Authorization Status의 경우 함수는 3을 반환하고,<br>
마지막으로 사용자가 iOS 14보다 낮은 버전을 사용하는 경우 4를 반환합니다.<br>

Plugin에서 제공하지 않는 방법으로 앱 추적 동의를 받고자 하는 경우,<br>
사용자가 동의하면 True, 거부되면 False를 setAdvertiserTrackingEnabled을 통해 전달합니다.

```java
    common.setAdvertiserTrackingEnabled(false);
    print(common.getAdvertiserTrackingEnabled());
```

### 4. Plugin Interface
#### 4.1 FlutterBaseBanner

*배너 광고는 FlutterBaseBanner를 통해 처리되며 이에 대한 기능 목록입니다.

Function|Description
---|---
FlutterBaseBanner(String channelName)|FlutterBaseBanner 생성자이며, 채널 생성을 위한 이름을 Param으로 받습니다.
Future\<void> load(int y)|배너 광고를 요청합니다. 배너 광고가 노출될 때 배너는 높이 y(중앙 정렬)에 노출됩니다.
Future\<void> loadWidget()|배너 광고를 요청합니다. 함수가 제대로 작동하려면 BidmadBannerWidget 클래스를 통해 FlutterBaseBanner 객체를 가져와야 합니다.
Future\<void> setInterval(int sec)|배너 새로고침 주기를 설정합니다.(60초~120초)
Future\<void> setAdInfo(String zoneId)|발급받은 ZoneId를 셋팅합니다.
Future\<void> setCUID(String cuid)|각 광고 유형의 CUID 속성을 설정합니다. sha256 이상을 사용하여 텍스트 암호화 권장합니다.
Future\<void> hideBanner()|배너 View를 숨깁니다.
Future\<void> showBanner()|배너 View를 노출시킵니다.
Future\<void> removeBanner()|Load된 배너를 제거합니다.
void Function(BidmadInfo? info) onLoadAd|리스너가 등록되어 있으면 광고 로드 시 등록된 함수가 호출됩니다.
void Function(String errorMsg, int errorCode) onFailAd|리스너가 등록되어 있으면 광고 로드 실패 시 등록된 함수가 호출됩니다.

#### 4.2 BidmadBannerWidget
*위젯 형태의 배너 광고의 경우 BidmadBannerWidget을 통해 처리되어야 하며 이에 대한 기능 목록입니다.

Function|Description
---|---
BidmadBannerWidget(<br>&nbsp;&nbsp;&nbsp;&nbsp;void Function(FlutterBaseBanner) onBidmadBannerWidgetCreated<br>)|BidmadBannerWidget 생성자입니다. 위젯 생성 후 처리를 위한 Callback을 Param으로 받습니다.
void Function(FlutterBaseBanner) onBidmadBannerWidgetCreated|FlutterBaseBanner를 수신하고 배너 관련 처리를 처리할 수 있는 Callback입니다.

#### 4.3 FlutterBaseBannerRefined

*미리 로드하는 형태의 배너 광고는 FlutterBaseBannerRefined를 통해 처리되며 이에 대한 기능 목록입니다.

Function|Description
---|---
Future\<FlutterBaseBannerRefined> create(String channelNm, String zoneId)|ZoneID, 채널 이름을 초기화하는 클래스의 생성자.
void load()|"로드" 메서드를 호출합니다.
void showBanner()|로드된 광고에서 "showBanner" 메소드를 호출합니다.
void hideBanner()|로드된 광고에서 "hideBanner" 메소드를 호출합니다.
void removeBanner()|로드된 광고에서 "removeBanner" 메소드를 호출합니다.
void Function(BidmadInfo? info) onLoadAd|리스너가 등록되어 있으면 광고 로드 시 등록된 함수가 호출됩니다.
void Function(String errorMsg, int errorCode) onFailAd|리스너가 등록되어 있으면 광고 로드 실패 시 등록된 함수가 호출됩니다.
void Function(BidmadInfo? info) onClickAd|리스너가 등록되어 있으면 광고 클릭 시 등록된 함수가 호출됩니다.

#### 4.4 BidmadBannerRefinedWidget

*로드한 FlutterBaseBannerRefined 인스턴스를 위젯 형태로 보여주기 위한 위젯 클래스입니다.

Function|Description
---|---
BidmadBannerRefinedWidget(FlutterBaseBannerRefined ad)|FlutterBaseBannerRefined 인스턴스를 전달해 로드한 광고를 위젯 형태로 위젯트리에 추가합니다.
void Function(Size)? onChangedSizeCallback|변경된 View 사이즈를 반환합니다.

#### 4.5 FlutterBaseInterstitial

*전면 광고는 FlutterBaseInterstitial을 통해 처리되며 이는 해당 기능의 목록입니다.

Function|Description
---|---
FlutterBaseInterstitial(String channelName)|FlutterBaseInterstitial 생성자이며, 채널 생성을 위한 이름을 Param으로 받습니다.
Future\<void> load()|전면 광고 요청합니다.
Future\<void> show()|로드된 전면 광고를 송출합니다.
Future\<bool> isLoaded()|광고 로드 여부를 반환합니다.
Future\<void> setAdInfo(String zoneId)|발급받은 ZoneId를 셋팅합니다.
Future\<void> setCUID(String cuid)|각 광고 유형의 CUID 속성을 설정합니다. sha256 이상을 사용하여 텍스트 암호화 권장합니다.
void Function(BidmadInfo? info) onLoadAd|리스너가 등록되어 있으면 광고 로드 시 등록된 함수가 호출됩니다.
void Function(BidmadInfo? info) onShowAd|리스너가 등록되어 있으면 광고 송출 시 등록된 함수가 호출됩니다.
void Function(String errorMsg, int errorCode) onFailAd|리스너가 등록되어 있으면 광고 요청 실패 시 등록된 함수가 호출됩니다.
void Function(BidmadInfo? info) onClickAd|리스너가 등록되어 있으면 광고 클릭 시 등록된 함수가 호출됩니다.
void Function(BidmadInfo? info) onCloseAd|리스너가 등록되어 있으면 광고를 닫을 때 등록된 함수가 호출됩니다.

#### 4.6 FlutterBaseReward

*보상 광고는 FlutterBaseReward를 통해 처리되며 이에 대한 기능 목록입니다.

Function|Description
---|---
FlutterBaseReward(String channelName)|FlutterBaseReward 생성자이며, 채널 생성을 위한 이름을 Param으로 받습니다.
Future\<void> load()|보상형 광고 요청합니다.
Future\<void> show()|로드된 보상형 광고를 노출합니다.
Future\<bool> isLoaded()|광고 로드 여부를 반환합니다.
Future\<void> setAdInfo(String zoneId)|발급받은 ZoneId를 셋팅합니다.
Future\<void> setCUID(String cuid)|각 광고 유형의 CUID 속성을 설정합니다. sha256 이상을 사용하여 텍스트 암호화 권장합니다.
void Function(BidmadInfo? info) onLoadAd|리스너가 등록되어 있으면 광고 로드 시 등록된 함수가 호출됩니다.
void Function(BidmadInfo? info) onShowAd|리스너가 등록되어 있으면 광고 송출 시 등록된 함수가 호출됩니다.
void Function(String errorMsg, int errorCode) onFailAd|리스너가 등록되어 있으면 광고 요청 실패 시 등록된 함수가 호출됩니다.
void Function(BidmadInfo? info) onCompleteAd|리스너가 등록되어 있으면 광고의 보상지급 조건이 충족 된 경우 등록된 함수가 호출됩니다.
void Function(BidmadInfo? info) onCloseAd|리스너가 등록되어 있으면 광고를 닫을 때 등록된 함수가 호출됩니다.
void Function(BidmadInfo? info) onClickAd|리스너가 등록되어 있으면 광고 클릭 시 등록된 함수가 호출됩니다.
void Function(BidmadInfo? info) onSkipAd|리스너가 등록되어 있으면 광고 스킵 시 등록된 함수가 호출됩니다.

#### 4.7 BidmadNativeAdWidget

*네이티브 광고의 경우 Widget 형태로 제공하고 있으며 BidmadNativeAdWidget을 통해 처리됩니다. 아래는 해당 기능의 목록입니다.

Function|Description
----|---
BidmadNativeAdWidget(<br>&nbsp;&nbsp;&nbsp;&nbsp;String layoutName,<br>&nbsp;&nbsp;&nbsp;&nbsp;void Function(FlutterBaseNativeAd) onBidmadNativeAdWidgetCreated,<br>&nbsp;&nbsp;&nbsp;&nbsp;double width,<br>&nbsp;&nbsp;&nbsp;&nbsp;double height<br>)|BidmadNativeAdWidget 생성자입니다. 위젯 생성 후 처리를 위한 Callback을 Param으로 받습니다.
void Function(FlutterBaseNativeAd) onBidmadNativeAdWidgetCreated(FlutterBaseNativeAd controller)|FlutterBaseNativeAd를 수신하고 네이티브 광고 관련 처리를 처리할 수 있는 Callback입니다.

#### 4.8 FlutterBaseNativeAd

Function|Description
----|---
Future\<void> setAdInfo(String zoneId)|발급받은 ZoneId를 셋팅합니다.
void Function(BidmadInfo? info) onLoadAd|리스너가 등록되어 있으면 광고 로드 시 등록된 함수가 호출됩니다.
void Function(String errorMsg, int errorCode) onFailAd|리스너가 등록되어 있으면 광고 로드 실패 시 등록된 함수가 호출됩니다.
void Function(BidmadInfo? info) onClickAd|리스너가 등록되어 있으면 광고 클릭 시 등록된 함수가 호출됩니다.
Future\<void> loadWidget()|네이티브 광고 요청합니다.
Future\<void> removeWidget()|네이티브 광고를 제거합니다.

#### 4.9 FlutterBidmadCommon
*BidmadCommon을 통해 사용할 수 있는 기능 목록입니다.

Function|Description
---|---
FlutterBidmadCommon()|FlutterBidmadCommon 생성자입니다.
Future\<void> setDebugging(bool isDebug)|디버깅 로그 출력합니다.
Future\<void> initializeSdk(String appDomain)|BidmadSDK 지원 네트워크를 초기화합니다. <b>appDomain을 입력하지 않으면 광고가 송출되지 않습니다.
Future\<void> setInitializeCallbackListener(onInitialized)|콜백 리스너를 세팅합니다.
Future\<void> initializeSdkWithCallback(String appDomain)|BidmadSDK 지원 네트워크를 초기화합니다. 해당 메서드 실행 시 콜백을 받을 수 있습니다.
Future\<void> setCUID(String cuid)|사용자 정의 ID를 입력합니다.
Future\<String> initBannerChannel()|배너 광고 제어를 위한 채널을 생성합니다.
Future\<String> initInterstitialChannel()|전면 광고를 제어하기 위한 채널을 생성합니다.
Future\<String> initRewardChannel()|리워드 광고 제어 채널을 생성합니다.
Future\<void> setAdFreeEventListener(void Function(bool) onAdStatus)|쿠팡 광고네트워크에 의한 광고차단 상태 변경 정보를 받기 위해 콜백 함수를 설정합니다.
Future\<bool> isAdFree()|쿠팡 광고네트워크에 의한 광고 차단 여부를 확인합니다.
Future\<String> reqAdTrackingAuthorization()|BidmadSDK를 통해 사용자의 앱 추적 동의 팝업을 발생시킵니다.
Future\<void> setAdvertiserTrackingEnabled(bool enable)|reqAdTrackingAuthorization 이외의 함수로 앱 추적 투명성 승인 요청 팝업 동의/거절을 얻는 경우 이에 대한 결과를 설정합니다.
Future\<bool> getAdvertiserTrackingEnabled()|설정된 앱 추적 투명성 승인 요청 팝업 동의/거절에 대한 결과를 조회합니다.

#### 4.10 BidmadInfo
*콜백으로 전달되는 BidmadInfo를 통해 광고에 대한 정보를 제공합니다.

Member|Description
---|---
String adNetworkName|광고 네트워크 이름입니다. 예) Admob
String adType|광고 타입입니다. 예) banner, interstitial, reward, native
Size? requestedBannerAdSize|요청한 배너 광고 사이즈입니다. 배너 광고 타입에만 포함됩니다.
Size? loadedBannerAdSize|실제로 로드된 배너 광고 사이즈입니다.

#### 참고사항

- [쿠팡 네트워크 광고 차단 인터페이스 가이드](https://github.com/bidmad/Bidmad-Flutter/wiki/쿠팡-네트워크-광고-차단-인터페이스-가이드)
