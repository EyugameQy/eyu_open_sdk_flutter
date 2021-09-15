package com.eyu.eyu_open_sdk_flutter

import FlutterAd
import android.content.Context
import android.view.View
import com.eyu.opensdk.ad.EyuAdManager
import com.eyu.opensdk.ad.base.adapter.BannerAdAdapter
import io.flutter.plugin.platform.PlatformView

class FlutterBannerAd(ctx: Context, var placeId: String): FlutterAd(),PlatformView, FlutterDestroyableAd{
    private var bannerAdAdapter:BannerAdAdapter? = null
    private var context:Context = ctx

    init {
        bannerAdAdapter = EyuAdManager.getInstance().getBannerAdapter(placeId)
    }

    override fun getView(): View {
        if(bannerAdAdapter == null){
            EyuAdManager.getInstance().getBannerAdapter(placeId)
        }
        return bannerAdAdapter?.adView ?: View(context)
    }

    fun valid():Boolean{
        return bannerAdAdapter?.isAdLoaded ?: false;
    }

    override fun dispose() {
    }

    override fun destroy() {
        bannerAdAdapter?.destroy()

    }
}