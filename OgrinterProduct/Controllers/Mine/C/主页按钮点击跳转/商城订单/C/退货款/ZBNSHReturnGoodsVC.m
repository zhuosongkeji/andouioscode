//
//  ZBNSHReturnGoodsVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/19.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNSHReturnGoodsVC.h"
#import "ZBNSHAppReturnGoodsCell.h"
#import "ZBNEntryFooterView.h"
#import "ZBNReturnGoodsM.h"
#import "ZBNReturnGoodsReasonView.h"
#import "ZBNSHReturnGoodsComM.h"

@interface ZBNSHReturnGoodsVC ()
@property (nonatomic, weak) ZBNEntryFooterView *footerV;
@property (nonatomic, strong) ZBNReturnGoodsM *goodsM;

@end

@implementation ZBNSHReturnGoodsVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
    // 设置UI
    [self setupUI];
    
    // 设置table
    [self setupTable];
    
    // 初始化模型数据
    [self initModel];
    
   
    
}

- (void)initModel
{
    ZBNReturnGoodsM *goodsM = [[ZBNReturnGoodsM alloc] init];
    [goodsM setGoodsID:self.goodsID];
    [goodsM setGoodsImg:self.goodsImg];
    [goodsM setGoodsNum:self.goodsNum];
    [goodsM setGoodsName:self.goodsName];
    [goodsM setGoodsIntro:self.goodsIntro];
    [goodsM setGoodsPrice:self.goodsPrice];
    self.goodsM = goodsM;
    [self.tableView reloadData];
}

- (void)setupTable
{
    self.view.backgroundColor = KSRGBA(241, 241, 241, 1);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(getRectNavAndStatusHight, 0, 0, 0);
}

- (void)setupUI
{
    ZBNEntryFooterView *footerV = [ZBNEntryFooterView viewFromXib];
    footerV.height = ZBNFooterH;
    footerV.setButtonText(@"确认退款");
    footerV.middleBtnClickTask = ^{
        [self loadData];
    };
    self.tableView.tableFooterView = footerV;
    self.footerV = footerV;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    ZBNSHAppReturnGoodsCell *cell = [[NSBundle mainBundle] loadNibNamed:@"ZBNSHAppReturnGoodsCell" owner:nil options:nil].lastObject;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.goodsM = self.goodsM;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 475;
}

- (void)loadData
{
    ZBNSHReturnGoodsComM *comM = [ZBNSHReturnGoodsComM sharedInstance];
    [FKHRequestManager cancleRequestWork];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSData * data1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"infoData"];
    userInfo * unmodel = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
    params[@"uid"] = unmodel.uid;
    params[@"token"] = unmodel.token;
    params[@"order_goods_id"] = self.goodsID;
    params[@"reason_id"] = comM.reason_id;
    params[@"content"] = @"";
    params[@"image"] = @"";
    ADWeakSelf;
    [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl: @"http://andou.zhuosongkj.com/api/refund/apply" params:params complement:^(ServerResponseInfo * _Nullable serverInfo) {
        if ([serverInfo.response[@"code"] intValue] == 200) {
            [HUDManager showTextHud:@"提交申请成功"];
        }
    }];
}

@end
