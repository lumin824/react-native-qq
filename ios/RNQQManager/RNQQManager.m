//
//  RNQQManager.m
//  RNQQ
//
//  Created by 陆民 on 16/5/6.
//  Copyright © 2016年 lumin. All rights reserved.
//

#import "RNQQManager.h"
#import "RCTConvert.h"
#import "RCTBridge.h"
#import "RCTUtils.h"

//#import <TencentOpenAPI/TencentOAuth.h>
//#import <TencentOpenAPI/TencentOAuthObject.h>
//#import <TencentOpenAPI/QQApiInterface.h>
//#import <TencentOpenAPI/QQApiInterfaceObject.h>

@interface RNQQManager(){
    //TencentOAuth* _tencent;
}
@end

@implementation RNQQManager

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
