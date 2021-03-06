//
//  ZBNMerchantEntryVC.m
//  
//
//  Created by 周芳圆 on 2020/1/6.
//

#import "ZBNMerchantEntryVC.h"
#import "ZBNMerchantEntryTabCell.h"
#import "ZBNShoppingMallEntryVC.h"
#import "ZBNHotelEntryVC.h"
#import "ZBNTakeOutEntryVC.h"


@interface ZBNMerchantEntryVC ()

@end

@implementation ZBNMerchantEntryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTable];
}

- (void)setupTable
{
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
    }else {
        self.automaticallyAdjustsScrollViewInsets = YES;
    }
    self.navigationItem.title = @"商家入驻";
    self.view.backgroundColor = KSRGBA(241, 241, 241, 1);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}


#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZBNMerchantEntryTabCell *cell = [ZBNMerchantEntryTabCell registerCellForTableView:tableView];
    ADWeakSelf;
    cell.shoppingHallClickTask = ^{
        ZBNShoppingMallEntryVC *vc = [[ZBNShoppingMallEntryVC alloc] init];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    cell.hotleViewClickTask = ^{
        ZBNHotelEntryVC *vc = [[ZBNHotelEntryVC alloc] init];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    cell.takeViewClickTask = ^{
        ZBNTakeOutEntryVC *vc  = [[ZBNTakeOutEntryVC alloc] init];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 300;
}

@end
