//
//  CustomerConfig.h
//  HuiYanSDK
//
//  Created by v_clvchen on 2021/1/20.
//  Copyright © 2021 tencent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomerConfig : NSObject

//核身提示
@property (strong, nonatomic) NSString *authTips;
//核身提示文字颜色
@property (strong, nonatomic) UIColor *authTipsTxtColor;

@end

NS_ASSUME_NONNULL_END
