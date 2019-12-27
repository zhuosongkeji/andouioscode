//
//  RetrievepsdViewController.m
//  OgrinterProduct
//
//  Created by wongshine on 2019/11/27.
//  Copyright © 2019 RXF. All rights reserved.
//


#define login_forget @"login/forget"
#define send_msg @"login/send"


#import "RetrievepsdViewController.h"

@interface RetrievepsdViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;

@property (weak, nonatomic) IBOutlet UITextField *msgCode;

@property (weak, nonatomic) IBOutlet UITextField *NphonePsd;
@property (weak, nonatomic) IBOutlet UIButton *codeBrn;


@end

@implementation RetrievepsdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.title = @"找回密码";
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


-(void)loadforgetNetWork{
    
    [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:[NSString stringWithFormat:@"%@%@",API_BASE_URL_STRING,login_forget] params:@{@"phone":self.phoneNumber.text,@"verify":self.msgCode.text,@"new_password":self.NphonePsd.text} complement:^(ServerResponseInfo * _Nullable serverInfo) {
        if ([[serverInfo.response objectForKey:@"code"] intValue] == 200) {
            [HUDManager hidenHud];
            
            [HUDManager showTextHud:sendCode];
            
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
    
    [HUDManager showTextHud:loading onView:self.view];
    
    [self performSelector:@selector(loadforgetNetWork) withObject:nil afterDelay:1];
}


-(void)popVc{
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
