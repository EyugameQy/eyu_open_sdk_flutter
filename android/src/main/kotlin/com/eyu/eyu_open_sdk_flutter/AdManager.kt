package com.eyu.eyu_open_sdk_flutter

import android.app.Activity
import com.eyu.opensdk.ad.EyuAd
import com.eyu.opensdk.ad.EyuAdListener
import com.eyu.opensdk.ad.base.model.LoadAdError
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.StandardMethodCodec
import java.util.*

class AdManager(var activity: Activity, binaryMessenger: BinaryMessenger) {
    private val channel: MethodChannel
    val eyuAdListener: EyuAdListener

    init {
        val methodCodec = StandardMethodCodec(AdMessageCodec(activity))
        channel = MethodChannel(binaryMessenger, "com.eyu.opensdk/ad", methodCodec)
        eyuAdListener = object: EyuAdListener {


            override fun onAdLoaded(p0: EyuAd) {
                onAdEvent(p0,"onAdLoaded")
            }

            override fun onAdShowed(p0: EyuAd) {
                onAdEvent(p0,"onAdShowed")
            }

            override fun onAdReward(p0: EyuAd) {
                onAdEvent(p0,"onAdReward")
            }
            override fun onAdClosed(p0: EyuAd) {
                onAdEvent(p0,"onAdClosed")
            }

            override fun onAdClicked(p0: EyuAd) {
                onAdEvent(p0,"onAdClicked")
            }

            override fun onDefaultNativeAdClicked(p0: EyuAd) {
                onAdEvent(p0,"onDefaultNativeAdClicked")
            }

            override fun onAdLoadFailed(p0: EyuAd, p1: LoadAdError) {
                onAdFailedToLoad(p0,p1)
            }

            override fun onImpression(p0: EyuAd) {
                onAdEvent(p0,"onAdImpression")
            }

            override fun onAdRevenuePained(p0: EyuAd) {
                onAdEvent(p0,"onAdRevenuePained")
            }

            override fun onAdShowFailed(p0: EyuAd) {
                onAdEvent(p0,"onAdShowFailed")
            }

        }
    }

    fun onAdEvent(ad: EyuAd,eventName:String) {
        val arguments: MutableMap<Any, Any> = HashMap()
        arguments["ad"] = ad
        arguments["eventName"] = eventName
        invokeOnAdEvent(arguments)
    }

    fun onAdFailedToLoad(ad: EyuAd, error: LoadAdError) {
        val arguments: MutableMap<Any, Any> = HashMap()
        arguments["ad"] = ad
        arguments["error"] = error
        arguments["eventName"] = "onAdLoadFailed"
        invokeOnAdEvent(arguments)
    }

    /** Invoke the method channel using the UI thread. Otherwise the message gets silently dropped.  */
    private fun invokeOnAdEvent(arguments: Map<Any, Any>) {
        activity.runOnUiThread { channel.invokeMethod("onAdEvent", arguments) }
    }


}