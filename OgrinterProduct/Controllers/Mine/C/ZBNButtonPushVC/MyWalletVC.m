//
//  MyWalletVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/6.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "MyWalletVC.h"

#import "MyWalletHeadView.h"
#import "ConsumptionDetailCell.h"

@interface MyWalletVC () 
/*! headView */
@property (nonatomic, weak) MyWalletHeadView *headView;

@end

@implementation MyWalletVC

static NSString * const ConsumptionCellID = @"consumptionDetail";

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.tableView.estimatedRowHeight = 90;
    
    MyWalletHeadView *headV = [MyWalletHeadView viewFromXib];
    headV.height = 200;
    self.headView = headV;
    self.tableView.tableHeaderView = headV;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ConsumptionDetailCell class]) bundle:nil] forCellReuseIdentifier:ConsumptionCellID];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ConsumptionDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:ConsumptionCellID];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

@end
