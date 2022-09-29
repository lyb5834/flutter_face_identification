//
//  AuthConfig.h
//  HuiYanSDK
//
//  Created by v_clvchen on 2020/9/7.
//  Copyright © 2020 tencent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <HuiYanSDK/CustomerConfig.h>

NS_ASSUME_NONNULL_BEGIN
/**
 sdk配置类
 */
@interface AuthConfig : NSObject

///licence 路径
@property (strong, nonatomic) NSString *licencePath;
///客户自定义设置
@property (strong, nonatomic) CustomerConfig *customerConfig;

@end

NS_ASSUME_NONNULL_END
