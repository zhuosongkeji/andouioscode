//
//  InviteCourtesyVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/10.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "InviteCourtesyVC.h"
#import "UIImage+ZBNExtension.h"

@interface InviteCourtesyVC ()

// 用户头像
@property (weak, nonatomic) IBOutlet UIImageView *userIconView;
// 用户名
@property (weak, nonatomic) IBOutlet UILabel *name;
// 二维码
@property (weak, nonatomic) IBOutlet UIImageView *erweima;


@end

@implementation InviteCourtesyVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self loadRequest];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)loadRequest
{
    [FKHRequestManager cancleRequestWork];
    NSData * data1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"infoData"];
    userInfo * unmodel = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
        param[@"uid"] = unmodel.uid;
        param[@"token"] = unmodel.token;
    ADWeakSelf;
       [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:@"http://andou.zhuosongkj.com/index.php/api/users/invitations" params:param complement:^(ServerResponseInfo * _Nullable serverInfo) {
           [weakSelf.userIconView setHeader:[NSString stringWithFormat:@"%@%@",imgServer,[serverInfo.response[@"data"] objectForKey:@"avator"]]];
           [weakSelf.erweima sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@\/%@",imgServer,[serverInfo.response[@"data"] objectForKey:@"qrcode"]]]];
           weakSelf.name.text = [serverInfo.response[@"data"] objectForKey:@"name"];
           if ([[serverInfo.response objectForKey:@"code"] intValue] == 500) {
               [HUDManager showTextHud:@"服务器错误"];
           }
       }];
          
}


@end
