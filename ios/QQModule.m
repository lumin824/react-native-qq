
#import "RCTBridgeModule.h"

#import "RCTConvert.h"
#import "RCTBridge.h"
#import "RCTUtils.h"

#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/TencentOAuthObject.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/QQApiInterfaceObject.h>

@interface QQModule: NSObject<RCTBridgeModule,TencentSessionDelegate>{
    TencentOAuth* _tencentOAuth;
}

@property(nonatomic, copy) RCTPromiseResolveBlock loginResolve;
@property(nonatomic, copy) RCTPromiseRejectBlock loginReject;
@end

@implementation QQModule

- (instancetype) init{
    self = [super init];
    if(self){
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleOpenURL:) name:@"RCTOpenURLNotification" object:nil];
        
        NSString* appId = nil;
        NSArray* list = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"CFBundleURLTypes"];
        for(NSDictionary* item in list){
            NSString* name = item[@"CFBundleURLName"];
            if([name isEqualToString:@"qq"])
            {
                NSArray* schemes = item[@"CFBundleURLSchemes"];
                if(schemes.count > 0){
                    appId = [schemes[0] substringFromIndex:@"tencent".length];
                    break;
                }
            }
        }
        
        _tencentOAuth = [[TencentOAuth alloc] initWithAppId:appId andDelegate:self];
    }

    
    return self;
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)handleOpenURL:(NSNotification *)note
{
    NSDictionary *userInfo = note.userInfo;
    NSString *url = userInfo[@"url"];
    if ([TencentOAuth HandleOpenURL:[NSURL URLWithString:url]]) {
    }
    else {
        [QQApiInterface handleOpenURL:[NSURL URLWithString:url] delegate:self];
    }
}

RCT_EXPORT_MODULE();

- (dispatch_queue_t)methodQueue
{
  return dispatch_get_main_queue();
}

RCT_EXPORT_METHOD(login:(NSString*)scopes
                  resolve:(RCTPromiseResolveBlock)resolve
                  reject:(RCTPromiseRejectBlock)reject) {
    NSArray *scopeArray = nil;
    if (scopes && scopes.length) {
        scopeArray = [scopes componentsSeparatedByString:@","];
    }
    if (scopeArray == nil) {
        scopeArray = @[@"get_user_info", @"get_simple_userinfo"];
    }
    self.loginResolve = resolve;
    self.loginReject = reject;
    [_tencentOAuth authorize:scopeArray];
}

- (void)tencentDidLogin
{
    if(self.loginResolve){
        self.loginResolve(_tencentOAuth.openId);
        self.loginResolve = nil;
        self.loginReject = nil;
    }
}

- (void)tencentDidNotLogin:(BOOL)cancelled
{
    if(self.loginReject){
        self.loginReject(@"cancel",@"cancel", nil);
        self.loginResolve = nil;
        self.loginReject = nil;
    }
}

- (void)tencentDidNotNetWork
{
    if(self.loginReject){
        self.loginReject(@"notnet",@"notnet", nil);
        self.loginResolve = nil;
        self.loginReject = nil;
    }
}

@end
