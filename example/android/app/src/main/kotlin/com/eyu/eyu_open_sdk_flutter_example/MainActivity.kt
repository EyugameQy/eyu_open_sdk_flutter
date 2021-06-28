package com.eyu.eyu_open_sdk_flutter_example

import android.util.Log
import android.widget.Toast
import com.eyu.eyu_open_sdk_flutter.EyuOpenSdkFlutterPlugin
import com.eyu.opensdk.ad.AdConfig
import com.eyu.opensdk.ad.EyuAdListener
import com.eyu.opensdk.ad.EyuAdManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity: FlutterFragmentActivity() {

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        EyuOpenSdkFlutterPlugin.registerSdkInitializer(flutterEngine,"SdkInitializer",object:EyuOpenSdkFlutterPlugin.SdkInitializer{
            override fun init(eyuAdListener: EyuAdListener) {
                val adConfig = AdConfig()
                adConfig.isDebugMode = false
                adConfig.setAdPlaceConfigResource(this@MainActivity, R.raw.ad_setting)
                adConfig.setAdKeyConfigResource(this@MainActivity, R.raw.ad_key_setting)
                adConfig.setAdGroupConfigResource(this@MainActivity, R.raw.ad_cache_setting2)
                EyuAdManager.getInstance().config(this@MainActivity, adConfig, eyuAdListener)
            }

        })
    }

}
