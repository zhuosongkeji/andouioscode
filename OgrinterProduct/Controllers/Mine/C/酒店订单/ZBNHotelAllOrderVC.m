//
//  ZBNHotelAllOrderVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/12.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ZBNHotelAllOrderVC.h"
#import "ZBNCommenOrderCell.h"
#import "ZBNOrderModel.h"

@interface ZBNHotelAllOrderVC ()

@property (nonatomic, strong) NSMutableArray *array;

@end

@implementation ZBNHotelAllOrderVC

static NSString * const ZBNHotelAllOrderCellID = @"OrderCommenCell";

- (NSMutableArray *)array
{
    if (!_array) {
        _array = [NSMutableArray array];
    }
    return _array;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTable];
}

- (void)initModel
{
    for (int i = 0; i < 10; i++) {
        ZBNOrderModel *model = [[ZBNOrderModel alloc] init];
        [self.array addObject:model];
    }
}

- (void)setupTable {
    
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"ZBNCommenOrderCell" bundle:nil] forCellReuseIdentifier:ZBNHotelAllOrderCellID];
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZBNCommenOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:ZBNHotelAllOrderCellID];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 314;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

@end
