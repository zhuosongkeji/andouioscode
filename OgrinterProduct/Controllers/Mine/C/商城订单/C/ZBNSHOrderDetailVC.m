//
//  ZBNSHOrderDetailVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/14.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ZBNSHOrderDetailVC.h"

#import "ZBNOrderDetailCellOne.h"
#import "ZBNOrderDetailCellTwo.h"
#import "ZBNOrderDetailCellThree.h"
#import "ZBNOrderDetailCellFour.h"
#import "ZBNOrderDetailCellFive.h"
#import "ZBNOrderDetailHeadView.h"


@interface ZBNSHOrderDetailVC ()

@end

@implementation ZBNSHOrderDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        ZBNOrderDetailCellOne *oneCell = [ZBNOrderDetailCellOne registerCellForTableView:tableView];
        return oneCell;
    } else if (indexPath.section == 1) {
        ZBNOrderDetailCellTwo *twoCell = [ZBNOrderDetailCellTwo registerCellForTableView:tableView];
        return twoCell;
    } else if (indexPath.section == 2) {
        ZBNOrderDetailCellThree *threeCell = [ZBNOrderDetailCellThree registerCellForTableView:tableView];
        return threeCell;
    } else if (indexPath.section == 3) {
        ZBNOrderDetailCellFour *fourCell = [ZBNOrderDetailCellFour registerCellForTableView:tableView];
        return fourCell;
    } else {
        ZBNOrderDetailCellFive *fiveCell = [ZBNOrderDetailCellFive registerCellForTableView:tableView];
        return fiveCell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 60;
    } else if (indexPath.section == 1) {
        return 60;
    } else if (indexPath.section == 2) {
        return 60;
    } else if (indexPath.section == 3) {
        return 120;
    } else {
        return 50;
    }
}


@end
