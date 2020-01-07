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
#import "UMShareManege.h"
#import "userInfo.h"


@interface LoginViewController ()


@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *phonePsword;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationController.title = @"用户登录";
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
    
    if (self.phoneNumber.text.length == 0) {
        msg = phoneLength;
    }else if (self.phoneNumber.text.length != 11 || ![NSObject  IsPhoneNumber:self.phoneNumber.text]){
        msg = NphoneNumber;
    }else if (self.phonePsword.text.length == 0){
        msg = phonePwdLength;
    }else{}

    if (msg.length) {
        [HUDManager showTextHud:msg];
        return;
    }
    [HUDManager showTextHud:loading onView:self.view];
    
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
    [self.navigationController pushViewController:retrieve animated:YES];
}



//MARK:- 三方登录
- (IBAction)loginwithThrid:(UIButton *)sender {
    //提示该功能暂未开放
    KPreventRepeatClickTime(1)
    
    if (![[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_WechatSession]) {
        [HUDManager showTextHud:@"请安装微信客户端后在尝试!"];
        return;
    }
    
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_WechatSession currentViewController:self completion:^(id result, NSError *error) {
        
        if (error) {
            NSLog(@"%@",error);
        } else {
            UMSocialUserInfoResponse *resp = result;
            // 授权信息
            NSLog(@"Wechat uid: %@", resp.uid);
            NSLog(@"Wechat openid: %@", resp.openid);
            NSLog(@"Wechat unionid: %@", resp.unionId);
            NSLog(@"Wechat accessToken: %@", resp.accessToken);
            NSLog(@"Wechat refreshToken: %@", resp.refreshToken);
            NSLog(@"Wechat expiration: %@", resp.expiration);
            // 用户信息
            NSLog(@"Wechat name: %@", resp.name);
            NSLog(@"Wechat iconurl: %@", resp.iconurl);
            NSLog(@"Wechat gender: %@", resp.unionGender);
            // 第三方平台SDK源数据
            NSLog(@"Wechat originalResponse: %@", resp.originalResponse);
        }
        
    }];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
