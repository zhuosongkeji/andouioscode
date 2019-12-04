//
//  RetrievepsdViewController.m
//  OgrinterProduct
//
//  Created by wongshine on 2019/11/27.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "RetrievepsdViewController.h"

@interface RetrievepsdViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;

@property (weak, nonatomic) IBOutlet UITextField *msgCode;

@property (weak, nonatomic) IBOutlet UITextField *NphonePsd;


@end

@implementation RetrievepsdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.title = @"找回密码";
    // Do any additional setup after loading the view from its nib.
}


- (IBAction)getCodeMsg:(UIButton *)sender {
    
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



//MARK:-修改
- (IBAction)submint:(UIButton *)sender {
    
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
