//
//  HuiYanSDKKit.h
//  HuiYanSDK
//
//  Created by v_clvchen on 2020/8/28.
//  Copyright © 2020 tencent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <HuiYanSDK/AuthConfig.h>

NS_ASSUME_NONNULL_BEGIN

/**
 HuiYanSDKKit 对外接口
 */
@interface HuiYanSDKKit : NSObject

/// SDKKIt处理成功回调接口
/// @param resultInfo 会根据不同的工作模式返回对应下的成功信息（一般都是网络回包json字段）
/// @param reserved 预留位
typedef void (^TXYSDKKitProcessSucceedBlock)(id _Nonnull resultInfo, id _Nullable reserved);
/// SDKKIt处理失败回调接口
/// @param error 处理过程中触发的异常错误
/// @param reserved 预留位
typedef void (^TXYSDKKitProcessFailedBlock)(NSError *_Nonnull error, id _Nullable reserved);

/// 用户设置主动刷新 返回FaceIDToken
typedef NSString *_Nullable(^FaceIdTokenCreateFunction)(void);

/// 获取SDK实例
+ (nonnull instancetype)sharedInstance;

/// 获取SDK版本信息
- (NSString *_Nonnull)sdkVersion;

/// 清理SDK资源
+ (void)clearInstance;

/// 启动SDK模块，运行带有UI界面的功能识别模块
/// @note 请在View加载完毕后调用该接口
/// @note 请在调用loadSDKConfigWith后再调用此方法
/// @param authConfig SDK需要运行配置
/// @param onProcessSucceed 识别成功回调
/// @param onProcessFailed 识别失败回调
- (void)startHuiYanAuthWithAuthConfig:(AuthConfig * _Nonnull)authConfig
          withProcessSucceedBlock:(TXYSDKKitProcessSucceedBlock _Nonnull)onProcessSucceed
           withProcessFailedBlock:(TXYSDKKitProcessFailedBlock _Nonnull)onProcessFailed;

/// 设置 FaceIdToken
///@param onFaceIdTokenCreateFunction 获取FaceIdToken block
- (int)setFaceIdTokenCreateFunction:(FaceIdTokenCreateFunction _Nonnull)onFaceIdTokenCreateFunction;
@end

NS_ASSUME_NONNULL_END
