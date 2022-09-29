//
//  OCFlutterFaceIdentificationPlugin.m
//  flutter_face_identification
//
//  Created by liyuanbo on 2022/9/29.
//

#import "OCFlutterFaceIdentificationPlugin.h"
#import <DYRZSDK/DYRZInterface.h>
#import "MBProgressHUD.h"

@interface OCFlutterFaceIdentificationPlugin ()
@property(nonatomic, copy) NSString *latestLink;
@end

@implementation OCFlutterFaceIdentificationPlugin


+ (void)registerWithRegistrar:(nonnull NSObject<FlutterPluginRegistrar> *)registrar {
    OCFlutterFaceIdentificationPlugin* instance = [[OCFlutterFaceIdentificationPlugin alloc] init];
      
    FlutterMethodChannel *channel = [FlutterMethodChannel methodChannelWithName:@"flutter_face_identification" binaryMessenger: [registrar messenger]];
    [registrar addMethodCallDelegate:instance channel: channel];
    
    [registrar addApplicationDelegate:instance];
}

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  NSURL *url = (NSURL *)launchOptions[UIApplicationLaunchOptionsURLKey];
  self.latestLink = [url absoluteString];
  return YES;
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
            options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options {
  self.latestLink = [url absoluteString];
  return YES;
}

- (BOOL)application:(UIApplication *)application
    continueUserActivity:(NSUserActivity *)userActivity
      restorationHandler:(void (^)(NSArray *_Nullable))restorationHandler {
  if ([userActivity.activityType isEqualToString:NSUserActivityTypeBrowsingWeb]) {
    self.latestLink = [userActivity.webpageURL absoluteString];
    return YES;
  }
  return NO;
}

- (void)setLatestLink:(NSString *)latestLink
{
    _latestLink = latestLink;
    NSLog(@"openURL: %@",latestLink);
    
    // CA实名认证
    [DYRZInterface handleAliPayAuthOpenURL:[NSURL URLWithString:latestLink] completion:^(BOOL success, NSError * _Nonnull error) {
        if (success) {
            NSLog(@"认证成功");
        }
    }];
}

- (void)handleMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result
{
    if ([call.method isEqualToString:@"realNameAuth"]) {
        NSString * actionUrl = call.arguments[@"actionUrl"];
        NSString * iosAppUrlScheme = call.arguments[@"iosAppUrlScheme"];
        
        // URL业务系统向上海CA申请
        [DYRZInterface startAuthWithUrlString:actionUrl appUrlScheme:iosAppUrlScheme controller:[UIApplication sharedApplication].keyWindow.rootViewController userInfo:nil showLoading:^{
            MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
            hud.label.text = @"请您耐心等待";
            NSLog(@"正在加载");
        } dimissLoading:^{
            [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
            NSLog(@"加载完成");
        } success:^(NSDictionary * _Nonnull resultDic) {
            NSLog(@"认证成功");
            NSLog(@"认证成功result==========%@",resultDic);
            result(resultDic);
        } failure:^(NSError * _Nonnull error) {
            NSLog(@"认证失败");
            NSLog(@"==========%@",error);
            result([FlutterError errorWithCode:[NSString stringWithFormat:@"%ld",error.code] message:error.localizedDescription details:error]);
        }];
    }
}

@end
