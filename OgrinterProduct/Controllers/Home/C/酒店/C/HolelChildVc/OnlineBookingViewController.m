//
//  OnlineBookingViewController.m
//  OgrinterProduct
//
//  Created by wongshine on 2019/12/9.
//  Copyright © 2019 RXF. All rights reserved.
//

#define order_index @"order/details"//订单详情

#define common_payways @"common/pay_ways"//获取支付方式

#define htorder_settlement @"htorder/settlement"//酒店结算

#define order_pay @"order/pay"

#define hotel_need @"hotel/need"//酒店入住须知

#define add_order @"htorder/add_order"//预定


#import "OnlineBookingViewController.h"
#import "CustomAlterView.h"
#import "OnlineTableViewCell.h"
#import "PaySuccessViewController.h"
#import "OrderlModel.h"
#import "PaywayModel.h"
#import <WechatOpenSDK/WXApi.h>
#import "OrderListModel.h"
#import "HotelOrderModel.h"
#import "HotelOrderModelList.h"
#import "THDatePickerView.h"


@interface OnlineBookingViewController ()<UITableViewDelegate,UITableViewDataSource,OnlineTableViewCellDelegate,THDatePickerViewDelegate>{
    
    BOOL HHR;
    NSInteger selectIndexPaths;
    
}

@property (weak, nonatomic) IBOutlet UILabel *totalMomey;

@property (weak, nonatomic) IBOutlet UITableView *mTableView;
@property(nonatomic,strong)CustomAlterView *alterView;

@property (nonatomic,weak)UIButton *bjbtn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toTop;

@property (assign, nonatomic) NSIndexPath *selectedIndexPath;//单选，当前选中的行
@property(nonatomic,strong)NSString *jdid;

@property (nonatomic,strong)NSMutableArray *dataArr;

@property(nonatomic,strong)NSMutableArray *VauleArr;

@property(nonatomic,strong)NSMutableArray *payArr;

@property(nonatomic,strong)NSMutableArray *farray;//放field的数组

@property (nonatomic,weak) UIView *topView;

@property (weak, nonatomic) THDatePickerView *dateView;

@property(nonatomic,strong)NSString *datatype;

@property(nonatomic,strong)NSIndexPath *selectIndexPath;

@end

@implementation OnlineBookingViewController


-(NSMutableArray *)dataArr{
    
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}


-(NSMutableArray *)farray{
    
    if (!_farray) {
        _farray = [NSMutableArray array];
    }
    return _farray;
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
         [self createDatePicker];
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
     HHR = NO;
}



-(void)createAlter{
    
    _alterView = [[[NSBundle mainBundle]loadNibNamed:@"CustomAlterView" owner:self options:nil]lastObject];
    [_alterView setFrame:CGRectMake(0, 0, KSCREEN_WIDTH-64, KSCREEN_HEIGHT-280)];
    _alterView.btnBlcok = ^(UIButton *btn) {
        if (btn.tag == 400) {
            HHR = NO;
        }else{
            HHR = YES;
            [[QWAlertView sharedMask] dismiss];
        }
    };
    
    [self loadhtordersettlement];
}


//MARK:- 酒店入住须知
-(void)holehotel_need{
    
    NSString *url = [NSString stringWithFormat:@"%@%@",API_BASE_URL_STRING,hotel_need];
    
    [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:url params:nil complement:^(ServerResponseInfo * _Nullable serverInfo) {
        if ([serverInfo.response[@"code"] integerValue] == 200) {
            [self dismisView:serverInfo.response[@"data"]];
            
        }else if ([serverInfo.response[@"code"] integerValue] == 201){
            
        }else{
            [HUDManager showTextHud:loadError];
        }
        
    }];
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


//MARK:- 预定
-(void)loadorder {
    
    NSData * data1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"infoData"];
    userInfo * unmodel = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
    
    NSLog(@"token = %@",unmodel.token);
    
    NSString *url = [NSString stringWithFormat:@"%@%@",API_BASE_URL_STRING,add_order];
    
    
    HotelOrderModel *model = self.dataArr[0];
    HotelOrderModelList *list = model.listmodel;
    
    UITextField *name = [self.farray objectAtIndex:0];
    UITextField *phone = [self.farray objectAtIndex:1];
    
    OnlineTableViewCell *cell = [self.mTableView cellForRowAtIndexPath:self.selectIndexPath];
    
    [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:url params:@{@"uid":unmodel.uid,@"id":self.fjid,@"merchant_id":list.merchant_id,@"start_time":cell.rzdateLabel.text,@"end_time":cell.livedateLabel.text,@"real_name":name.text,@"mobile":phone.text,@"day_num":cell.contentLabel.text,@"num":@"1",@"pay_way":@"1",@"is_integral":[NSString stringWithFormat:@"%ld",selectIndexPaths]} complement:^(ServerResponseInfo * _Nullable serverInfo) {
        if ([serverInfo.response[@"code"] integerValue] == 200) {
            [self uploadWx:serverInfo.response[@"data"]];
        }else if ([serverInfo.response[@"code"] integerValue] == 201){
            
        }else{
            [HUDManager showTextHud:loadError];
        }
        
    }];
}


//MARK:-
-(void)loadhtordersettlement{
    
    NSData * data1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"infoData"];
    
    userInfo * unmodel = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",API_BASE_URL_STRING,htorder_settlement];
    
    NSString *nowStr = [NSObject getNowtime];
    NSString *nextStr = [NSObject getnextDate];
    
    [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:url params:@{@"uid":unmodel.uid,@"start":nowStr,@"end":nextStr,@"id":self.fjid} complement:^(ServerResponseInfo * _Nullable serverInfo) {
        if ([serverInfo.response[@"code"] integerValue] == 200) {
            NSDictionary *dict1 = serverInfo.response[@"data"];
            HotelOrderModel *model = [[HotelOrderModel alloc]initWithDict:dict1];
            [self.dataArr addObject:model];
            self.totalMomey.text = [NSString stringWithFormat:@"￥：%@",model.allprice];
            
        }else if ([serverInfo.response[@"code"] integerValue] == 201){
            
        }else{
            [HUDManager showTextHud:loadError];
        }
        
        [self.mTableView reloadData];
        
    }];
}


-(void)loadpayToServer {
    
    NSDictionary *dict = nil;
    NSString *url = [NSString stringWithFormat:@"%@%@",API_BASE_URL_STRING,order_pay];
    
    PaywayModel *model = self.payArr[selectIndexPaths];
    NSData * data1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"infoData"];
    userInfo *unmodel = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
    OrderlModel *Omodel = self.dataArr[0];
    
    if (self.issect) {
        dict = @{@"uid":unmodel.uid,@"sNo":Omodel.order_sn,@"pay_id":model.pid,@"is_integral":[NSString stringWithFormat:@"%ld",selectIndexPaths],@"puzzle_id":self.secDict[@"puzzle_id"],@"open_join":self.secDict[@"open_join"],@"group_id":self.secDict[@"group_id"]};
    }else{
        dict = @{@"uid":unmodel.uid,@"sNo":Omodel.order_sn,@"pay_id":model.pid,@"is_integral":[NSString stringWithFormat:@"%ld",selectIndexPaths]};
    }
    
    [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:url params:dict complement:^(ServerResponseInfo * _Nullable serverInfo) {
        
        if ([serverInfo.response[@"code"] integerValue] == 200) {
            
            NSDictionary *dict = serverInfo.response[@"data"];
            if (selectIndexPaths == 1) {
                [HUDManager showTextHud:serverInfo.response[@"msg"]];
            }else if (selectIndexPaths == 0){
                [self uploadWx:dict];
            }
            
        }else if ([serverInfo.response[@"code"] integerValue] == 201){
            [HUDManager showTextHud:serverInfo.response[@"msg"]];
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
        
        if (self.payType == 0){return [self.dataArr count];}
            
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
            
            if (self.payType == 0) {
                
                HotelOrderModel *model = self.dataArr[0];
                cell.listmodel1 = model;
                
            }else if (self.payType == 1){
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
            }else{
                
            }
            
        }
        
    }else if (indexPath.section == 1){
        if ([self.dataArr count] > 0) {
            
            if (self.payType == 0) {
                
                HotelOrderModel *model = self.dataArr[0];
                cell.listmodel1 = model;
                
                cell.selectblock = ^(UIButton * _Nonnull btn) {
                    
                    OnlineTableViewCell *mcell = (OnlineTableViewCell *)btn.superview.superview;
                    self.selectIndexPath = [self.mTableView indexPathForCell:mcell];
                    
                    if (btn.tag == 3000) {
//                        开始时间
                        self.datatype = @"1";
                    }else{
//                     结束时间
                        self.datatype = @"2";
                    }
                    [self dataPickerShow];
                };
                
            }else if (self.payType == 1){
                OrderlModel *model = self.dataArr[0];
                cell.modellist3 = model;
            }else{
                
            }
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
    
        NSArray *cellArr = self.mTableView.visibleCells;
        
        if ([_farray count] > 0) {
            [_farray removeAllObjects];
        }
        
        [cellArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            OnlineTableViewCell *cell = cellArr[idx];
            for (UITextField *f in cell.contentView.subviews) {
                if ([f isKindOfClass:[UITextField class]]) {
                    UITextField *field = (UITextField *)f;
                    [self.farray addObject:field];
                }
            }
        }];
        
        UITextField *namefield = [self.farray objectAtIndex:0];
        UITextField *phonefield = [self.farray objectAtIndex:1];
        NSString *msgStr = nil;
        
        if (!self.datatype) {
            msgStr = @"请选择入住时间和离开时间";
        }else if (namefield.text.length == 0){
            msgStr = @"请输入联系人姓名";
        }else if(phonefield.text.length == 0){
            msgStr = @"请输入联系人手机号码";
        }
        
        if (msgStr) {
            [HUDManager showTextHud:msgStr];
            return;
        }
        
        [self holehotel_need];
        
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


-(void)dismisView:(NSDictionary *)dict {
    
    [[QWAlertView sharedMask] show:_alterView withType:QWAlertViewStyleAlert animationFinish:^{
        [_alterView setHtlStr:dict[@"need_content"]];
    } dismissHandle:^{
        if ( HHR == YES) {
            [self loadorder];
        }
    }];
}


//MARK:-
- (void)handleSelectedButtonActionWithSelectedIndexPath:(NSIndexPath *)selectedIndexPath{
    if (selectedIndexPath.section == 2) {
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


//MARK: createDatePicker
-(void)createDatePicker {
    
    THDatePickerView *dateView = [[THDatePickerView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, KSCREEN_WIDTH, 300)];
    dateView.delegate = self;
    dateView.title = @"请选择时间";
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT-100)];
    [v setBackgroundColor:[UIColor grayColor]];
    [v setHidden:YES];
    [v setAlpha:0.4];
    self.topView = v;
    [self.view addSubview:v];
    self.dateView = dateView;
    [self.view addSubview:dateView];
    
}


//MARK:- datePicker
- (void)datePickerViewSaveBtnClickDelegate:(NSString *)timer {
    
    [UIView animateWithDuration:0.3 animations:^{
        self.dateView.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 300);
        [self.topView setHidden:YES];
    }];
    
    NSArray *array = [timer componentsSeparatedByString:@" "];
    
    OnlineTableViewCell *cell = [self.mTableView cellForRowAtIndexPath:self.selectIndexPath];
    
    if ([self.datatype isEqualToString:@"1"])
        
        cell.rzdateLabel.text = [NSString stringWithFormat:@"%@",array[0]];
    
    else if ([self.datatype isEqualToString:@"2"])
        cell.livedateLabel.text = [NSString stringWithFormat:@"%@",array[0]];
    else{}
    
    
    NSString *timeStr = [NSObject pleaseInsertStarTimeo:cell.rzdateLabel.text andInsertEndTime:cell.livedateLabel.text];
    
    if ([timeStr integerValue] > 0) {
        cell.contentLabel.text = [NSString stringWithFormat:@"%@晚",[NSObject pleaseInsertStarTimeo:cell.rzdateLabel.text andInsertEndTime:cell.livedateLabel.text]];
    }
    
}


// MARK:- 取消按钮代理方法
- (void)datePickerViewCancelBtnClickDelegate {
    
    [UIView animateWithDuration:0.3 animations:^{
        self.dateView.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 300);
        [self.topView setHidden:YES];
    }];
}


-(void)dataPickerShow{
    
    [UIView animateWithDuration:0.3 animations:^{
        self.dateView.frame = CGRectMake(0, self.view.height - 300, self.view.width, 300);
        [self.dateView show];
        [self.topView setHidden:NO];
    }];
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
