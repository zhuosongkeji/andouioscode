//
//  ZBNRTPayVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/2/28.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNRTPayVC.h"
#import "ZBNRTPayCell.h"
#import "ZBNRTComDetailCell.h"
#import "ZBNRTComDetailHeader.h"
#import "ZBNRTComDetailModel.h"
#import "ZBNRTMoreView.h"

@interface ZBNRTPayVC () <UITableViewDelegate, UITableViewDataSource>
/*! 模型数据 */
@property (nonatomic, strong) ZBNRTComDetailModel *detailM;
/*! table */
@property (weak, nonatomic) IBOutlet UITableView *myTable;
/*! morView */
@property (nonatomic, strong) ZBNRTMoreView *moreView;
/*! header */
@property (nonatomic, weak) ZBNRTComDetailHeader *header;
/*! 多数据时展示的数组 */
@property (nonatomic, strong) NSMutableArray *lessArr;
/*! 记录支付方式 */
@property (nonatomic, copy) NSString *payKind;
/*! 支付金额 */
@property (weak, nonatomic) IBOutlet UILabel *price;

@end

@implementation ZBNRTPayVC

- (NSMutableArray *)lessArr
{
    if (!_lessArr) {
        _lessArr = [NSMutableArray array];
    }
    return _lessArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置table
    [self setTable];
    // 加载数据
    [self loadRequest];
    
}

- (void)setTable
{

    self.myTable.bounces = NO;
    self.myTable.delegate = self;
    self.myTable.dataSource = self;
    self.myTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myTable.backgroundColor = KSRGBA(241, 241, 241, 1);
    ADWeakSelf;
    ZBNRTMoreView *moreV = [ZBNRTMoreView viewFromXib];
    self.moreView = moreV;
    self.moreView.moreBtnClickTask = ^(UIButton * _Nonnull btn) {
        [weakSelf.lessArr removeAllObjects];
        [weakSelf.lessArr addObjectsFromArray:weakSelf.detailM.foods];
        [weakSelf.myTable reloadData];
        [btn setTitle:@"已经加载完了喔" forState:UIControlStateNormal];
    };
}


- (IBAction)payBtnClick:(id)sender {
    
    [self payRequest];
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        if (self.detailM.foods.count <= 3) {
            return self.detailM.foods.count;
        } else {
            return self.lessArr.count;
        }
    } else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        ZBNRTComDetailCell *cell = [ZBNRTComDetailCell regiserCellForTable:tableView];
        if (self.detailM.foods.count <= 3) {
            cell.detailM = self.detailM.foods[indexPath.row];
        } else {
            cell.detailM = self.lessArr[indexPath.row];
        }
        return cell;
    } else {
        ZBNRTPayCell *cell = [[NSBundle mainBundle] loadNibNamed:@"ZBNRTPayCell" owner:nil options:nil].lastObject;
        ADWeakSelf;
        cell.weixinBtnClickTask = ^(UIButton * _Nonnull weixinBtn) {
            if (weixinBtn.selected) {
                weakSelf.payKind = @"1";
            }
        };
        //
        cell.yueBtnClickTask = ^(UIButton * _Nonnull yueBtn) {
            if (yueBtn.selected) {
                weakSelf.payKind = @"2";
            }
        };
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.detailM = self.detailM;
        return cell;
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 110;
    } else {
        return 450;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        ZBNRTComDetailHeader *header = [ZBNRTComDetailHeader viewFromXib];
        header.comDetailM = self.detailM;
        self.header = header;
        return header;
    } else {
        UIView *headerV = [[UIView alloc] init];
        headerV.backgroundColor = KSRGBA(241, 241, 241, 1);
        return headerV;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (self.detailM.foods.count >3) {
        if (section == 0) {
            return self.moreView;
        } else {
            return nil;
        }
    } else {
        return nil;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 40;
    } else {
        return 10;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (self.detailM.foods.count > 3) {
        if (section == 0) {
            return 40;
        } else{
            return 0;
        }
    } else {
        return 0;
    }
    
}

#pragma mark -- net相关

- (void)loadRequest
{
    [FKHRequestManager cancleRequestWork];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSData * data1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"infoData"];
    userInfo * unmodel = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
    params[@"uid"] = unmodel.uid;
    params[@"token"] = unmodel.token;
    params[@"id"] = self.order_id;
    ADWeakSelf;
    [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl: ZBNGourmetDetailURL params:params complement:^(ServerResponseInfo * _Nullable serverInfo) {
        if ([[serverInfo.response objectForKey:@"code"] intValue] == 200) {
            weakSelf.detailM = [ZBNRTComDetailModel mj_objectWithKeyValues:serverInfo.response[@"data"]];
            weakSelf.price.text = [NSString stringWithFormat:@"¥%@",weakSelf.detailM.prices];
            if (weakSelf.detailM.foods.count <=3) {
                [weakSelf.myTable reloadData];
            } else{
                [weakSelf.lessArr addObject:weakSelf.detailM.foods[0]];
                [weakSelf.lessArr addObject:weakSelf.detailM.foods[1]];
                [weakSelf.lessArr addObject:weakSelf.detailM.foods[2]];
                 [weakSelf.myTable reloadData];
            }
           
        } else {
            [HUDManager showTextHud:@"加载失败"];
        }
       }];
}

- (void)payRequest
{
    
    [FKHRequestManager cancleRequestWork];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSData * data1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"infoData"];
    userInfo * unmodel = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
    params[@"uid"] = unmodel.uid;
    params[@"token"] = unmodel.token;
    params[@"sNo"] = self.detailM.order_sn;
    if ([self.payKind isEqualToString:@"1"]) {
        [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl: @"http://andou.zhuosongkj.com/index.php/api/gourmet/wxPay" params:params complement:^(ServerResponseInfo * _Nullable serverInfo) {
            [HUDManager showTextHud:[serverInfo.response objectForKey:@"msg"]];
        }];
    } else if ([self.payKind isEqualToString:@"2"]) {
        [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl: @"http://andou.zhuosongkj.com/index.php/api/gourmet/balancePay" params:params complement:^(ServerResponseInfo * _Nullable serverInfo) {
            if ([[serverInfo.response objectForKey:@"code"] intValue] == 200) {
                [HUDManager showTextHud:@"支付成功"];
                [self.navigationController popViewControllerAnimated:YES];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"paySuccess" object:nil];
            }
        }];
    } else {
        [HUDManager showTextHud:@"请选择支付方式"];
    }
    
    
}

@end
