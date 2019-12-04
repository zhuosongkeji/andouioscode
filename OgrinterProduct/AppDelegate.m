//
//  AppDelegate.m
//  OgrinterProduct
//
//  Created by wongshine on 2019/11/27.
//  Copyright © 2019 RXF. All rights reserved.
//


#import "AppDelegate.h"
#import <UMShare/UMShare.h>
#import <UMCommon/UMCommon.h>
#import "UMShareManege.h"
#import "IQKeyboardManager.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
//    KAdd_Observer(@"PushViewController", self, PushViewController, nil);
    //初始化友盟
    [UMConfigure initWithAppkey:UMKEY channel:nil];
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    self.customBar = [[CustomBarViewController alloc]initFrame:CustomBarTypeOne];
    self.window.rootViewController = self.customBar;
    
    
    [self.window makeKeyAndVisible];

    return YES;
}


//MARK:- 加载
-(void)initUMSDK{
    
    [UMShareManege setPlaform:UMSocialPlatformType_WechatSession appKey:WeChatAPPKEY appSecret:WeChatSecret redirectURL:nil];
    [UMShareManege setPlaform:UMSocialPlatformType_QQ appKey:QQAPPKEY appSecret:QQSecret redirectURL:nil];
    [UMShareManege setPlaform:UMSocialPlatformType_Sina appKey:SinaAPPKEY appSecret:SinaSecret redirectURL:SinaRedirectURL];
    
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    
}


//- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options {
//    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:options annotation:nil];
//    if (!result) {
//        // 其他如支付等SDK的回调
//    }
//    return result;
//}


//MARK:-支持所有iOS系统
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    
    return result;
}


//MARK:-
- (void)applicationWillResignActive:(UIApplication *)application {
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



@end
