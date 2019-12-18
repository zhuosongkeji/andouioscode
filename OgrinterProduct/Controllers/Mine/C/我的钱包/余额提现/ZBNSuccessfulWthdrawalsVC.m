//
//  ZBNSuccessfulWthdrawalsVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/14.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ZBNSuccessfulWthdrawalsVC.h"
#import "ZBNMyWalletVC.h"

@interface ZBNSuccessfulWthdrawalsVC ()
@property (weak, nonatomic) IBOutlet UIView *btnBackView;

@end

@implementation ZBNSuccessfulWthdrawalsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)myWalletBtnClick:(UIButton *)sender {
    
    for (UIViewController *vc in self.navigationController.viewControllers) {
        if ([vc isKindOfClass:[ZBNMyWalletVC class]]) {
            ZBNMyWalletVC *walletVc = (ZBNMyWalletVC *)vc;
            [self.navigationController popToViewController:walletVc animated:YES];
        }
    }
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.btnBackView.layer.cornerRadius = 15;
}

@end
