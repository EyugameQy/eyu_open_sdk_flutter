import Flutter
import UIKit

public protocol SwiftEyuOpenSdkFlutterPluginDelegate: AnyObject {
    func handleInitMessage()
    func handleIsAdLoadedMessage(placeId: String) -> Bool
    func handleShowAdMessage(placeId: String) -> Bool
}

public class SwiftEyuOpenSdkFlutterPlugin: NSObject, FlutterPlugin {
  weak var delegate: SwiftEyuOpenSdkFlutterPluginDelegate?
    
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "com.eyu.opensdk/ad", binaryMessenger: registrar.messenger(), codec: FlutterStandardMethodCodec(readerWriter: EyuAdsReaderWriter()))
//    let channel = FlutterMethodChannel(name: "com.eyu.opensdk/ad", binaryMessenger: registrar.messenger())
    let instance = SwiftEyuOpenSdkFlutterPlugin()
    instance.delegate = UIApplication.shared.delegate as? SwiftEyuOpenSdkFlutterPluginDelegate
    _ = FlutterAdManager(channel: channel)
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    if call.method == "getPlatformVersion" {
        result("iOS " + UIDevice.current.systemVersion)
    } else if call.method == "init" {
        delegate?.handleInitMessage()
    } else if call.method == "isAdLoaded" {
        let dic = call.arguments as? [String: String]
        result(delegate?.handleIsAdLoadedMessage(placeId: dic?["adPlaceId"] ?? ""))
    } else if call.method == "show" {
        let dic = call.arguments as? [String: String]
        result(delegate?.handleShowAdMessage(placeId: dic?["adPlaceId"] ?? ""))
    } else {
        result(FlutterMethodNotImplemented)
    }
  }
}

class EyuAdsReaderWriter: FlutterStandardReaderWriter {
    override func writer(with data: NSMutableData) -> FlutterStandardWriter {
        return EyuAdsWriter(data: data)
    }
}

class EyuAdsWriter: FlutterStandardWriter {
    override func writeValue(_ value: Any) {
        if let ad = value as? FlutterEYuAd {
            self.writeValue(ad.unitId)
            self.writeValue(ad.unitName)
            self.writeValue(ad.adRevenue)
            self.writeValue(ad.adFormat)
            self.writeValue(ad.placeId)
            self.writeValue(ad.mediator)
            self.writeValue(ad.networkName)
            if ad.error != nil {
                self.writeValue(ad.error!.code)
                self.writeValue(ad.error!.localizedDescription)
            }
        } else {
            super.writeValue(value)
        }
    }
}
