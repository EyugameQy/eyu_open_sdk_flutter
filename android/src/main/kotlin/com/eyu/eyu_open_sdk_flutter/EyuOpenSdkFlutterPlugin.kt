package com.eyu.eyu_open_sdk_flutter

import androidx.annotation.NonNull
import com.eyu.opensdk.ad.EyuAdListener
import com.eyu.opensdk.ad.EyuAdManager
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.FlutterPlugin.FlutterPluginBinding
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.StandardMessageCodec

/** EyuOpenSdkFlutterPlugin */
class EyuOpenSdkFlutterPlugin : FlutterPlugin, ActivityAware, MethodChannel.MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel
    private lateinit var pluginBinding: FlutterPluginBinding
    private lateinit var activityBinding: ActivityPluginBinding
    private lateinit var adManager:AdManager
    var sdkInitializer:SdkInitializer? = null

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        if (call.method == "getPlatformVersion") {
            result.success("Android ${android.os.Build.VERSION.RELEASE}")
        } else if (call.method == "init") {
            sdkInitializer?.init(adManager.eyuAdListener)
        } else if (call.method == "isAdLoaded") {
            result.success(EyuAdManager.getInstance().isAdLoaded(call.argument<String>("adPlaceId")))
        } else if (call.method == "show") {
            result.success(EyuAdManager.getInstance().show(activityBinding.activity,call.argument<String>("adPlaceId")))
        }  else {
            result.notImplemented()
        }
    }

    companion object{
        fun registerSdkInitializer(
                engine: FlutterEngine, factoryId: String?, initializer: SdkInitializer?) {
            val plugin: EyuOpenSdkFlutterPlugin? = engine.plugins[EyuOpenSdkFlutterPlugin::class.java] as EyuOpenSdkFlutterPlugin?
            plugin?.sdkInitializer = initializer
        }
    }


    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        pluginBinding = flutterPluginBinding
    }


    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activityBinding = binding
        channel = MethodChannel(pluginBinding.binaryMessenger, "com.eyu.opensdk/ad")
        channel.setMethodCallHandler(this)
        adManager = AdManager(activityBinding.activity, pluginBinding.binaryMessenger)
        pluginBinding.platformViewRegistry.registerViewFactory("com.eyu.opensdk/ad/ad_widget",EyuSdkAdViewFactory(StandardMessageCodec.INSTANCE, adManager))
    }


    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        activityBinding = binding
    }

    override fun onDetachedFromActivity() {
    }

    override fun onDetachedFromActivityForConfigChanges() {
    }
    interface SdkInitializer {
        fun init(eyuAdListener: EyuAdListener)
    }
}
