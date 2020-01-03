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
    self.getVCodeBtn.enabled = NO;
    // 更新文字
    NSString *title = [NSString stringWithFormat:@"还剩(%d)秒",self.leftTime];
    [self.getVCodeBtn setTitle:title forState:UIControlStateNormal];
    [self.getVCodeBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    if (self.leftTime == -1) {
        [self.timer invalidate];
        self.leftTime = 60;
        self.getVCodeBtn.enabled = YES;
        [self.getVCodeBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
        [self.getVCodeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    
}

- (void)dealloc
{
    [self.timer invalidate];
}

@end
