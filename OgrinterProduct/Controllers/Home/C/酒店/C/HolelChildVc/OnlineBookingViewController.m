//
//  OnlineBookingViewController.m
//  OgrinterProduct
//
//  Created by wongshine on 2019/12/9.
//  Copyright © 2019 RXF. All rights reserved.
//

#define order_index @"order/details"//订单详情

#define common_payways @"common/pay_ways"//获取支付方式

#define order_pay @"order/pay"


#import "OnlineBookingViewController.h"
#import "CustomAlterView.h"
#import "OnlineTableViewCell.h"
#import "PaySuccessViewController.h"
#import "OrderlModel.h"
#import "PaywayModel.h"
#import <WechatOpenSDK/WXApi.h>
#import "OrderListModel.h"


@interface OnlineBookingViewController ()<UITableViewDelegate,UITableViewDataSource,OnlineTableViewCellDelegate>{
    
    BOOL HHR;
    NSInteger selectIndexPaths;
}

@property (weak, nonatomic) IBOutlet UILabel *totalMomey;

@property (weak, nonatomic) IBOutlet UITableView *mTableView;
@property(nonatomic,strong)CustomAlterView *alterView;

@property (nonatomic,weak)UIButton *bjbtn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toTop;

@property (assign, nonatomic) NSIndexPath *selectedIndexPath;//单选，当前选中的行

@property (nonatomic,strong)NSMutableArray *dataArr;

@property(nonatomic,strong)NSMutableArray *VauleArr;

@property(nonatomic,strong)NSMutableArray *payArr;

@end

@implementation OnlineBookingViewController


-(NSMutableArray *)dataArr{
    
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}


-(NSMutableArray *)payArr{
    
    if (!_payArr) {
        _payArr = [NSMutableArray array];
    }
    return _payArr;
}


-(NSMutableArray *)VauleArr{
    if (!_VauleArr) {
        _VauleArr = [NSMutableArray array];
    }
    return _VauleArr;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
    
    if (self.payType == OnlineBookingViewHotelPay) {
        self.navigationItem.title = OnlinTitleArr[0];
         [self createAlter];
    }else if (self.payType == OnlineBookingViewProductPay){
        self.navigationItem.title = OnlinTitleArr[1];
        [self loadNetWork];
    }else if (self.payType == OnlineBookingViewOrderPay){
        
    }else{}
    
    [self loadpayways];
    // Do any additional setup after loading the view from its nib.
}


-(void)setup{
    
    self.toTop.constant = kStatusBarAndNavigationBarH;
    self.mTableView.tableFooterView = [UILabel new];
    [self.mTableView registerNib:[UINib nibWithNibName:@"OnlineTableViewCell" bundle:nil] forCellReuseIdentifier:@"OnlineTableViewCell"];
    
    selectIndexPaths = 100000;
}



-(void)createAlter{
    _alterView = [[[NSBundle mainBundle]loadNibNamed:@"CustomAlterView" owner:self options:nil]lastObject];
    [_alterView setFrame:CGRectMake(0, 0, KSCREEN_WIDTH-64, KSCREEN_HEIGHT-280)];
    _alterView.btnBlcok = ^{
        HHR = YES;
    };
}


//MARK:- 在线下单
-(void)loadNetWork{
    
    NSString *url = [NSString stringWithFormat:@"%@%@",API_BASE_URL_STRING,order_index];
    
    NSData * data1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"infoData"];
    
    userInfo *unmodel = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
    
    [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:url params:@{@"uid":unmodel.uid,@"order_sn":self.order_sn} complement:^(ServerResponseInfo * _Nullable serverInfo) {
        if ([serverInfo.response[@"code"] integerValue] == 200) {
            OrderlModel *model = [[OrderlModel alloc]initWithDict:[serverInfo.response objectForKey:@"data"]];
            
            [self.dataArr addObject:model];
             //[self performSelector:@selector(pushToPayController) withObject:nil afterDelay:0.5];
            [self.mTableView reloadData];
            
        }else if ([serverInfo.response[@"code"] integerValue] == 201){
            
        }else{
            [HUDManager showTextHud:loadError];
        }
        
    }];
}


-(void)loadpayways{
    
    NSString *url = [NSString stringWithFormat:@"%@%@",API_BASE_URL_STRING,common_payways];
    
    [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:url params:nil complement:^(ServerResponseInfo * _Nullable serverInfo) {
        if ([serverInfo.response[@"code"] integerValue] == 200) {
            
            NSArray *array = serverInfo.response[@"data"];
            for (int i = 0; i < [array count]; i ++) {
                PaywayModel *model = [[PaywayModel alloc]initWithDict:array[i]];
                [self.payArr addObject:model];
                [self.mTableView reloadData];
            }
        }else if ([serverInfo.response[@"code"] integerValue] == 201){
            
        }else{
            [HUDManager showTextHud:loadError];
        }
        
    }];
}


-(void)loadpayToServer {
    
    NSString *url = [NSString stringWithFormat:@"%@%@",API_BASE_URL_STRING,order_pay];
    
    PaywayModel *model = self.payArr[selectIndexPaths];
    NSData * data1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"infoData"];
    userInfo *unmodel = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
    OrderlModel *Omodel = self.dataArr[0];
    
    [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:url params:@{@"uid":unmodel.uid,@"sNo":Omodel.order_sn,@"pay_id":model.pid,@"is_integral":@"0"} complement:^(ServerResponseInfo * _Nullable serverInfo) {
        
        if ([serverInfo.response[@"code"] integerValue] == 200) {
            
            NSDictionary *dict = serverInfo.response[@"data"];
            [self uploadWx:dict];
            
        }else if ([serverInfo.response[@"code"] integerValue] == 201){
            
        }else{
            [HUDManager showTextHud:loadError];
        }
        
    }];
}



//MARK:- tableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        
        if (self.payType == 0){return 1;}
            
        else if (self.payType == 1){
            
            if ([self.dataArr count]){OrderlModel *model = self.dataArr[0];
                return [model.listArr count];}
                return 0;
            
        }else if (self.payType == 2){return 0;}

        else {return 0;}
            
    }else if (section == 1){
        
        if (self.payType == 0){return 6;}
        
        else if (self.payType == 1){return 3;}
        
        else if (self.payType == 2){return 0;}
        
        else{return 0;}
        
    }else
        return [self.payArr count];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    OnlineTableViewCell *cell = [OnlineTableViewCell tempTableViewCellWith:self.mTableView indexPath:indexPath withTpye:self.payType];
    
    [cell configTempCellWith:indexPath];
    cell.xlDelegate = self;
    
    
    if (indexPath.section == 0) {
        
        if ([self.dataArr count]) {
            
            OrderlModel *model = self.dataArr[0];
            OrderListModel *list = model.listArr[indexPath.row];
            NSMutableArray *array = [NSMutableArray array];
            for (int i = 0; i < [model.listArr count]; i ++) {
                NSNumber *numb = @([list.tatolMamey integerValue]);
                [array addObject:numb];
            }
            [self.VauleArr addObjectsFromArray:array];
            
            NSNumber *sum = [array valueForKeyPath:@"@sum.self"];
            self.totalMomey.text = [NSString stringWithFormat:@"￥%@.00",sum];
            
            cell.modellist1 = list;
            
        }
        
    }else if (indexPath.section == 1){
        if ([self.dataArr count] > 0) {
            OrderlModel *model = self.dataArr[0];
            cell.modellist3 = model;
        }
        
    }else{
        
        cell.selectedIndexPath = indexPath;
        if (_selectedIndexPath == indexPath){
            cell.selectBtn.selected = YES;
        }else
            cell.selectBtn.selected = NO;
        
        if ([self.payArr count]) {
            cell.modellist2 = self.payArr[indexPath.row];
        }
    }
    
    return cell;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH,44)];
    v.backgroundColor = KSRGBA(255, 255, 255, 1);
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(16, 11, KSCREEN_WIDTH-32, 21)];
    lable.textColor = [UIColor lightGrayColor];
    lable.font = [UIFont systemFontOfSize:14];
    
    lable.text = selectpayStyle;
    [v addSubview:lable];
    
    return v;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 2) {
        return 44;
    }
    return 0;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 105;
        
    }else if (indexPath.section == 1){
        if (self.payType == 0) {
            return [[@[@"79",@"50",@"50",@"50",@"50",@"50"] objectAtIndex:indexPath.row] floatValue];
        }else if (self.payType == 1){
            return [[@[@"95",@"50",@"50"] objectAtIndex:indexPath.row] floatValue];
        }else if (self.payType == 2){
            return 0;
        }else {return 0;}
        
    }else if (indexPath.section == 2){
        return 50;
    }
    
    return 0;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


- (IBAction)orderclick:(UIButton *)sender {
    KPreventRepeatClickTime(1)
    
    if (self.payType == OnlineBookingViewHotelPay) {
        self.navigationItem.title = OnlinTitleArr[0];
        [[QWAlertView sharedMask] show:_alterView withType:QWAlertViewStyleAlert animationFinish:^{
            
            
        } dismissHandle:^{
            if (HHR) {
                HHR = NO;
                PaySuccessViewController *pay = [[PaySuccessViewController alloc]init];
                [self.navigationController pushViewController:pay animated:YES];
            }
        }];
        
    }else if (self.payType == OnlineBookingViewProductPay){
        self.navigationItem.title = OnlinTitleArr[1];
        if (selectIndexPaths == 100000) {
            [HUDManager showTextHud:@"请选择支付方式"];
            return;
        }
        
        [self loadpayToServer];
        
    }else if (self.payType == OnlineBookingViewOrderPay){
        
    }else{}
    
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


//MARK:-
- (void)handleSelectedButtonActionWithSelectedIndexPath:(NSIndexPath *)selectedIndexPath{
    if (selectedIndexPath.section == 1) {
        OnlineTableViewCell *celled = [self.mTableView cellForRowAtIndexPath:_selectedIndexPath];
        celled.selectBtn.selected = NO;
        //记录当前选中的位置索引
        _selectedIndexPath = selectedIndexPath;
        //当前选择的打勾
        OnlineTableViewCell *cell = [self.mTableView cellForRowAtIndexPath:selectedIndexPath];
        cell.selectBtn.selected = YES;
        selectIndexPaths = selectedIndexPath.row;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
