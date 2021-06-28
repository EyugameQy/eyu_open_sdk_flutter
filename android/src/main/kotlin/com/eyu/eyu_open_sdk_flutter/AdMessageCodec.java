
package com.eyu.eyu_open_sdk_flutter;


import android.content.Context;

import androidx.annotation.NonNull;

import com.eyu.opensdk.ad.EyuAd;
import com.eyu.opensdk.ad.base.model.LoadAdError;

import java.io.ByteArrayOutputStream;

import io.flutter.plugin.common.StandardMessageCodec;

class AdMessageCodec extends StandardMessageCodec {
  private static final byte VALUE_AD = (byte) 128;
  private static final byte VALUE_AD_ERROR = (byte) 129;

  @NonNull
  final Context context;

  AdMessageCodec(@NonNull Context context) {
    this.context = context;
  }

  @Override
  protected void writeValue(ByteArrayOutputStream stream, Object value) {
    if (value instanceof EyuAd) {
      stream.write(VALUE_AD);
      final EyuAd request = (EyuAd) value;
      writeValue(stream, request.getUnitId());
      writeValue(stream, request.getPlaceId());
      writeValue(stream, request.getAdFormat().getLabel());
      writeValue(stream, request.getAdRevenue());
      writeValue(stream, request.getMediator());
      writeValue(stream, request.getNetworkName());
    }else if(value instanceof LoadAdError){
      stream.write(VALUE_AD_ERROR);
      final LoadAdError error = (LoadAdError) value;
      writeValue(stream, error.getCode());
      writeValue(stream, error.getDisplayMessage());
    }else {
      super.writeValue(stream, value);
    }
  }

}
