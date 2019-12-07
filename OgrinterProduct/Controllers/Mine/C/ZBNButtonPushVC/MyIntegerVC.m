//
//  MyIntegerVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/7.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "MyIntegerVC.h"

#import "MyIntegralHeadView.h"
#import "ConsumptionDetailCell.h"

@interface MyIntegerVC ()

@property (nonatomic, weak) MyIntegralHeadView *headView;

@end

@implementation MyIntegerVC

static NSString * const ConsumptionDetailCellID = @"consumptionDetail";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MyIntegralHeadView *headV = [MyIntegralHeadView viewFromXib];
    self.tableView.tableHeaderView = headV;
    headV.height = 200;
    self.headView = headV;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ConsumptionDetailCell class]) bundle:nil] forCellReuseIdentifier:ConsumptionDetailCellID];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ConsumptionDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:ConsumptionDetailCellID];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

@end
