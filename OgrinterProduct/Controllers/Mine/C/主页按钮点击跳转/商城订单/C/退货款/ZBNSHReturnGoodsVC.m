//
//  ZBNSHReturnGoodsVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/19.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNSHReturnGoodsVC.h"
#import "ZBNSHOrderDetailsM.h"
#import "ZBNSHAppReturnGoodsCell.h"

@interface ZBNSHReturnGoodsVC ()

@property (nonatomic, strong) ZBNSHOrderDetailsM *detailsM;

@end

@implementation ZBNSHReturnGoodsVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
    // 加载数据
    [self loadData];
    
    // 关于内容视图偏移的解决
    self.navigationController.navigationBar.translucent = NO;
    self.tableView.bounces = NO;
}


- (void)loadData
{
    ADWeakSelf;
       NSMutableDictionary *params = [NSMutableDictionary dictionary];
           NSData * data1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"infoData"];
           userInfo * unmodel = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
           params[@"uid"] = unmodel.uid;
           params[@"token"] = unmodel.token;
           params[@"order_sn"] = self.order_goods_id;
           params[@"did"] = self.did;
           [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:@"http://andou.zhuosongkj.com/index.php/api/order/details" params:params complement:^(ServerResponseInfo * _Nullable serverInfo) {
               self.detailsM = [ZBNSHOrderDetailsM mj_objectWithKeyValues:[serverInfo.response[@"data"] valueForKeyPath:@"details"][0]];
               [weakSelf.tableView reloadData];
           }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZBNSHAppReturnGoodsCell *cell = [[NSBundle mainBundle] loadNibNamed:@"ZBNSHAppReturnGoodsCell" owner:nil options:nil].firstObject;
    cell.detailsM = self.detailsM;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 475;
}

@end
