//
//  OCFlutterFaceIdentificationPlugin.h
//  flutter_face_identification
//
//  Created by liyuanbo on 2022/9/29.
//

#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>

NS_ASSUME_NONNULL_BEGIN

@interface OCFlutterFaceIdentificationPlugin : NSObject
<
FlutterPlugin
>

+ (void)registerWithRegistrar:(nonnull NSObject<FlutterPluginRegistrar> *)registrar;

@end

NS_ASSUME_NONNULL_END
