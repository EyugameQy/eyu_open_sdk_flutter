//
//  EYSdkAdViewFactory.swift
//  eyu_open_sdk_flutter
//
//  Created by eric on 2021/7/1.
//

import UIKit

class EYSdkAdViewFactory: NSObject, FlutterPlatformViewFactory {
    weak var delegate: SwiftEyuOpenSdkFlutterPluginDelegate?
    
    init(flutterPluginDelegate: SwiftEyuOpenSdkFlutterPluginDelegate?) {
        delegate = flutterPluginDelegate
    }

    func create(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) -> FlutterPlatformView {
        let placeId = args as? String
        let adType = delegate?.adTypeFor(placeId: placeId ?? "")
        if adType == "bannerAd" {
            return FlutterBannerAd(flutterPluginDelegate: delegate, placeId: placeId ?? "")
        } else if adType == "nativeAd" {
            return FlutterNativeAd(flutterPluginDelegate: delegate, placeId: placeId ?? "")
        }
        return FlutterBannerAd(flutterPluginDelegate: delegate, placeId:"")
    }
    
    func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
        return FlutterStandardMessageCodec.sharedInstance()
    }
}

class FlutterBannerAd: NSObject, FlutterPlatformView {
    weak var delegate: SwiftEyuOpenSdkFlutterPluginDelegate?
    let placeId: String
    
    init(flutterPluginDelegate: SwiftEyuOpenSdkFlutterPluginDelegate?, placeId: String) {
        delegate = flutterPluginDelegate
        self.placeId = placeId
    }
    
    func view() -> UIView {
        return delegate?.getBannerView(placeId: placeId) ?? UIView()
    }
}

class FlutterNativeAd: NSObject, FlutterPlatformView {
    weak var delegate: SwiftEyuOpenSdkFlutterPluginDelegate?
    let placeId: String
    
    init(flutterPluginDelegate: SwiftEyuOpenSdkFlutterPluginDelegate?, placeId: String) {
        delegate = flutterPluginDelegate
        self.placeId = placeId
    }
    
    func view() -> UIView {
        return delegate?.getNativeView(placeId: placeId) ?? UIView()
    }
}
