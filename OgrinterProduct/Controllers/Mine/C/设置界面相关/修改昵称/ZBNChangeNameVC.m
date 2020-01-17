//
//  ZBNChangeNameVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/16.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNChangeNameVC.h"

@interface ZBNChangeNameVC ()

/*! 修改昵称的输入框 */
@property (weak, nonatomic) IBOutlet UITextField *changeTex;

@end

@implementation ZBNChangeNameVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark -- UI

#pragma mark -- 交互事件

/*! 修改按钮点击 */
- (IBAction)changeBtnClick:(UIButton *)sender {
    
    [self changeRequest];
}

#pragma mark -- 网络相关
/*! 修改的网络请求 */
- (void)changeRequest
{
    if (self.changeTex.text.length > 0) {
    // 拿到uid 和 token
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSData * data1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"infoData"];
    userInfo * unmodel = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
    params[@"id"] = unmodel.uid;
    params[@"token"] = unmodel.token;
    params[@"name"] = self.changeTex.text;
    ADWeakSelf;
    // 发送网络请求
    [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl: ZBNChangeNameURL params:params complement:^(ServerResponseInfo * _Nullable serverInfo) {
        if ([[serverInfo.response objectForKey:@"code"] intValue] == 200) {
            [HUDManager showTextHud:@"修改成功"];
            [self.navigationController popViewControllerAnimated:YES];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"changeNameOK" object:nil];
        } else {
            [HUDManager showTextHud:@"修改失败"];
        }
    }];
    }
}


@end
