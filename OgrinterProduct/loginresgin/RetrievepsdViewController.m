//
//  RetrievepsdViewController.m
//  OgrinterProduct
//
//  Created by wongshine on 2019/11/27.
//  Copyright © 2019 RXF. All rights reserved.
//


#define login_forget @"login/forget"
#define send_msg @"login/send"

#define login_bindmobile @"login/bindmobile"//绑定手机号码

#import "RetrievepsdViewController.h"

@interface RetrievepsdViewController ()

{
    BOOL isbindmobile;//是否绑定
    
}

@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;

@property (weak, nonatomic) IBOutlet UITextField *msgCode;

@property (weak, nonatomic) IBOutlet UITextField *NphonePsd;
@property (weak, nonatomic) IBOutlet UIButton *codeBrn;

@property (weak, nonatomic) IBOutlet UIButton *submintBtns;

@end

@implementation RetrievepsdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.title = @"找回密码";
    
    if (self.type == RetrievepsdViewControllerOne) {
        
    }else if (self.type == RetrievepsdViewControllerTwo){
        self.NphonePsd.placeholder = @"请输入密码";
        [self.submintBtns setTitle:@"确认绑定" forState:0];
    }
    // Do any additional setup after loading the view from its nib.
}


//MARK:- send msg
-(void)loadmsgNetWork{
    
    [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:[NSString stringWithFormat:@"%@%@",API_BASE_URL_STRING,send_msg] params:@{@"phone":self.phoneNumber.text,@"type":@"0"} complement:^(ServerResponseInfo * _Nullable serverInfo) {
        if ([[serverInfo.response objectForKey:@"code"] intValue] == 200) {
            [HUDManager showTextHud:sendCode];
            [NSObject CutTimedowButton:self.codeBrn Time:TIMECOUNT];
        }
    }];
}


//MARK:- 找回密码
-(void)loadforgetNetWork{
    
    [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:[NSString stringWithFormat:@"%@%@",API_BASE_URL_STRING,login_forget] params:@{@"phone":self.phoneNumber.text,@"verify":self.msgCode.text,@"new_password":self.NphonePsd.text} complement:^(ServerResponseInfo * _Nullable serverInfo) {
        if ([[serverInfo.response objectForKey:@"code"] intValue] == 200) {
            [HUDManager hidenHud];
            
            [HUDManager showTextHud:@"密码修改成功"];
            
            [self performSelector:@selector(popVc) withObject:nil afterDelay:1];
            
        }
    }];
}


//MARK:- 绑定手机号码
-(void)loginbindmobile{
    
    [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:[NSString stringWithFormat:@"%@%@",API_BASE_URL_STRING,login_bindmobile] params:@{@"phone":self.phoneNumber.text,@"verify":self.msgCode.text,@"password":self.NphonePsd.text,@"name":self.wxdict[@"name"],@"openid":self.wxdict[@"openid"],@"avator":self.wxdict[@"avator"]} complement:^(ServerResponseInfo * _Nullable serverInfo) {
        if ([[serverInfo.response objectForKey:@"code"] intValue] == 200) {
            [HUDManager hidenHud];
            [HUDManager showTextHud:@"账号绑定成功"];
            isbindmobile = YES;
            [self performSelector:@selector(popVc) withObject:nil afterDelay:1];
            
        }
    }];
}


- (IBAction)getCodeMsg:(UIButton *)sender {
    KPreventRepeatClickTime(1)
    NSString *msg = nil;
    if (self.phoneNumber.text.length == 0) {
        msg = phoneLength;
    }else if (self.phoneNumber.text.length != 11 || ![NSObject IsPhoneNumber:self.phoneNumber.text]){
        msg = NphoneNumber;
        
    }else{}
    
    if (msg.length) {
        [HUDManager showTextHud:msg];
        return;
    }
    
    [self loadmsgNetWork];
}



//MARK:-修改
- (IBAction)submint:(UIButton *)sender {
    KPreventRepeatClickTime(1)
    NSString *msg = nil;
    
    if (self.phoneNumber.text.length == 0) {
        msg = phoneLength;
    }else if (self.phoneNumber.text.length != 11 || ![NSObject IsPhoneNumber:self.phoneNumber.text]){
        msg = NphoneNumber;
    }else if (self.msgCode.text.length == 0){
        msg = msgCodeLength;
    }else if (self.NphonePsd.text.length == 0){
        msg = phonePwdLength;
    }else{}
    
    if (msg.length) {
        [HUDManager showTextHud:msg];
        return;
    }
    
    [HUDManager showLoadingHud:loading onView:self.view];
    
    if (self.type == RetrievepsdViewControllerOne) {
        [self performSelector:@selector(loadforgetNetWork) withObject:nil afterDelay:1];
    }else if (self.type == RetrievepsdViewControllerTwo){
        [self performSelector:@selector(loginbindmobile) withObject:nil afterDelay:1];
    }else{
        
    }
}


-(void)popVc{
    _successBlock(isbindmobile);
    [self.navigationController popToRootViewControllerAnimated:YES];
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
