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
@property(nonatomic, copy) NSString *faceLink;
@end

@implementation OCFlutterFaceIdentificationPlugin

static id _instance;

+ (OCFlutterFaceIdentificationPlugin *)sharedInstance {
  if (_instance == nil) {
    _instance = [[OCFlutterFaceIdentificationPlugin alloc] init];
  }
  return _instance;
}

+ (void)registerWithRegistrar:(nonnull NSObject<FlutterPluginRegistrar> *)registrar {
    OCFlutterFaceIdentificationPlugin* instance = [OCFlutterFaceIdentificationPlugin sharedInstance];
      
    FlutterMethodChannel *channel = [FlutterMethodChannel methodChannelWithName:@"flutter_face_identification" binaryMessenger: [registrar messenger]];
    [registrar addMethodCallDelegate:instance channel: channel];
    
//     [registrar addApplicationDelegate:instance];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    self.faceLink = [url absoluteString];
    
    return YES;
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
            options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options {
    self.faceLink = [url absoluteString];
    return YES;
}

- (void)setFaceLink:(NSString *)faceLink
{
    static NSString *key = @"faceLink";
    
    [self willChangeValueForKey:key];
    _faceLink = [faceLink copy];
    [self didChangeValueForKey:key];
    
    NSLog(@"openURL: %@",faceLink);
    
    // CA实名认证
    [DYRZInterface handleAliPayAuthOpenURL:[NSURL URLWithString:faceLink] completion:^(BOOL success, NSError * _Nonnull error) {
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
