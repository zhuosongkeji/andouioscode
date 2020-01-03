//
//  ZBNChangePhoneNumberVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/2.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNChangePhoneNumberVC.h"

@interface ZBNChangePhoneNumberVC ()
/*! 输入手机号 */
@property (weak, nonatomic) IBOutlet UITextField *inputPhoneNumT;
/*! 输入验证码 */
@property (weak, nonatomic) IBOutlet UITextField *verificationCodeT;
/*! 新手机号 */
@property (weak, nonatomic) IBOutlet UITextField *numberNewT;
/*! 获取验证码按钮 */
@property (weak, nonatomic) IBOutlet UIButton *getVerificationCodeBtn;
/*! 定时器 */
@property (nonatomic, weak) NSTimer *timer;
/*! 按钮可点击剩下的时间 */
@property (nonatomic, assign) int leftTime;
@end

@implementation ZBNChangePhoneNumberVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.getVerificationCodeBtn.layer.cornerRadius = 5;
    
    self.leftTime = 60;
}

- (IBAction)getVerificationCodeBtnClick:(UIButton *)sender {
    
    
    [self sendRequest];
    
}

/*! 发送网络请求 */
- (void)sendRequest
{
    // 拿到uid 和 token
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"phone"] = self.inputPhoneNumT.text;
    params[@"type"] = @"0";
    // 发送网络请求
    [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:ZBNSendVCodeURL params:params complement:^(ServerResponseInfo * _Nullable serverInfo) {
        if ([[serverInfo.response  valueForKey:@"code"] integerValue] == 200) {
            [HUDManager showTextHud:@"发送验证码成功"];
            // 创建定时器
            NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(upDateTime) userInfo:nil repeats:YES];
            [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
            self.timer = timer;
            
        } else {
            [HUDManager showTextHud:@"请输入正确的手机号"];
        }
    }];
    
}

// 更新时间
- (void)upDateTime
{
    self.leftTime--;
    self.getVerificationCodeBtn.enabled = NO;
    // 更新文字
    NSString *title = [NSString stringWithFormat:@"还剩(%d)秒",self.leftTime];
    [self.getVerificationCodeBtn setTitle:title forState:UIControlStateNormal];
    [self.getVerificationCodeBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    if (self.leftTime == -1) {
        [self.timer invalidate];
        self.leftTime = 60;
        self.getVerificationCodeBtn.enabled = YES;
        [self.getVerificationCodeBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
        [self.getVerificationCodeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    
}

// 控制器销毁
- (void)dealloc
{
    // 销毁定时器
    [self.timer invalidate];
}


@end
