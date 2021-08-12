import Flutter
import UIKit

public protocol SwiftEyuOpenSdkFlutterPluginDelegate: AnyObject {
    func handleInitMessage()
    func handleIsAdLoadedMessage(placeId: String) -> Bool
    func handleShowAdMessage(placeId: String) -> Bool
    func adTypeFor(placeId: String) -> String
    func getBannerView(placeId: String) -> UIView?
    func getNativeView(placeId: String) -> UIView?
    func logEvenet(name: String, params: [String: Any]?)
}

public class SwiftEyuOpenSdkFlutterPlugin: NSObject, FlutterPlugin {
  weak var delegate: SwiftEyuOpenSdkFlutterPluginDelegate?
    
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "com.eyu.opensdk/ad", binaryMessenger: registrar.messenger(), codec: FlutterStandardMethodCodec(readerWriter: EyuAdsReaderWriter()))
    let instance = SwiftEyuOpenSdkFlutterPlugin()
    instance.delegate = UIApplication.shared.delegate as? SwiftEyuOpenSdkFlutterPluginDelegate
    _ = FlutterAdManager(channel: channel)
    
    registrar.addMethodCallDelegate(instance, channel: channel)
    registrar.register(EYSdkAdViewFactory(flutterPluginDelegate: instance.delegate), withId: "com.eyu.opensdk/ad/ad_widget")
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
    } else if call.method == "" {
        let dic = call.arguments as? [String: Any]
        let pramas = dic?["params"] as? [String: Any]
        delegate?.logEvenet(name: dic?["eventName"] as? String ?? "", params: pramas)
    } else {
        result(FlutterMethodNotImplemented)
    }
  }
}

class EyuAdsReaderWriter: FlutterStandardReaderWriter {
    override func writer(with data: NSMutableData) -> FlutterStandardWriter {
        return EyuAdsWriter(data: data)
    }
    
    override func reader(with data: Data) -> FlutterStandardReader {
        return super.reader(with: data)
    }
}

class EyuAdsWriter: FlutterStandardWriter {
    private let VALUE_AD: UInt8 = 128;
    private let VALUE_AD_ERROR: UInt8 = 129;
    
    override func writeValue(_ value: Any) {
        if let ad = value as? FlutterEYuAd {
            self.writeByte(VALUE_AD)
            self.writeValue(ad.unitId)
            self.writeValue(ad.placeId)
            self.writeValue(ad.adFormat)
            self.writeValue(Double(ad.adRevenue) ?? 0)
            self.writeValue(ad.mediator)
            self.writeValue(ad.networkName)
        } else if let error = value as? NSError {
            self.writeByte(VALUE_AD_ERROR)
            self.writeValue(error.code)
            self.writeValue(error.localizedDescription)
        } else {
            super.writeValue(value)
        }
    }
}
