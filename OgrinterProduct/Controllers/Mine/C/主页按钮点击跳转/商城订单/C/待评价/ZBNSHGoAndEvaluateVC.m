//
//  ZBNSHGoAndEvaluateVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/6.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNSHGoAndEvaluateVC.h"

#import "ZBNSHGoAndEvaluateCell.h"
#import "ZBNEntryFooterView.h"
#import "ZBNSHEvaluateSuccessVC.h"
#import "ZBNSHGoAndEvaluateModel.h"

@interface ZBNSHGoAndEvaluateVC ()

@property (nonatomic, weak) ZBNEntryFooterView *footerV;

@property (nonatomic, copy) NSString *comText;
@property (nonatomic, copy) NSString *starNum;
@property (nonatomic, strong) ZBNSHGoAndEvaluateModel *model;
@end

@implementation ZBNSHGoAndEvaluateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUIData];
    [self setupTable];
    [self setupFooter];
}


- (void)setupUIData
{
    ZBNSHGoAndEvaluateModel *model = [ZBNSHGoAndEvaluateModel sharedInstance];
    [model setImageName:self.imageName];
    self.model = model;
    [self.tableView reloadData];
}


- (void)setupFooter
{
    ADWeakSelf;
    ZBNEntryFooterView *footerV = [ZBNEntryFooterView viewFromXib];
    footerV.height = ZBNFooterH;
    footerV.setButtonText(@"发表评论");
    // -------------> 发表评论在这里设置点击
    footerV.middleBtnClickTask = ^{
        [self commentRequest];
    };
    self.tableView.tableFooterView = footerV;
    self.footerV = footerV;
}

- (void)commentRequest
{
    [FKHRequestManager cancleRequestWork];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSData * data1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"infoData"];
    userInfo * unmodel = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
    ZBNSHGoAndEvaluateModel *model = [ZBNSHGoAndEvaluateModel sharedInstance];
    params[@"uid"] = unmodel.uid;
    params[@"token"] = unmodel.token;
    params[@"goods_id"] = self.goods_id;
    NSLog(@"%@",self.goods_id);
    params[@"order_id"] = self.order_id;
    params[@"merchants_id"] = self.merchant_id;
    params[@"content"] = model.content;
    params[@"stars"] = model.stars;
    NSLog(@"%@",model.stars);
       ADWeakSelf;
       [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:@"http://andou.zhuosongkj.com/index.php/api/order/addcomment" params:params complement:^(ServerResponseInfo * _Nullable serverInfo) {
           if ([[serverInfo.response objectForKey:@"code"] intValue] == 200) {
               ZBNSHEvaluateSuccessVC *vc = [[ZBNSHEvaluateSuccessVC alloc] init];
               [weakSelf.navigationController pushViewController:vc animated:YES];
           } else {
               [HUDManager showTextHud:@"评论失败"];
           }
       }];
}


- (void)setupTable
{
    self.navigationItem.title = @"发表评论";
    self.tableView.contentInset = UIEdgeInsetsMake(getRectNavAndStatusHight, 0, 0, 0);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZBNSHGoAndEvaluateCell *cell = [ZBNSHGoAndEvaluateCell regiserCellForTable:tableView];
    cell.model = self.model;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 450;
}

@end
