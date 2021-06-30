#import "EyuOpenSdkFlutterPlugin.h"
#if __has_include(<eyu_open_sdk_flutter/eyu_open_sdk_flutter-Swift.h>)
#import <eyu_open_sdk_flutter/eyu_open_sdk_flutter-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "eyu_open_sdk_flutter-Swift.h"
#endif

@implementation EyuOpenSdkFlutterPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftEyuOpenSdkFlutterPlugin registerWithRegistrar:registrar];
}

@end
