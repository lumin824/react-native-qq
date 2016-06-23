
#import "RCTBridgeModule.h"

#import "RCTConvert.h"
#import "RCTBridge.h"
#import "RCTUtils.h"

//#import <TencentOpenAPI/TencentOAuth.h>
//#import <TencentOpenAPI/TencentOAuthObject.h>
//#import <TencentOpenAPI/QQApiInterface.h>
//#import <TencentOpenAPI/QQApiInterfaceObject.h>

@interface RNQQModule: NSObject<RCTBridgeModule>{
    //TencentOAuth* _tencent;
}
@end

@implementation RNQQModule

- (instancetype) init{
    self = [super init];
    
    //_tencent = [[TencentOAuth alloc] initWithAppId:@"" andDelegate:self];
    return self;
}

RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(login:(NSString*)scopes callback:(RCTResponseSenderBlock) callback) {
    callback(@[@"error"]);
}

@end
