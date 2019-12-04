//
//  RegisterViewController.m
//  OgrinterProduct
//
//  Created by wongshine on 2019/11/27.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()

@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;

@property (weak, nonatomic) IBOutlet UITextField *msgCode;

@property (weak, nonatomic) IBOutlet UITextField *phonepwd;

@property (weak, nonatomic) IBOutlet UIButton *selectbtn;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.title = @"用户注册";
    // Do any additional setup after loading the view from its nib.
}


//MARK:- 阅读协议
- (IBAction)selectcilck:(UIButton *)sender {
    self.selectbtn.selected = !self.selectbtn.selected;
}


//MARK:- 获取验证码
- (IBAction)getmsgCode:(UIButton *)sender {
    
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
    
}


//MARK:- 注册
- (IBAction)regtriser:(UIButton *)sender {
    
    NSString *msg = nil;
    
    if (self.phoneNumber.text.length == 0) {
        msg = phoneLength;
    }else if (self.phoneNumber.text.length != 11 || ![NSObject IsPhoneNumber:self.phoneNumber.text]){
        msg = NphoneNumber;
    }else if (self.msgCode.text.length == 0){
        msg = msgCodeLength;
    }else if (self.phonepwd.text.length == 0){
        msg = phonePwdLength;
    }else{}
    
    if (msg.length) {
        [HUDManager showTextHud:msg];
        return;
    }
    
    if (!self.selectbtn.selected) {
        [HUDManager showTextHud:isselectdbtn];
        return;
    }
    
}


- (IBAction)bklogin:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
