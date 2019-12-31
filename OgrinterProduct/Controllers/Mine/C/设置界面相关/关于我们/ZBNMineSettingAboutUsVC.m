//
//  ZBNMineSettingAboutUsVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/28.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ZBNMineSettingAboutUsVC.h"
#import <UIImageView+WebCache.h>

@interface ZBNMineSettingAboutUsVC ()

/*! LOGO */
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
/*! 介绍 */
@property (weak, nonatomic) IBOutlet UILabel *introLabel;
/*! 关于我们 */
@property (weak, nonatomic) IBOutlet UILabel *aboutUsLabel;
/*! 公司版权 */
@property (weak, nonatomic) IBOutlet UILabel *bottomLabel;
/*! 版本 */
@property (weak, nonatomic) IBOutlet UILabel *editionLabel;


@end

@implementation ZBNMineSettingAboutUsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // 加载数据
    [self loadData];
    // UI相关
    [self setupUI];
}

/*! 设置UI */
- (void)setupUI
{
    self.navigationItem.title = @"关于我们";
}

/*! 加载数据 */
- (void)loadData
{
    // 发送网络请求 --> 因为这里是单组数据我就直接取值了
    [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:@"http://andou.zhuosongkj.com/api/index/about" params:nil complement:^(ServerResponseInfo * _Nullable serverInfo) {
        NSLog(@"%@",serverInfo.response);
        // content
        self.aboutUsLabel.text = serverInfo.response[@"data"][@"content"];
        self.introLabel.text = serverInfo.response[@"data"][@"title"];
        self.bottomLabel.text = [NSString stringWithFormat:@"版权所有:%@",serverInfo.response[@"data"][@"copyright"]];
        self.editionLabel.text = [NSString stringWithFormat:@"当前版本:%@",serverInfo.response[@"data"][@"value"]];
    }];
}



@end
