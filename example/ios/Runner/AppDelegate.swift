import UIKit
import Flutter
import eyu_open_sdk_flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate, SwiftEyuOpenSdkFlutterPluginDelegate, EYAdDelegate {
    
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    func handleInitMessage() {
        let adConfig = EYAdConfig()
        adConfig.abuAppId = "5149732";
        adConfig.adKeyData = EYSdkUtils.readFile(withName: "ios_ad_key_setting")
        adConfig.adGroupData = EYSdkUtils.readFile(withName: "ios_ad_cache_setting")
        adConfig.adPlaceData = EYSdkUtils.readFile(withName: "ios_ad_setting")
        EYAdManager.sharedInstance()?.setup(with: adConfig)
        EYAdManager.sharedInstance()?.delegate = self
        EYAdManager.sharedInstance()?.rootViewController = window.rootViewController
    }
    
    func handleIsAdLoadedMessage(placeId: String) -> Bool {
        return EYAdManager.sharedInstance()?.isAdLoaaded(placeId) ?? false
    }
    
    func handleShowAdMessage(placeId: String) -> Bool {
        return EYAdManager.sharedInstance()?.showAd(placeId, with: window.rootViewController) ?? false
    }
    
    func logEvenet(name: String, params: [String : Any]?) {
        EYEventUtils.logEvent(name, parameters: params)
    }
    
    func adTypeFor(placeId: String) -> String {
        return EYAdManager.sharedInstance()?.getAdType(placeId) ?? ""
    }
    
    func getBannerView(placeId: String) -> UIView? {
        return EYAdManager.sharedInstance()?.getBannerView(placeId)
    }
    
    func getNativeView(placeId: String) -> UIView? {
        return EYAdManager.sharedInstance()?.getNativeView(placeId, controller: window.rootViewController)
    }
    
    func convertEyuadToFlutter(eyuAd: EYuAd) -> FlutterEYuAd {
        let ad = FlutterEYuAd()
        ad.unitId = eyuAd.unitId
        ad.unitName = eyuAd.unitName
        ad.placeId = eyuAd.placeId
        ad.adFormat = eyuAd.adFormat
        ad.adRevenue = eyuAd.adRevenue
        ad.mediator = eyuAd.mediator
        ad.networkName = eyuAd.networkName
        ad.error = eyuAd.error as NSError
        return ad
    }
    
    func onAdLoaded(_ eyuAd: EYuAd) {
        FlutterAdManager.instance?.onAdLoaded(convertEyuadToFlutter(eyuAd: eyuAd))
    }
    
    func onAdReward(_ eyuAd: EYuAd) {
        FlutterAdManager.instance?.onAdReward(convertEyuadToFlutter(eyuAd: eyuAd))
    }
    
    func onAdShowed(_ eyuAd: EYuAd) {
        FlutterAdManager.instance?.onAdShowed(convertEyuadToFlutter(eyuAd: eyuAd))
    }
    
    func onAdClosed(_ eyuAd: EYuAd) {
        FlutterAdManager.instance?.onAdClosed(convertEyuadToFlutter(eyuAd: eyuAd))
    }
    
    func onAdClicked(_ eyuAd: EYuAd) {
        FlutterAdManager.instance?.onAdClicked(convertEyuadToFlutter(eyuAd: eyuAd))
    }
    
    func onAdLoadFailed(_ eyuAd: EYuAd) {
        FlutterAdManager.instance?.onAdLoadFailed(convertEyuadToFlutter(eyuAd: eyuAd))
    }
    
    func onAdImpression(_ eyuAd: EYuAd) {
        FlutterAdManager.instance?.onAdImpression(convertEyuadToFlutter(eyuAd: eyuAd))
    }
    
    func onAdRevenue(_ eyuAd: EYuAd) {
        FlutterAdManager.instance?.onAdRevenue(convertEyuadToFlutter(eyuAd: eyuAd))
    }
}
