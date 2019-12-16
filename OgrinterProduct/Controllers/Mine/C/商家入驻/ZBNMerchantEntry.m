//
//  ZBNMerchantEntry.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/10.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ZBNMerchantEntry.h"
#import "ZBNMerchantEntryCell.h"
#import "ZBNShoppingMallEntryVC.h"
#import "ZBNHotelEntryVC.h"


@interface ZBNMerchantEntry () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ZBNMerchantEntry

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = KSRGBA(240, 240, 240, 1);
    self.navigationItem.title = @"商家入驻";
    self.tableView.contentInset = UIEdgeInsetsMake(15, 0, 0, 0);
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ZBNMerchantEntryCell" bundle:nil] forCellReuseIdentifier:@"ZBNMerchantEntryCell"];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZBNMerchantEntryCell *cell = [ZBNMerchantEntryCell tempTableViewCellWith:self.tableView indexPath:indexPath];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (indexPath.row == 0) {
        ZBNShoppingMallEntryVC * VC = [[ZBNShoppingMallEntryVC alloc] init
                                       ];
        [self.navigationController pushViewController:VC animated:YES];
    } else if (indexPath.row == 1) {
        ZBNHotelEntryVC *hotelVc = [[ZBNHotelEntryVC alloc] init];
        [self.navigationController pushViewController:hotelVc animated:YES];
    }
    
}

@end
