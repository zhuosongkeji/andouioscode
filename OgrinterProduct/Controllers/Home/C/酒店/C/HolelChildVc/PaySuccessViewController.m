//
//  PaySuccessViewController.m
//  OgrinterProduct
//
//  Created by wongshine on 2019/12/10.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "PaySuccessViewController.h"

@interface PaySuccessViewController ()

@end

@implementation PaySuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"支付结果";
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(0, 6, 32,32)];
    [btn setTitle:@"返回" forState:0];
    [btn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = item;
    // Do any additional setup after loading the view from its nib.
}


//MARK:-
- (IBAction)btnclick:(UIButton *)sender {
    NSLog(@"%@",sender);
}

-(void)back:(UIButton *)btn{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
