//
//  LoginViewController.m
//  OgrinterProduct
//
//  Created by wongshine on 2019/11/27.
//  Copyright © 2019 RXF. All rights reserved.
//


#define login_login @"login/login_p"


#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "RetrievepsdViewController.h"
//#import "UMShareManege.h"
#import "userInfo.h"
#import <WechatOpenSDK/WXApi.h>
//#import "RetrievepsdViewController.h"


@interface LoginViewController ()


@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *phonePsword;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationController.title = @"用户登录";
    KAdd_Observer(@"getwxCode", self, loginRequestWX:, nil);
    // Do any additional setup after loading the view from its nib.
}


-(void)loadloginNetWork{
    
    [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:[NSString stringWithFormat:@"%@%@",API_BASE_URL_STRING,login_login] params:@{@"phone":self.phoneNumber.text,@"password":self.phonePsword.text} complement:^(ServerResponseInfo * _Nullable serverInfo) {
        if ([[serverInfo.response objectForKey:@"code"] intValue] == 200) {
            [HUDManager hidenHud];
            NSDictionary *dict = [serverInfo.response objectForKey:@"data"];
            userInfo *info = [[userInfo alloc]init];
            info.uid = [NSString stringWithFormat:@"%@",dict[@"id"]];
            info.uName = [NSString stringWithFormat:@"%@",dict[@"name"]];
            info.uPhone = [NSString stringWithFormat:@"%@",dict[@"mobile"]];
            info.uAcct = [NSString stringWithFormat:@"%@",dict[@"mobile"]];
            info.token = [NSString stringWithFormat:@"%@",dict[@"token"]];
            NSData *infoData = [NSKeyedArchiver archivedDataWithRootObject:info];
            [[NSUserDefaults standardUserDefaults] setObject:infoData forKey:@"infoData"];
            
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            /*NSData * data1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"Test"];
             Model * unmodel = [NSKeyedUnarchiver unarchiveObjectWithData:data1];*/
            
            [HUDManager showTextHud:loginSuccess];
            // 发送登录成功过得通知
            [[NSNotificationCenter defaultCenter] postNotificationName:@"loginOK" object:nil];
            // 退出登录界面
            [self dismissViewControllerAnimated:YES completion:nil];
            
        }
        NSLog(@"%@",serverInfo);
    }];
}

//MARK:- login
- (IBAction)login:(UIButton *)sender {
    KPreventRepeatClickTime(1)
    NSString *msg = nil;
//    
//    if (self.phoneNumber.text.length == 0) {
//        msg = phoneLength;
//    }else if (self.phoneNumber.text.length != 11 || ![NSObject  IsPhoneNumber:self.phoneNumber.text]){
//        msg = NphoneNumber;
//    }else if (self.phonePsword.text.length == 0){
//        msg = phonePwdLength;
//    }else{}
//
//    if (msg.length) {
//        [HUDManager showTextHud:msg];
//        return;
//    }
//    [HUDManager showTextHud:loading onView:self.view];
    
    [self performSelector:@selector(loadloginNetWork) withObject:nil afterDelay:1];
    // -- > 执行block
    if (self.loginBtnClickTask) {
        self.loginBtnClickTask();
    }
}


//MARK:- 用户注册
- (IBAction)register:(UIButton *)sender {
    KPreventRepeatClickTime(1)
    RegisterViewController *reg = [[RegisterViewController alloc]init];
    [self.navigationController pushViewController:reg animated:YES];
}


//MARK:- 找回密码
- (IBAction)retrievepsd:(UIButton *)sender {
    KPreventRepeatClickTime(1)
    RetrievepsdViewController *retrieve = [[RetrievepsdViewController alloc]init];
    retrieve.type = RetrievepsdViewControllerOne;
    [self.navigationController pushViewController:retrieve animated:YES];
}



//MARK:- 三方登录
- (IBAction)loginwithThrid:(UIButton *)sender {
//    //提示该功能暂未开放
//    [HUDManager showTextHud:@"该功能暂未开放"];
//    KPreventRepeatClickTime(1)
////    [self loginRequestWX];
//    if (![[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_WechatSession]) {
//        NSLog(@"");
//        [HUDManager showTextHud:@"请安装微信客户端后在尝试!"];
//        return;
//    }
//////
//    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_WechatSession currentViewController:self completion:^(id result, NSError *error) {
//
//        NSLog(@"%@result",result);
//
//        if (error) {
//            NSLog(@"%@",error);
//        } else {
//            UMSocialUserInfoResponse *resp = result;
//            // 授权信息
//            NSLog(@"Wechat uid: %@", resp.uid);
//            NSLog(@"Wechat openid: %@", resp.openid);
//            NSLog(@"Wechat unionid: %@", resp.unionId);
//            NSLog(@"Wechat accessToken: %@", resp.accessToken);
//            NSLog(@"Wechat refreshToken: %@", resp.refreshToken);
//            NSLog(@"Wechat expiration: %@", resp.expiration);
//            // 用户信息
//            NSLog(@"Wechat name: %@", resp.name);
//            NSLog(@"Wechat iconurl: %@", resp.iconurl);
//            NSLog(@"Wechat gender: %@", resp.unionGender);
//            // 第三方平台SDK源数据
//            NSLog(@"Wechat originalResponse: %@", resp.originalResponse);
//        }
//
//    }];
    
    if([WXApi isWXAppInstalled]){//判断用户是否已安装微信App
        
        SendAuthReq *req = [[SendAuthReq alloc] init];
        req.state = @"wx_oauth_authorization_state";//用于保持请求和回调的状态，授权请求或原样带回
        req.scope = @"snsapi_userinfo";//授权作用域：获取用户个人信息
        //唤起微信
        [WXApi sendReq:req completion:nil];
    }else{
        [HUDManager showTextHud:@"未安装微信应用或版本过低"];
    }
}


- (void)loginRequestWX:(NSNotification *)not
{
    NSDictionary *dict = not.userInfo;
    
    NSData * data1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"infoData"];
    userInfo * unmodel = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
        param[@"code"] = dict[@"code"];
       [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:@"http://andou.zhuosongkj.com/index.php/api/login/wxlogin" params:param complement:^(ServerResponseInfo * _Nullable serverInfo) {
           if ([serverInfo.response[@"code"] integerValue] == 200) {
               
               [[NSNotificationCenter defaultCenter] postNotificationName:@"loginOK" object:nil];
               [self dismissViewControllerAnimated:YES completion:nil];
               
           }else if ([serverInfo.response[@"code"] integerValue] == 203){
               
               NSDictionary *dict1 = serverInfo.response[@"data"];
               RetrievepsdViewController *retr = [[RetrievepsdViewController alloc]init];
               retr.wxdict = @{@"avator":dict1[@"avator"],@"openid":dict1[@"openid"],@"name":dict1[@"name"]};
               retr.type = RetrievepsdViewControllerTwo;
               retr.successBlock = ^(BOOL idx) {
                   if (idx == YES) {
                       [[NSNotificationCenter defaultCenter] postNotificationName:@"loginOK" object:nil];
                       [self dismissViewControllerAnimated:YES completion:nil];
                   }
               };
               
               [self.navigationController pushViewController:retr animated:YES];
           }
           NSLog(@"%@",serverInfo.response[@"data"]);
       }];
}





@end
