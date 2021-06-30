//
//  FlutterAdManager.swift
//  eyu_open_sdk_flutter
//
//  Created by eric on 2021/6/29.
//

import UIKit

public class FlutterEYuAd {
    public var unitId = ""
    public var unitName = ""
    public var placeId = ""
    public var adFormat = ""
    public var adRevenue = ""
    public var mediator = ""
    public var networkName = ""
    public var error: NSError?
    
    public init() {
        
    }
}

public class FlutterAdManager {
    public static var instance: FlutterAdManager?
    let channel: FlutterMethodChannel
    
    init(channel: FlutterMethodChannel) {
        self.channel = channel
        FlutterAdManager.instance = self
    }
    
    public func onAdLoaded(_ eyuAd: FlutterEYuAd) {
        channel.invokeMethod("onAdEvent", arguments: ["ad": eyuAd, "eventName": "onAdLoaded"])
    }
    
    public func onAdReward(_ eyuAd: FlutterEYuAd) {
        channel.invokeMethod("onAdEvent", arguments: ["ad": eyuAd, "eventName": "onAdReward"])
    }
    
    public func onAdShowed(_ eyuAd: FlutterEYuAd) {
        channel.invokeMethod("onAdEvent", arguments: ["ad": eyuAd, "eventName": "onAdShowed"])
    }
    
    public func onAdClosed(_ eyuAd: FlutterEYuAd) {
        channel.invokeMethod("onAdEvent", arguments: ["ad": eyuAd, "eventName": "onAdClosed"])
    }
    
    public func onAdClicked(_ eyuAd: FlutterEYuAd) {
        channel.invokeMethod("onAdEvent", arguments: ["ad": eyuAd, "eventName": "onAdClicked"])
    }
    
    public func onAdLoadFailed(_ eyuAd: FlutterEYuAd) {
        channel.invokeMethod("onAdEvent", arguments: ["ad": eyuAd, "eventName": "onAdLoadFailed"])
    }
    
    public func onAdImpression(_ eyuAd: FlutterEYuAd) {
        channel.invokeMethod("onAdEvent", arguments: ["ad": eyuAd, "eventName": "onAdImpression"])
    }
    
    public func onAdRevenue(_ eyuAd: FlutterEYuAd) {
        channel.invokeMethod("onAdEvent", arguments: ["ad": eyuAd, "eventName": "onAdRevenuePained"])
    }
}
