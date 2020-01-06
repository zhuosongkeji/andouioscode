//
//  ZBNSHEvaluateSuccessVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/6.
//  Copyright © 2020 RXF. All rights reserved.
//  评价成功

#import "ZBNSHEvaluateSuccessVC.h"
#import "ZBNSHReadEvaluateVC.h"

@interface ZBNSHEvaluateSuccessVC ()

@property (weak, nonatomic) IBOutlet UIView *btnView;

@end

@implementation ZBNSHEvaluateSuccessVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

/*! 设置UI */
- (void)setupUI
{
    self.navigationItem.title = @"评论成功";
    self.btnView.layer.cornerRadius = 10;
    
}

/*! 查看评论按钮的点击 */
- (IBAction)btnClick:(UIButton *)sender {
    
    ZBNSHReadEvaluateVC *vc = [[ZBNSHReadEvaluateVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
