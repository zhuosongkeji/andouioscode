//
//  ZBNPostSuccessVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/2/19.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNPostSuccessVC.h"
#import "ZBNPostBarVC.h"

@interface ZBNPostSuccessVC ()

@end

@implementation ZBNPostSuccessVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)postBtnClick:(UIButton *)sender {
    NSLog(@"click");
    [self.navigationController popToRootViewControllerAnimated:YES];
//    for (UIViewController *controller in self.navigationController.viewControllers) {
//    if ([controller isKindOfClass:[ZBNPostBarVC class]]) {
//    ZBNPostBarVC *vc = (ZBNPostBarVC *)controller;
//        [self.navigationController popToRootViewControllerAnimated:YES];
//        }
//    }
}


@end
