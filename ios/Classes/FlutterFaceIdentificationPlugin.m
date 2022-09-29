#import "FlutterFaceIdentificationPlugin.h"
#import "OCFlutterFaceIdentificationPlugin.h"

@implementation FlutterFaceIdentificationPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [OCFlutterFaceIdentificationPlugin registerWithRegistrar:registrar];
}
@end
