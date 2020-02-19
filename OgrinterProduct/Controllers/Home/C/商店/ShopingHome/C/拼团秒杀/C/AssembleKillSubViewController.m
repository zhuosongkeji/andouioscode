//
//  AssembleKillSubViewController.m
//  OgrinterProduct
//
//  Created by wongshine on 2020/2/17.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "AssembleKillSubViewController.h"

@interface AssembleKillSubViewController ()<UITableViewDataSource,UITableViewDelegate>


@end

@implementation AssembleKillSubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


-(void)setup{
    self.subTableView.delegate = self;
    self.subTableView.dataSource = self;
    self.subTableView.tableFooterView = [UILabel new];
    
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
