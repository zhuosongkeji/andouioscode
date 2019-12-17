//
//  ZBNSuccessfulWthdrawalsVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/14.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ZBNSuccessfulWthdrawalsVC.h"

@interface ZBNSuccessfulWthdrawalsVC ()
@property (weak, nonatomic) IBOutlet UIView *btnBackView;

@end

@implementation ZBNSuccessfulWthdrawalsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.btnBackView.layer.cornerRadius = 15;
}

@end
