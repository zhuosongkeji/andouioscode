//
//  ZBNShoppingMallEntryVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/11.
//  Copyright © 2019 RXF. All rights reserved.
//  商城商家入驻

#import "ZBNShoppingMallEntryVC.h"
#import "ZBNShoppingMallEntryCell.h"
#import "ZBNEntryFooterView.h"



@interface ZBNShoppingMallEntryVC ()

@property (nonatomic, weak) ZBNEntryFooterView *footerView;

@end

@implementation ZBNShoppingMallEntryVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    self.navigationItem.title = @"商城商家入驻";
    self.tableView.contentInset = UIEdgeInsetsMake(getRectNavAndStatusHight, 0, 0, 0);
    self.view.backgroundColor = KSRGBA(241, 241, 241, 1);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self setupFooter];
}

- (void)setupFooter
{
    ZBNEntryFooterView *footerV = [ZBNEntryFooterView viewFromXib];
    footerV.height = ZBNFooterH;
    ADWeakSelf;
    footerV.middleBtnClickTask = ^{
        [weakSelf loadRequset];
    };
    self.tableView.tableFooterView = footerV;
    self.footerView = footerV;
}

- (void)loadRequset
{
    NSData * data1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"infoData"];
    userInfo * unmodel = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"uid"] = unmodel.uid;
    param[@"token"] = unmodel.token;
    param[@"type_id"] = @"2";
    param[@"name"] = self.model.shopName;
    param[@"user_name"] = self.model.userName;
    param[@"tel"] = self.model.phoneNum;
    param[@"province_id"] = [NSString stringWithFormat:@"%@",self.model.IDPro];
    param[@"city_id"] = [NSString stringWithFormat:@"%@",self.model.IDCity];
    param[@"area_id"] = [NSString stringWithFormat:@"%@",self.model.IDArea];
    param[@"address"] = self.model.detailAdd;
    param[@"desc"] = self.model.shopIntrol;
    param[@"banner_img"] = self.model.urlOne;
    param[@"logo_img"] = self.model.urlTwo;
    param[@"management_img"] = self.model.urlThree;
    [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:@"http://andou.zhuosongkj.com/index.php/api/merchant/information" params:param complement:^(ServerResponseInfo * _Nullable serverInfo) {
        if ([[serverInfo.response objectForKey:@"code"] intValue] == 200) {
            [HUDManager showTextHud:@"申请入驻成功"];
        } else {
            [HUDManager showTextHud:@"资料填写错误"];
        }
           
       }];
}





#pragma mark -- 数据源方法 && 代理方法


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZBNShoppingMallEntryCell *cell =
    [ZBNShoppingMallEntryCell registerCellForTableView:tableView];
    self.model = cell.model;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 876;
}



@end
