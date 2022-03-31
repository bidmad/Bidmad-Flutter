## Introduce
BidmadPlugin은 모바일 앱 광고 SDK인 Bidmad를 Unity에서 사용하기 위한 Plugin입니다.<br>
Plugin을 사용하여 Flutter 모바일 앱에서 배너 / 전면 / 보상형 광고를 게재 할 수 있습니다.<br>

[Bidmad Flutter Plugin Pub.dev](https://pub.dev/packages/bidmad_plugin)

## Programming Guide

### 1. Android Setting

*1.0.0 이하 버전을 사용 중이시라면 [마이그레이션 가이드](https://github.com/bidmad/Bidmad-Flutter/blob/main/README.md)를 확인 부탁드립니다.

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
"flutter pub get"으로 플러그인을 앱으로 가져오면 프로젝트의 iOS 폴더에 "Podfile"이 생성됩니다. <br>
1.  Podfile에서 플랫폼 요구 사항을 iOS 11로 설정하세요.<br>
    ![Bidmad-Guide-Flutter-1](https://i.imgur.com/1uXp8jR.png)<br>
2.  "pod install" 명령으로 CocoaPods iOS 프레임워크를 설치합니다.<br>
    ![Bidmad-Guide-Flutter-2](https://i.imgur.com/BgmCdA3.png)<br>
3.  이제 "Runner.xcworkspace"라는 이름의 Xcode Workspace 파일을 열고 아래 가이드 2.2를 진행합니다.
    ![Bidmad-Guide-Flutter-3](https://i.imgur.com/UClvij3.png)<br>

#### 2.2 Xcode Build Setting
빌드 설정에서 비트코드 활성화에 대해 "아니요"를 선택합니다. 

#### 2.3 Setting SKAdNetwork
BidmadSDK에서 제공하는 AdNetworks를 사용하려면 SKAdNetworkIdentifier를 Info.plist에 추가해야 합니다. <br>
info.plist에 아래 SKAdNetworkItems를 추가하세요.
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

또한 사용자 데이터를 추적하려는 이유(예: "앱이 추적 목적으로 IDFA에 액세스하려고 함")에 대한 설명과 함께 NSUserTrackingUsageDescription을 info.plist에 추가하세요.
```java
...
<key>NSUserTrackingUsageDescription</key>
<string>App would like to access IDFA for tracking purpose</string>
...
```

### 3. Using Plugin

#### 3.1 InitializeSDK
앱 시작 지점에서 initializeSdk()를 호출하세요.<br>
initializeSdk 메소드가 호출되지 않은 경우 SDK는 첫 번째 로드 시 initializeSdk()를 수행하여 첫 번째 광고 로드가 지연될 수 있습니다.
```
FlutterBidmadCommon().initializeSdk();
```

전면 광고 및 보상형 광고의 경우 initializeSdk()를 호출하는 대신 <br>
아래의 전면 광고 및 보상형 광고 로드 가이드에 따라 앱 시작 지점에 첫 번째 광고를 로드하고,<br>
원하는 시점에 광고를 Show하세요.

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
reqAdTrackingAuthorization()은 사용자에게 앱 추적 동의를 요청하는 팝업을 표시합니다.<br>
그리고 이 함수는 결과를 보여주는 일련의 숫자 문자열 값을 반환합니다.
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
FlutterBaseBanner(@required String channelName)|FlutterBaseBanner 생성자이며, 채널 생성을 위한 이름을 Param으로 받습니다.
Future(void) load(int y)|배너 광고를 요청합니다. 배너 광고가 노출될 때 배너는 높이 y(중앙 정렬)에 노출됩니다.
Future(void) loadWidget()|배너 광고를 요청합니다. 함수가 제대로 작동하려면 BidmadBannerWidget 클래스를 통해 FlutterBaseBanner 객체를 가져와야 합니다.
Future(void) setInterval(int sec)|배너 새로고침 주기를 설정합니다.(60초~120초)
Future(void) setAdInfo(String zoneId)|발급받은 ZoneId를 셋팅합니다.
Future(void) setCUID(String cuid)|각 광고 유형의 CUID 속성을 설정합니다. sha256 이상을 사용하여 텍스트 암호화 권장합니다.
Future(void) hideBanner()|배너 View를 숨깁니다.
Future(void) showBanner()|배너 View를 노출시킵니다.
Future(void) removeBanner()|Load된 배너를 제거합니다.
void Function(String zoneId) onLoadAd|리스너가 등록되어 있으면 광고 로드 시 등록된 함수가 호출됩니다.
void Function(String zoneId) onFailAd|리스너가 등록되어 있으면 광고 로드 실패 시 등록된 함수가 호출됩니다.

#### 4.2 BidmadBannerWidget
*
위젯 형태의 배너 광고의 경우 BidmadBannerWidget을 통해 처리되어야 하며 이에 대한 기능 목록입니다.

Function|Description
---|---
BidmadBannerWidget(BidmadBannerWidgetCreatedCallback onBidmadBannerWidgetCreated)| BidmadBannerWidget 생성자입니다. 위젯 생성 후 처리를 위한 Callback을 Param으로 받습니다.
onBidmadBannerWidgetCreated(FlutterBaseBanner controller)|FlutterBaseBanner를 수신하고 배너 관련 처리를 처리할 수 있는 Callback입니다.

#### 4.3 FlutterBaseInterstitial

*전면 광고는 FlutterBaseInterstitial을 통해 처리되며 이는 해당 기능의 목록입니다.

Function|Description
---|---
FlutterBaseInterstitial(@required String channelName)|FlutterBaseInterstitial 생성자이며, 채널 생성을 위한 이름을 Param으로 받습니다.
Future(void) load()|전면 광고 요청합니다.
Future(void) show()|로드된 전면 광고를 송출합니다.
Future(bool) isLoaded()|광고 로드 여부를 반환합니다.
Future(void) setAdInfo(String zoneId)|발급받은 ZoneId를 셋팅합니다.
Future(void) setCUID(String cuid)|각 광고 유형의 CUID 속성을 설정합니다. sha256 이상을 사용하여 텍스트 암호화 권장합니다.
void Function(String zoneId) onLoadAd|리스너가 등록되어 있으면 광고 로드 시 등록된 함수가 호출됩니다.
void Function(String zoneId) onShowAd|리스너가 등록되어 있으면 광고 송출 시 등록된 함수가 호출됩니다.
void Function(String zoneId) onFailAd|리스너가 등록되어 있으면 광고 요청 실패 시 등록된 함수가 호출됩니다.
void Function(String zoneId) onCloseAd|리스너가 등록되어 있으면 광고를 닫을 때 등록된 함수가 호출됩니다.

#### 4.4 FlutterBaseReward

*보상 광고는 FlutterBaseReward를 통해 처리되며 이에 대한 기능 목록입니다.

Function|Description
---|---
FlutterBaseReward(@required String channelName)|FlutterBaseReward 생성자이며, 채널 생성을 위한 이름을 Param으로 받습니다.
Future(void) load()|보상형 광고 요청합니다.
Future(void) show()|로드된 보상형 광고를 노출합니다.
Future(bool) isLoaded()|광고 로드 여부를 반환합니다.
Future(void) setAdInfo(String zoneId)|발급받은 ZoneId를 셋팅합니다.
Future(void) setCUID(String cuid)|각 광고 유형의 CUID 속성을 설정합니다. sha256 이상을 사용하여 텍스트 암호화 권장합니다.
void Function(String zoneId) onLoadAd|리스너가 등록되어 있으면 광고 로드 시 등록된 함수가 호출됩니다.
void Function(String zoneId) onShowAd|리스너가 등록되어 있으면 광고 송출 시 등록된 함수가 호출됩니다.
void Function(String zoneId) onFailAd|리스너가 등록되어 있으면 광고 요청 실패 시 등록된 함수가 호출됩니다.
void Function(String zoneId) onCompleteAd|리스너가 등록되어 있으면 광고의 보상지급 조건이 충족 된 경우 등록된 함수가 호출됩니다.
void Function(String zoneId) onCloseAd|리스너가 등록되어 있으면 광고를 닫을 때 등록된 함수가 호출됩니다.
void Function(String zoneId) onClickAd|리스너가 등록되어 있으면 광고 클릭 시 등록된 함수가 호출됩니다.
void Function(String zoneId) onSkipAd|리스너가 등록되어 있으면 광고 스킵 시 등록된 함수가 호출됩니다.

#### 4.5 FlutterBidmadCommon
*BidmadCommon을 통해 사용할 수 있는 기능 목록입니다.

Function|Description
---|---
FlutterBidmadCommon()|FlutterBidmadCommon 생성자입니다.
Future(void) setDebugging(bool isDebug)|디버깅 로그 출력합니다.
Future(void) initializeSdk()|BidmadSDK 지원 네트워크를 초기화합니다.
Future(String) initBannerChannel()|배너 광고 제어를 위한 채널을 생성합니다.
Future(String) initInterstitialChannel()|전면 광고를 제어하기 위한 채널을 생성합니다.
Future(String) initRewardChannel()|리워드 광고 제어 채널을 생성합니다.
Future(String) reqAdTrackingAuthorization()|BidmadSDK를 통해 사용자의 앱 추적 동의 팝업을 발생시킵니다.
Future(void) setAdvertiserTrackingEnabled(bool enable)|reqAdTrackingAuthorization 이외의 함수로 앱 추적 투명성 승인 요청 팝업 동의/거절을 얻는 경우 이에 대한 결과를 설정합니다. 
Future(bool) getAdvertiserTrackingEnabled()|설정된 앱 추적 투명성 승인 요청 팝업 동의/거절에 대한 결과를 조회합니다.

