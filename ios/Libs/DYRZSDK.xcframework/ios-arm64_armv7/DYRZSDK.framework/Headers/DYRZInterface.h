//
//  DYRZInterface.h
//  DYRZSDK
//
//  Created by windtersharp on 2021/6/30.
//  Copyright © 2021 windter@126.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface DYRZInterface : NSObject

/// SDK版本号
+ (NSString *)version;

/// 唤起SDK页面
/// @param urlString 应用方向上海CA申请初始化页面URl
/// @param appUrlScheme 用于App之间跳转（支付宝等需要），建议配置
/// @param controller 弹出页面的视图控制器
/// @param userInfo 自定义信息：name":"XXX", "idNumber":"XXX", "phone":"XXX"，"extra"："XXX"
/// @param showLoading 配置初始化页面加载过程动画
/// @param dismissLoading 消失初始化页面加载过程动画
/// @param success 成功回调
/// @param failure 失败回调
+ (void)startAuthWithUrlString:(NSString *)urlString
                  appUrlScheme:(NSString *)appUrlScheme
                    controller:(UIViewController *)controller
                      userInfo:(nullable NSDictionary *)userInfo
                   showLoading:(dispatch_block_t)showLoading
                 dimissLoading:(dispatch_block_t)dismissLoading
                       success:(void(^)(NSDictionary *result))success
                       failure:(void(^)(NSError *error))failure;

/// 处理支付宝认证回调
/// @param url 回调地址
/// @param completion 完成回调
+ (void)handleAliPayAuthOpenURL:(NSURL *)url  completion:(void(^)(BOOL success, NSError *error))completion;


@end

NS_ASSUME_NONNULL_END
