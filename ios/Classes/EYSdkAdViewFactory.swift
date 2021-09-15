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
        let params = args as? [String: String] ?? [:]
        let placeId = params["placeId"]
        let page = params["page"]
        let identifier = params["identifier"] ?? "default"
        let adType = delegate?.adTypeFor(placeId: placeId ?? "")
        if adType == "bannerAd" {
            return FlutterBannerAd(flutterPluginDelegate: delegate, placeId: placeId ?? "")
        } else if adType == "nativeAd" {
            return FlutterNativeAd(flutterPluginDelegate: delegate, placeId: placeId ?? "", page: page ?? "", identifier: identifier)
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
    let page: String
    let identifier: String
    
    init(flutterPluginDelegate: SwiftEyuOpenSdkFlutterPluginDelegate?, placeId: String, page: String, identifier: String) {
        delegate = flutterPluginDelegate
        self.placeId = placeId
        self.page = page
        self.identifier = identifier
    }
    
    func view() -> UIView {
        return delegate?.getNativeView(placeId: placeId, page: page, identifier: identifier) ?? UIView()
    }
}
