//
//  ZBNPostPayVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/2/19.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNPostPayVC.h"
#import "ZBNPostSuccessVC.h"

#import "ZBNPostPriceCell.h"
#import "ZBNPayWayCell.h"
#import "ZBNPostPayModel.h"
#import "ZBNPostPayWayModel.h"
#import "ZBNPostDingWayModel.h"
#import "ZBNPostPayHeader.h"
#import <WechatOpenSDK/WXApi.h>

@interface ZBNPostPayVC () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *myTableV;
@property (weak, nonatomic) IBOutlet UILabel *priceL;

@property (nonatomic, strong) NSMutableArray *payWays;
@property (nonatomic, strong) NSMutableArray *dingWays;
@property (nonatomic, strong) ZBNPostPayHeader *headerV;

@property (nonatomic, strong) NSNumber *payWay;
@property (nonatomic, strong) NSNumber *dingWay;

@end

@implementation ZBNPostPayVC

static NSString * const ZBNPayWayCellID = @"pay";
static NSString * const ZBNDingWayCellID = @"ding";

- (NSMutableArray *)dingWays
{
    if (!_dingWays) {
        _dingWays = [NSMutableArray array];
    }
    return _dingWays;
}

- (NSMutableArray *)payWays
{
    if (!_payWays) {
        _payWays = [NSMutableArray array];
    }
    return _payWays;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTable];
    [self initModel];
}

- (void)initModel
{
    ZBNPostPayWayModel *payWay = [[ZBNPostPayWayModel alloc] init];
    payWay.image = @"微信支付";
    payWay.name = @"微信";
    [self.payWays addObject:payWay];
    ZBNPostPayWayModel *payWay1 = [[ZBNPostPayWayModel alloc] init];
    payWay1.image = @"zhifub";
    payWay1.name = @"支付宝";
    [self.payWays addObject:payWay1];
    ZBNPostPayWayModel *payWay2 = [[ZBNPostPayWayModel alloc] init];
    payWay2.image = @"图层 5";
    payWay2.name = @"银联";
    [self.payWays addObject:payWay2];
    ZBNPostPayWayModel *payWay3 = [[ZBNPostPayWayModel alloc] init];
    payWay3.image = @"余额 197";
    payWay3.name = @"余额";
    [self.payWays addObject:payWay3];
    ZBNPostDingWayModel *ding = [[ZBNPostDingWayModel alloc] init];
    ding.name = @"置顶一天";
    ding.price = @"10";
    [self.dingWays addObject:ding];
    ZBNPostDingWayModel *ding1 = [[ZBNPostDingWayModel alloc] init];
    ding1.name = @"置顶二天";
    ding1.price = @"20";
    [self.dingWays addObject:ding1];
    ZBNPostDingWayModel *ding2 = [[ZBNPostDingWayModel alloc] init];
    ding2.name = @"置顶三天";
    ding2.price = @"30";
    [self.dingWays addObject:ding2];
    [self.myTableV reloadData];
}

- (void)setupTable
{
    // 注册
    [self.myTableV registerNib:[UINib nibWithNibName:@"ZBNPayWayCell" bundle:nil] forCellReuseIdentifier:ZBNPayWayCellID];
    [self.myTableV registerNib:[UINib nibWithNibName:@"ZBNPostPriceCell" bundle:nil] forCellReuseIdentifier:ZBNDingWayCellID];
    self.navigationItem.title = @"置顶选择";
    self.myTableV.backgroundColor = KSRGBA(241, 241, 241, 1);
    self.myTableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myTableV.delegate = self;
    self.myTableV.dataSource = self;
    self.myTableV.bounces = NO;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.dingWays.count;
    } else {
        return self.payWays.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        ZBNPostPriceCell *cell = [tableView dequeueReusableCellWithIdentifier:ZBNDingWayCellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.dingM = self.dingWays[indexPath.row];
        return cell;
    } else {
        ZBNPayWayCell *cell = [tableView dequeueReusableCellWithIdentifier:ZBNPayWayCellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.payWayM = self.payWays[indexPath.row];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 48;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        for (ZBNPostDingWayModel *dingM in self.dingWays) {
            if (dingM == self.dingWays[indexPath.row] ) {
                dingM.selected = YES;
                [self.priceL setText:[NSString stringWithFormat:@"¥%@",dingM.price]];
                if ([dingM.name isEqualToString:@"置顶一天"]) {
                    self.dingWay = @1;
                } else if ([dingM.name isEqualToString:@"置顶二天"]) {
                    self.dingWay = @2;
                } else {
                    self.dingWay = @3;
                }
            } else {
                dingM.selected = NO;
            }
            [self.myTableV reloadData];
        }
    } else if (indexPath.section == 1) {
        for (ZBNPostPayWayModel *payWayM in self.payWays) {
            if (payWayM == self.payWays[indexPath.row]) {
                payWayM.selected = YES;
                if ([payWayM.name isEqualToString:@"微信"]) {
                    self.payWay = @1;
                } else if ([payWayM.name isEqualToString:@"支付宝"])
                {
                    self.payWay = @2;
                } else if ([payWayM.name isEqualToString:@"银联"]) {
                    self.payWay = @3;
                } else {
                    self.payWay = @4;
                }
            } else {
                payWayM.selected = NO;
            }
        }
        [self.myTableV reloadData];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        ZBNPostPayHeader *header = [ZBNPostPayHeader viewFromXib];
        header.backgroundColor = [UIColor whiteColor];
        header.height = 48;
        header.setHeaderText(@"置顶方式");
        return header;
    } else {
        ZBNPostPayHeader *header = [ZBNPostPayHeader viewFromXib];
        header.height = 48;
        header.setHeaderText(@"选择支付方式");
        return header;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 48;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footer = [[UIView alloc] init];
    footer.height = 10;
    return footer;
}

- (IBAction)payBtnClick:(id)sender {
//    ZBNPostSuccessVC *vc = [[ZBNPostSuccessVC alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
    
    [self payRequest];
    
    
}


- (void)payRequest
{
    if (self.dingWay && self.payWay) {
        if (self.payWay.intValue == 2 || self.payWay.intValue == 3) {
            [HUDManager showTextHud:@"暂不支持支付宝和银联"];
            return;
        }
        NSData * data1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"infoData"];
        userInfo * unmodel = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
            param[@"uid"] = unmodel.uid;
            param[@"post_id"] = self.post_id;
            param[@"method"] = self.dingWay;
            param[@"pay_way"] = self.payWay;
        if (self.payWay.intValue == 1) {
            [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:@"http://andou.zhuosongkj.com/index.php/api/tieba/create_top_order" params:param complement:^(ServerResponseInfo * _Nullable serverInfo) {
                
                        if ([[serverInfo.response objectForKey:@"code"] intValue] == 200) {
                        NSDictionary *dict = serverInfo.response[@"data"];
                        [self uploadWx:dict];
                        }
                   }];
        }
       
        
    } else {
        [HUDManager showTextHud:@"请选择置顶方式或支付方式"];
    }
 
}

-(void)uploadWx:(NSDictionary *)dict{
    
    PayReq *req = [[PayReq alloc] init];
    
    req.openID = [NSString stringWithFormat:@"%@",dict[@"appid"]];
    //APPID
    req.partnerId = [NSString stringWithFormat:@"%@",dict[@"mch_id"]]; //商户号
    req.prepayId = [NSString stringWithFormat:@"%@",dict[@"prepay_id"]];
    
    req.nonceStr = [NSString stringWithFormat:@"%@",dict[@"nonce_str"]];
    
    req.timeStamp = [dict[@"timestamp"] intValue];
    
    req.package = @"Sign=WXPay";
    
    req.sign = [NSString stringWithFormat:@"%@",dict[@"sign"]];
    
    [WXApi sendReq:req completion:nil];
}



@end
