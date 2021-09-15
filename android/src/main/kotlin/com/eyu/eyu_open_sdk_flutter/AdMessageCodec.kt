package com.eyu.eyu_open_sdk_flutter

import android.content.Context
import com.eyu.opensdk.ad.EyuAd
import com.eyu.opensdk.ad.base.model.LoadAdError
import io.flutter.plugin.common.StandardMessageCodec
import java.io.ByteArrayOutputStream

internal class AdMessageCodec(val context: Context) : StandardMessageCodec() {
    companion object {
        private const val VALUE_AD = 128.toByte()
        private const val VALUE_AD_ERROR = 129.toByte()
    }

    override fun writeValue(stream: ByteArrayOutputStream, value: Any) {
        if (value is EyuAd) {
            stream.write(VALUE_AD.toInt())
            val request = value
            writeValue(stream, request.unitId)
            writeValue(stream, request.placeId)
            writeValue(stream, request.adFormat.label)
            writeValue(stream, request.adRevenue)
            writeValue(stream, request.mediator)
            writeValue(stream, request.networkName)
        } else if (value is LoadAdError) {
            stream.write(VALUE_AD_ERROR.toInt())
            val error = value
            writeValue(stream, error.code)
            writeValue(stream, error.displayMessage)
        } else {
            super.writeValue(stream, value)
        }
    }


}