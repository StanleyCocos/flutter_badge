#import "FlutterPushBadgePlugin.h"
#if __has_include(<flutter_push_badge/flutter_push_badge-Swift.h>)
#import <flutter_push_badge/flutter_push_badge-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_push_badge-Swift.h"
#endif

@implementation FlutterPushBadgePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  //[SwiftFlutterPushBadgePlugin registerWithRegistrar:registrar];
    
    FlutterMethodChannel* channel = [FlutterMethodChannel
        methodChannelWithName:@"flutter_push_badge"
              binaryMessenger:[registrar messenger]];
    FlutterPushBadgePlugin * instance = [[FlutterPushBadgePlugin alloc] init];
    [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {

    if ([@"getBadgeNumber" isEqualToString:call.method]) {
        NSInteger number = [UIApplication sharedApplication].applicationIconBadgeNumber;
        result([NSString stringWithFormat:@"%ld", number]);
    } else {
        NSString * number = call.arguments[@"number"];
        [UIApplication sharedApplication].applicationIconBadgeNumber = [number integerValue];
    }
}
@end
