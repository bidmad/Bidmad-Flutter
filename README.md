> [!IMPORTANT]
> 1.11.0 버전부터는 기존에 사용하던 **Appkey가 AppDomain으로 변경**되었습니다.<br>
> **AppDomain은 기존 Appkey와 호환이 되지 않아 initiaize를 위해서는 AppDomain을 새로 발급받으셔야 합니다.**<br>
> 1.11.0 버전으로 업데이트 하시는 경우에는 **테크랩스 플랫폼 사업부 운영팀에 연락 부탁 드립니다.**<br>

## Introduce
BidmadPlugin은 모바일 앱 광고 SDK인 Bidmad를 Unity에서 사용하기 위한 Plugin입니다.<br>
Plugin을 사용하여 Flutter 모바일 앱에서 배너 / 전면 / 보상형 광고를 게재 할 수 있습니다.<br>

[Bidmad Flutter Plugin Pub.dev](https://pub.dev/packages/bidmad_plugin_for_myb)

## Programming Guide

### 1. Android Setting

#### 1.1 gradle.properties Setting
gradle.properties에 아래 옵션을 추가합니다.
```java
...
*AGP 8.3 이상
android.useFullClasspathForDexingTransform=true

*AGP 8.3 미만
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

### 2. iOS Setting

#### 2.1 Xcode Version & Privacy Manifest
- Xcode 15.3 이상을 사용하십시오
- App Store에 애플리케이션을 제출할 때 다음 가이드를 참고하여 개인정보 보호 정책 및 설문조사를 올바르게 설정하세요: [Guide for Privacy Manifest & Privacy Survey](https://github.com/bidmad/Bidmad-iOS/wiki/Guide-for-Privacy-Manifest-&-Privacy-Survey-%5BKR%5D)

#### 2.2 import BidmadSDK-iOS CocoaPods
"flutter pub get"으로 플러그인을 앱으로 가져오면 프로젝트의 iOS 폴더에 "Podfile"이 생성됩니다. <br>
1.  Podfile에서 플랫폼 요구 사항을 iOS 12로 설정하세요.<br>
    ![Bidmad-Guide-Flutter-1](https://i.imgur.com/1uXp8jR.png)<br>
2.  "pod install" 명령으로 CocoaPods iOS 프레임워크를 설치합니다.<br>
    ![Bidmad-Guide-Flutter-2](https://i.imgur.com/BgmCdA3.png)<br>
3.  이제 "Runner.xcworkspace"라는 이름의 Xcode Workspace 파일을 열고 아래 가이드 2.2를 진행합니다.
    ![Bidmad-Guide-Flutter-3](https://i.imgur.com/UClvij3.png)<br>

#### 2.3 Xcode Build Setting
빌드 설정에서 비트코드 활성화에 대해 "아니요"를 선택합니다. 

#### 2.4 Info.plist 세팅
- 광고 네트워크가 UI를 제어할 수 있도록 다음 키/값을 Info.plist 설정에 추가하세요.

```
<key>UIViewControllerBasedStatusBarAppearance</key>
<true/>
```

- BidmadSDK에서 제공하는 AdNetworks를 사용하려면 SKAdNetworkIdentifier를 Info.plist에 추가해야 합니다. info.plist에 아래 SKAdNetworkItems를 추가하세요.

<details markdown="1">
<summary>SKAdNetworkItems List</summary>
<br>

```
<key>SKAdNetworkItems</key>
<array>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>22mmun2rn5.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>238da6jt44.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>24t9a8vw3c.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>24zw6aqk47.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>252b5q8x7y.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>275upjj5gd.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>294l99pt4k.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>2fnua5tdw4.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>2u9pt9hc89.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>32z4fx6l9h.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>3l6bd9hu43.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>3qcr597p9d.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>3qy4746246.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>3rd42ekr43.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>3sh42y64q3.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>424m5254lk.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>4468km3ulz.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>44jx6755aq.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>44n7hlldy6.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>47vhws6wlr.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>488r3q3dtq.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>4dzt52r2t5.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>4fzdc2evr5.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>4mn522wn87.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>4pfyvq9l8r.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>4w7y6s5ca2.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>523jb4fst2.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>52fl2v3hgk.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>54nzkqm89y.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>578prtvx9j.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>5a6flpkh64.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>5f5u5tfb26.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>5l3tpt7t6e.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>5lm9lj6jb7.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>5tjdwbrq8w.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>6964rsfnh4.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>6g9af3uyq4.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>6p4ks3rnbw.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>6v7lgmsu45.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>6xzpu9s2p8.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>6yxyv74ff7.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>737z793b9f.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>74b6s63p6l.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>79pbpufp6p.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>7fmhfwg9en.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>7rz58n8ntl.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>7ug5zh24hu.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>84993kbrcf.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>89z7zv988g.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>8c4e2ghe7u.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>8m87ys6875.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>8r8llnkz5a.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>8s468mfl3y.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>97r2b46745.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>9b89h5y424.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>9nlqeag3gk.skadnetwork</string>
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
    <string>9vvzujtq5s.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>9yg77x724h.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>a2p9lx4jpn.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>a7xqa6mtl2.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>a8cz6cu7e5.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>av6w8kgt66.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>b9bk5wbcq9.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>bxvub5ada5.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>c3frkrj4fj.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>c6k4g5qg8m.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>cg4yq2srnc.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>cj5566h2ga.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>cp8zw746q7.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>cs644xg564.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>cstr6suwn9.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>dbu4b84rxf.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>dkc879ngq3.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>dzg6xy7pwj.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>e5fvkxwrpn.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>ecpz2srf59.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>eh6m2bh4zr.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>ejvt5qm6ak.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>f38h382jlk.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>f73kdq92p3.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>f7s53z58qe.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>feyaarzu9v.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>g28c52eehv.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>g2y4y55b64.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>g6gcrrvk4p.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>ggvn48r87g.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>glqzh8vgby.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>gta8lk7p23.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>gta9lk7p23.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>hb56zgv37p.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>hdw39hrw9y.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>hs6bdukanm.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>k674qkevps.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>k6y4y55b64.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>kbd757ywx3.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>kbmxgpxpgc.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>klf5c3l5u5.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>krvm3zuq6h.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>lr83yxwka7.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>ludvb6z3bs.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>m297p6643m.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>m5mvw97r93.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>m8dbw4sv7c.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>mj797d8u6f.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>mlmmfzh3r3.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>mls7yz5dvl.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>mp6xlyr22a.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>mqn7fxpca7.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>mtkv5xtk9e.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>n38lu8286q.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>n66cz3y3bx.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>n6fk4nfna4.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>n9x2a789qt.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>nzq8sh4pbs.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>p78axxw29g.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>ppxm28t8ap.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>prcb7njmu6.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>pwa73g5rt2.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>pwdxu55a5a.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>qqp299437r.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>qu637u8glc.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>r45fhb6rf7.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>rvh3l7un93.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>rx5hdcabgc.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>s39g8k73mm.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>s69wq72ugq.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>su67r6k2v3.skadnetwork</string>
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
    <string>u679fj5vs4.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>uw77j35x4d.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>v4nxqhlyqp.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>v72qych5uu.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>v79kvwwj4g.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>v9wttpbfk9.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>vcra2ehyfk.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>vhf287vqwu.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>vutu7akeur.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>w9q455wk68.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>wg4vff78zm.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>wzmmz9fp6w.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>x44k69ngh6.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>x5l83yy675.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>x8jxxk4ff5.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>x8uqf25wch.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>xga6mpmplv.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>xy9t38ct57.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>y45688jllp.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>y5ghdn5j9k.skadnetwork</string>
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
    <string>zmvfpc5aq8.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>zq492l623r.skadnetwork</string>
  </dict>
</array>
```

</details>

- 또한 사용자 데이터를 추적하려는 이유(예: "앱이 추적 목적으로 IDFA에 액세스하려고 함")에 대한 설명과 함께 NSUserTrackingUsageDescription을 info.plist에 추가하세요.
```java
...
<key>NSUserTrackingUsageDescription</key>
<string>App would like to access IDFA for tracking purpose</string>
...
```

### 3. Using Plugin

#### 3.1 BidmadSDK 초기화
BidmadSDK 실행에 필요한 작업을 수행합니다. SDK는 initializeSdk 메서드를 호출하지 않은 경우 광고 로드를 허용하지 않습니다.<br>
initializeSdk 메서드는 App Domain를 인자값으로 받고 있으며 광고를 로드하기 전, 앱 실행 초기에 다음 예시와 같이 initializeSdk 메서드를 호출해주십시오.<br>
(*App Domain을 발급받으시려면 테크랩스 플랫폼 운영팀으로 연락 부탁 드립니다.)


```
if (foundation.defaultTargetPlatform == foundation.TargetPlatform.android) {
    FlutterBidmadCommon().initializeSdk("ANDROID App Domain");
} else if (foundation.defaultTargetPlatform == foundation.TargetPlatform.iOS) {
    FlutterBidmadCommon().initializeSdk("IOS App Domain");
}
```

또한, 버전 1.6.0 이상 버전부터, 초기화 성공 여부를 나타내는 콜백을 수신할 수 있습니다.

```
FlutterBidmadCommon common = FlutterBidmadCommon();

if (foundation.defaultTargetPlatform == foundation.TargetPlatform.android) {
  common.setInitializeCallbackListener(onInitialized: (bool isInitialized) {
    print("Android Initialization Done: $isInitialized");
  });
  common.initializeSdkWithCallback("ANDROID App Domain");
} else if (foundation.defaultTargetPlatform == foundation.TargetPlatform.iOS) {
  common.setInitializeCallbackListener(onInitialized: (bool isInitialized) {
    print("IOS Initialization Done: $isInitialized");
  });
  common.initializeSdkWithCallback("IOS App Domain");
}
```

#### 3.2 Banner AD
다음은 배너 광고를 요청하는 예시입니다.

##### 3.2.1 Banner placement based on position
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
          onFailAd: (String error){
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
##### 3.2.2 Banner Widget
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
        onFailAd: (String error){
          print("banner onFailAd");
        }
    );

    controller.loadWidget();
  }
```
##### 3.2.3 먼저 광고를 로드하고 나중에 배너 위젯을 표시합니다. (v1.6.0 이상 버전에서만 지원합니다)
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
          onFailAd: (String error) {
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

#### 3.3 Fullscreen Ad

##### 3.3.1 Fullscreen Ad Migration Guide (v2.0.0 이상)

- **Reward and Interstitial Ad 변경**
   - 'initRewardChannel', 'initInterstitialChannel' 및 'FlutterBaseReward', 'FlutterBaseInterstitial' 생성자가 제거되었습니다.<br />
   이를 대신하여, 'FlutterBaseReward', 'FlutterBaseInterstitial'에서 **'create(String zoneId)'** 메서드를 제공합니다.<br />
   create 메서드를 이용해 객체를 생성하세요.

      ```dart
      /** --------------------- v2.0.0 미만 --------------------- */

      // Interstitial Ads
      common.initInterstitialChannel().then((value) {
        String _channelNm = value;
        interstitial = FlutterBaseInterstitial(channelName: _channelNm);
        // ... interstitial ad instance is now available ...
      });

      // Rewarded Ads
      common.initRewardChannel().then((value) {
        String _channelNm = value;
        reward = FlutterBaseReward(channelName: _channelNm);
        // ... rewarded ad instance is now available ...
      });

      /** --------------------- v2.0.0 이상 --------------------- */

      // Interstitial Ads
      FlutterBaseInterstitial.create("Your Zone Id").then((interstitial) {
        // ... interstitial ad instance is now available ...
      });

      // Rewarded Ads
      FlutterBaseReward.create("Your Zone Id").then((reward) {
        // ... rewarded ad instance is now available ...
      });
      ```

##### 3.3.2 Interstitial Ad
다음은 전면 광고를 요청하는 예시입니다.
```dart
....//Interstitial init
    FlutterBaseInterstitial.create("Your Zone Id").then((interstitial) {
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
          onFailAd: (String error){
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

##### 3.3.3 Reward Ad
다음은 보상형 광고를 요청하는 예시입니다.
```dart
....//Reward init
    FlutterBaseReward.create("Your Zone Id").then((reward) {
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
          onFailAd: (String error){
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

1. Android 를 위한 [XML 레이아웃 설정 가이드](https://github.com/bidmad/Bidmad-Flutter/wiki/Android-NativeAd-Xml-Layout-%EC%9E%91%EC%84%B1-%EC%98%88%EC%8B%9C) 를 참고해 XML 파일을 제작하십시오.
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
      ),
      width: 400,
      height: 400,
    ),
    
....// After Banner Widget is fully created, the _onBidmadNativeAdWidgetCreated callback will be called
    void _onBidmadNativeAdWidgetCreated(FlutterBaseNativeAd controller) {
        controller.setAdInfo("Your Zone ID");
        
        controller.setCallbackListener(
          onLoadAd: (BidmadInfo? info) {
            print("NativeAd onLoadAd");
          },
          onFailAd: (String error) {
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
Future\<void> hideBanner()|배너 View를 숨깁니다.
Future\<void> showBanner()|배너 View를 노출시킵니다.
Future\<void> removeBanner()|Load된 배너를 제거합니다.
void Function(BidmadInfo? info) onLoadAd|리스너가 등록되어 있으면 광고 로드 시 등록된 함수가 호출됩니다.
void Function(String error) onFailAd|리스너가 등록되어 있으면 광고 로드 실패 시 등록된 함수가 호출됩니다.

#### 4.2 BidmadBannerWidget

*위젯 형태의 배너 광고의 경우 BidmadBannerWidget을 통해 처리되어야 하며 이에 대한 기능 목록입니다.

Function|Description
---|---
BidmadBannerWidget(<br>&nbsp;&nbsp;&nbsp;&nbsp;void Function(FlutterBaseBanner) onBidmadBannerWidgetCreated<br>)| BidmadBannerWidget 생성자입니다. 위젯 생성 후 처리를 위한 Callback을 Param으로 받습니다.
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
void Function(String error) onFailAd|리스너가 등록되어 있으면 광고 로드 실패 시 등록된 함수가 호출됩니다.
void Function(BidmadInfo? info) onClickAd|리스너가 등록되어 있으면 광고 클릭 시 등록된 함수가 호출됩니다.

#### 4.4 BidmadBannerRefinedWidget

*로드한 FlutterBaseBannerRefined 인스턴스를 위젯 형태로 보여주기 위한 위젯 클래스입니다.

Function|Description
---|---
BidmadBannerRefinedWidget(FlutterBaseBannerRefined ad)|FlutterBaseBannerRefined 인스턴스를 전달해 로드한 광고를 위젯 형태로 위젯트리에 추가합니다. 
void Function(Size)? onChangedSizeCallback|변경된 View 크기를 반환합니다.

#### 4.5 FlutterBaseInterstitial

*전면 광고는 FlutterBaseInterstitial을 통해 처리되며 이는 해당 기능의 목록입니다.

Function|Description
---|---
static Future\<FlutterBaseInterstitial> create(String zoneId)|zoneId를 사용하여 새 전면 광고 인스턴스를 만들고 초기화합니다.
Future\<void> load()|전면 광고 요청합니다.
Future\<void> show()|로드된 전면 광고를 송출합니다.
Future\<bool> isLoaded()|광고 로드 여부를 반환합니다.
Future\<void> release()|수동으로 전면 광고에 대한 리소스 정리를 수행합니다.
void Function(BidmadInfo? info) onLoadAd|리스너가 등록되어 있으면 광고 로드 시 등록된 함수가 호출됩니다.
void Function(BidmadInfo? info) onShowAd|리스너가 등록되어 있으면 광고 송출 시 등록된 함수가 호출됩니다.
void Function(String error) onFailAd|리스너가 등록되어 있으면 광고 요청 실패 시 등록된 함수가 호출됩니다.
void Function(BidmadInfo? info) onClickAd|리스너가 등록되어 있으면 광고 클릭 시 등록된 함수가 호출됩니다.
void Function(BidmadInfo? info) onCloseAd|리스너가 등록되어 있으면 광고를 닫을 때 등록된 함수가 호출됩니다.

#### 4.6 FlutterBaseReward

*보상 광고는 FlutterBaseReward를 통해 처리되며 이에 대한 기능 목록입니다.

Function|Description
---|---
static Future\<FlutterBaseReward> create(String zoneId)|zoneId를 사용하여 새 보상형 광고 인스턴스를 만들고 초기화합니다.
Future\<void> load()|보상형 광고 요청합니다.
Future\<void> show()|로드된 보상형 광고를 노출합니다.
Future\<bool> isLoaded()|광고 로드 여부를 반환합니다.
Future\<void> release()|수동으로 보상형 광고에 대한 리소스 정리를 수행합니다.
void Function(BidmadInfo? info) onLoadAd|리스너가 등록되어 있으면 광고 로드 시 등록된 함수가 호출됩니다.
void Function(BidmadInfo? info) onShowAd|리스너가 등록되어 있으면 광고 송출 시 등록된 함수가 호출됩니다.
void Function(String error) onFailAd|리스너가 등록되어 있으면 광고 요청 실패 시 등록된 함수가 호출됩니다.
void Function(BidmadInfo? info) onCompleteAd|리스너가 등록되어 있으면 광고의 보상지급 조건이 충족 된 경우 등록된 함수가 호출됩니다.
void Function(BidmadInfo? info) onCloseAd|리스너가 등록되어 있으면 광고를 닫을 때 등록된 함수가 호출됩니다.
void Function(BidmadInfo? info) onClickAd|리스너가 등록되어 있으면 광고 클릭 시 등록된 함수가 호출됩니다.
void Function(BidmadInfo? info) onSkipAd|리스너가 등록되어 있으면 광고 스킵 시 등록된 함수가 호출됩니다.

#### 4.7 BidmadNativeAdWidget

*네이티브 광고의 경우 Widget 형태로 제공하고 있으며 BidmadNativeAdWidget을 통해 처리됩니다. 아래는 해당 기능의 목록입니다.

Function|Description
---|---
BidmadNativeAdWidget(<br>&nbsp;&nbsp;&nbsp;&nbsp;String layoutName,<br>&nbsp;&nbsp;&nbsp;&nbsp;void Function(FlutterBaseNativeAd) onBidmadNativeAdWidgetCreated,<br>&nbsp;&nbsp;&nbsp;&nbsp;double width,<br>&nbsp;&nbsp;&nbsp;&nbsp;double height<br>)|BidmadNativeAdWidget 생성자입니다. 위젯 생성 후 처리를 위한 Callback을 Param으로 받습니다.
void Function(FlutterBaseNativeAd) onBidmadNativeAdWidgetCreated(FlutterBaseNativeAd controller)|FlutterBaseNativeAd를 수신하고 네이티브 광고 관련 처리를 처리할 수 있는 Callback입니다.

#### 4.8 FlutterBaseNativeAd

Function|Description
---|---
Future\<void> setAdInfo(String zoneId)|발급받은 ZoneId를 셋팅합니다.
Future\<void> setCallbackListener(onLoadAd, onFailAd, onClickAd)|콜백을 세팅합니다
void Function(BidmadInfo? info) onLoadAd|리스너가 등록되어 있으면 광고 로드 시 등록된 함수가 호출됩니다.
void Function(String errorMsg) onFailAd|리스너가 등록되어 있으면 광고 로드 실패 시 등록된 함수가 호출됩니다.
void Function(BidmadInfo? info) onClickAd|리스너가 등록되어 있으면 광고 클릭 시 등록된 함수가 호출됩니다.
Future\<void> loadWidget()|네이티브 광고 요청합니다.
Future\<void> removeWidget()|네이티브 광고를 제거합니다.

#### 4.9 FlutterBidmadCommon
*BidmadCommon을 통해 사용할 수 있는 기능 목록입니다.

Function|Description
---|---
FlutterBidmadCommon()|FlutterBidmadCommon 생성자입니다.
Future\<void> setDebugging(bool isDebug)|디버깅 로그 출력합니다.
Future\<void> initializeSdk(String appDomain)|BidmadSDK 지원 네트워크를 초기화합니다. <b>appDomain를 입력하지 않으면 광고가 송출되지 않습니다.
Future\<void> setInitializeCallbackListener(onInitialized)|콜백 리스너를 세팅합니다.
Future\<void> initializeSdkWithCallback(String appDomain)|BidmadSDK 지원 네트워크를 초기화합니다. 해당 메서드 실행 시 콜백을 받을 수 있습니다.
Future\<void> setAdFreeEventListener(void Function\<bool>)|쿠팡 광고네트워크에 의한 광고차단 상태 변경 정보를 받기 위해 콜백 함수를 설정합니다.
Future\<bool> isAdFree()|쿠팡 광고네트워크에 의한 광고 차단 여부를 확인합니다.
Future\<void> setCUID(String cuid)|사용자 정의 ID를 입력합니다.
Future\<String> initBannerChannel()|배너 광고 제어를 위한 채널을 생성합니다.
Future\<String> initBannerRefinedChannel()|BannerRefinedWidget 광고 제어를 위한 채널을 생성합니다.
Future\<void> initNativeAdWidget(String layoutName)|지정한 레이아웃파일을 광고 위젯에 할당하고 초기화합니다.
Future\<String> reqAdTrackingAuthorization()|BidmadSDK를 통해 사용자의 앱 추적 동의 팝업을 발생시킵니다.
Future\<void> setAdvertiserTrackingEnabled(bool enable)|reqAdTrackingAuthorization 이외의 함수로 앱 추적 투명성 승인 요청 팝업 동의/거절을 얻는 경우 이에 대한 결과를 설정합니다. 
Future\<bool> getAdvertiserTrackingEnabled()|설정된 앱 추적 투명성 승인 요청 팝업 동의/거절에 대한 결과를 조회합니다.
Future\<void> setAdFreeEventListener(onAdStatus)|Set listener for ad-free status changes
Future\<bool> isAdFree()|Check if the app is currently in ad-free status

#### 4.10 BidmadInfo
*BidmadInfo는 Callback에서 반환받는 클래스로 광고 정보를 포함하고 있습니다.

Member|Description
---|---
String adNetworkName|예를들면, Admob과 같은 광고 네트워크 이름입니다.
String adType|banner, interstitial, reward, native로 표현되는 광고 타입입니다.
Size? requestedBannerAdSize|요청한 배너광고 사이즈입니다. 배너광고에만 반환됩니다.
Size? loadedBannerAdSize|요청한 배너광고 사이즈입니다. 배너광고에만 반환됩니다.
String zoneId|광고 요청이 이뤄진 광고 영역 식별자입니다.

#### 참고사항

- [쿠팡 네트워크 광고 차단 인터페이스 가이드](https://github.com/bidmad/Bidmad-Flutter/wiki/쿠팡-네트워크-광고-차단-인터페이스-가이드)
