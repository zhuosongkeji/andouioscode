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
//#import "LoginViewController.h"
#import <WechatOpenSDK/WXApi.h>
#import "MSLaunchView.h"


@interface AppDelegate ()<WXApiDelegate,MSLaunchViewDeleagte>{
    MSLaunchView *_launchView;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
//    KAdd_Observer(@"PushViewController", self, PushViewController, nil);
    
//    初始化友盟
    [UMConfigure initWithAppkey:UMKEY channel:nil];
//    [UMConfigure setLogEnabled:NO];
    [self initUMSDK];

    
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = KSRGBA(240, 240, 240, 1);
    
    if (@available(iOS 11.0, *)){
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }
    
    self.customBar = [[CustomBarViewController alloc]initFrame:CustomBarTypeOne];
    self.window.rootViewController = self.customBar;
    
    
//    LoginViewController *login = [[LoginViewController alloc]init];
//    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:login];
//    self.window.rootViewController = nav;
    
    [WXApi registerApp:WeChatAPPKEY universalLink:@"https://www.baidu.com/"];
    
    [self.window makeKeyAndVisible];
    [self setupGuide];
    return YES;
}

#pragma mark -- guide
- (void)setupGuide
{
    if ([MSLaunchView isFirstLaunch]) {
    
    NSArray *imageNameArray = @[@"guide2_",@"guide1_",@"guide3_"];
    CGRect rt = CGRectMake(KSCREEN_WIDTH * 0.3 + KSCREEN_WIDTH + KSCREEN_WIDTH, KSCREEN_HEIGHT*0.8, KSCREEN_WIDTH*0.4, KSCREEN_HEIGHT*0.06);
    MSLaunchView *launchView = [MSLaunchView launchWithImages:imageNameArray guideFrame:rt gImage:[UIImage imageNamed:@""] isScrollOut:NO];
    
    // 立即体验按钮
    launchView.guideTitle = @"立即体验";
    launchView.guideTitleColor = KSRGBA(251, 60, 110, 1);
    launchView.guideTitleFont = [UIFont systemFontOfSize:18];
    // 跳过按钮自定义属性
    launchView.skipTitle = @"跳过";
    launchView.skipTitleColor = [UIColor whiteColor];
    launchView.skipTitleFont = [UIFont systemFontOfSize:15];
    launchView.skipBackgroundColor = [UIColor grayColor];
    launchView.skipBackgroundImage = [UIImage imageNamed:@""];
    // PageControl自定义属性
    launchView.pageDotColor = [UIColor redColor];
    launchView.currentPageDotColor = [UIColor yellowColor];
    launchView.textFont = [UIFont systemFontOfSize:9 weight:UIFontWeightBold];
    launchView.textColor = [UIColor blackColor];
    launchView.dotsIsSquare = NO;
    launchView.spacingBetweenDots = 15;
    launchView.delegate = self;

    launchView.lastDotsIsHidden = YES;//最后一个页面时是否隐藏PageControl 默认为NO
    launchView.pageDotImage = [UIImage imageNamed:@"guideNormal"];
    launchView.currentPageDotImage = [UIImage imageNamed:@"guideSelcted"];
    launchView.loadFinishBlock = ^(MSLaunchView * _Nonnull launchView) {
          NSLog(@"广告加载完成了");
      };
    _launchView = launchView;
    }
}

-(void)launchViewLoadFinish:(MSLaunchView *)launchView{
    NSLog(@"代理方法进入======广告加载完成了");
}


//MARK:- 加载
-(void)initUMSDK{

    [UMShareManege setPlaform:UMSocialPlatformType_WechatSession appKey:WeChatAPPKEY appSecret:WeChatSecret redirectURL:@"https://"];
    [UMShareManege setPlaform:UMSocialPlatformType_QQ appKey:QQAPPKEY appSecret:QQSecret redirectURL:nil];
    [UMShareManege setPlaform:UMSocialPlatformType_Sina appKey:SinaAPPKEY appSecret:SinaSecret redirectURL:SinaRedirectURL];

}


//MARK:-WX支付成功 回调
-(void)onResp:(BaseResp*)resp{
    if ([resp isKindOfClass:[PayResp class]]){
        PayResp*response=(PayResp*)resp;
        switch(response.errCode){
            case WXSuccess:
                NSLog(@"支付成功");
                KPost_Notify(@"paySuccess", nil, nil);
                break;
            default:
                NSLog(@"支付失败，retcode=%d",resp.errCode);
                break;
        }
    }
    if ([resp isMemberOfClass:[SendAuthResp class]])  {
        SendAuthResp *aresp = (SendAuthResp *)resp;
        if (aresp.errCode != 0 ) {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"授权失败");
            });
            return;
        }
        //授权成功获取 OpenId
        NSString *code = aresp.code;
        KPost_Notify(@"getwxCode", nil, @{@"code":code});

    }
}


//- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options {
//
//    //    NSLog(@"options: %@", options);
//    NSLog(@"URL scheme:%@", [url scheme]);
//    NSLog(@"URL query: %@", [url query]);
//
//    // 提示并展示query
//    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"打开URL Scheme成功"
//                                                        message:[url query]
//                                                       delegate:nil
//                                              cancelButtonTitle:@"确定"
//                                              otherButtonTitles:nil];
//    [alertView show];
//
//    return YES;
//}


//MARK:-支持所有iOS系统
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
        // 其他如支付等SDK的回调
    if ([url.host isEqualToString:@"pay"]) {
        NSLog(@"%@------------",url);
        NSLog(@"%@",url.host);
        return [WXApi handleOpenURL:url delegate:(id<WXApiDelegate>)self];
    }
    
    if ([url.host isEqualToString:@"oauth"]){//微信登录
        return [WXApi handleOpenURL:url delegate:self];
    }
    
    return YES;
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


//MARK: 地区加载数据
-(void)loadAreaDatawithPlist{
    
}



@end
