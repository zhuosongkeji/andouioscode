//
//  ZBNChangePwdVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/2.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNChangePwdVC.h"

@interface ZBNChangePwdVC ()

@property (weak, nonatomic) IBOutlet UITextField *inputPhoneNumT;

@property (weak, nonatomic) IBOutlet UITextField *inputVCodeT;

@property (weak, nonatomic) IBOutlet UITextField *inputNewPwdT;

@property (weak, nonatomic) IBOutlet UIButton *getVCodeBtn;

/*! 定时器 */
@property (nonatomic, weak) NSTimer *timer;
/*! 按钮可点击剩下的时间 */
@property (nonatomic, assign) int leftTime;
@end

@implementation ZBNChangePwdVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.getVCodeBtn.layer.cornerRadius = 5;
    self.leftTime = 60;
}

/*! 获取验证码点击 */
- (IBAction)getVCodeBtnClick:(UIButton *)sender {
    
    
}




@end
