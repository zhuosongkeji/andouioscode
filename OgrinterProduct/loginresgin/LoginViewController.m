//
//  LoginViewController.m
//  OgrinterProduct
//
//  Created by wongshine on 2019/11/27.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "RetrievepsdViewController.h"


@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;

@property (weak, nonatomic) IBOutlet UITextField *phonePsword;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationController.title = @"登录";
    // Do any additional setup after loading the view from its nib.
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
