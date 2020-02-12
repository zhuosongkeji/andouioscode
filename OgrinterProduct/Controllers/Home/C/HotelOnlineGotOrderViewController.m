//
//  HotelOnlineGotOrderViewController.m
//  OgrinterProduct
//
//  Created by wongshine on 2020/1/18.
//  Copyright © 2020 RXF. All rights reserved.
//


#define gourmet_reserve @"gourmet/reserve"//菜品详情列表

#define commonpay_ways @"common/pay_ways"

#define gourmet_timely @"gourmet/timely"//下单


#import "HotelOnlineGotOrderViewController.h"
#import "HotelOnlineOrderTableViewCell.h"
#import "HotelOnlinesListModel.h"
#import "PaywayModel.h"
#import <WechatOpenSDK/WXApi.h>
#import "PaySuccessViewController.h"
//#import "THDatePickerView.h"



@interface HotelOnlineGotOrderViewController ()<HotelOnlineOrderTableViewCellDelegate,UITableViewDelegate,UITableViewDataSource>{
    NSInteger selectIndexPaths;
    BOOL isShowMore;
    NSInteger pnumber;
}
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toTop;

@property (weak, nonatomic) IBOutlet UITableView *mTableView;

@property(nonatomic,strong)NSMutableArray *dataArr;

@property(nonatomic,strong)NSMutableArray *OthArr;

@property(nonatomic,strong)NSMutableArray *payArr;

@property(nonatomic,weak)UIButton *moreBtn;
@property (nonatomic,weak) UIView *topView;

@property (assign, nonatomic) NSIndexPath *selectedIndexPath;//单选，当前选中的行

@property(nonatomic,strong)UIDatePicker *pickerView;

@property(nonatomic,strong)UIView *bjView;

@property (nonatomic,weak)UIButton *bjbtn;

@property (weak, nonatomic) IBOutlet UILabel *totalmaney;

@property(nonatomic,strong)NSString *timeStr;

@property(nonatomic,strong)NSString *payStatue;

@end

@implementation HotelOnlineGotOrderViewController


-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

-(NSMutableArray *)OthArr{
    if (!_OthArr) {
        _OthArr = [NSMutableArray array];
    }
    return _OthArr;
}


-(NSMutableArray *)payArr{
    if (!_payArr) {
        _payArr = [NSMutableArray array];
    }
    return _payArr;
}

-(UIView *)bjView {
    
    if (!_bjView) {
        
        _bjView = [[UIView alloc]initWithFrame:CGRectMake(0, KSCREEN_HEIGHT, KSCREEN_WIDTH, 310)];
        _bjView.backgroundColor = UIColor.whiteColor;
        
        _pickerView = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 12, KSCREEN_WIDTH, 280)];
        _pickerView.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
        _pickerView.datePickerMode = UIDatePickerModeCountDownTimer;
        // 设置当前显示时间
        [_pickerView setDate:[NSDate date] animated:YES];
        
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        
        NSDateComponents *comps = [[NSDateComponents alloc] init];
        [comps setDay:7];
        
        NSDate *maxDate = [calendar dateByAddingComponents:comps toDate:[NSDate date] options:0];
        // 设置显示最大时间（此处为当前时间）
        [_pickerView setMinimumDate:[NSDate date]];
        [_pickerView setMaximumDate:maxDate];
        
        //设置时间格式
        _pickerView.datePickerMode = UIDatePickerModeDateAndTime;
        //监听DataPicker的滚动
        [_pickerView addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventValueChanged];
        
        [_bjView addSubview:_pickerView];
    }
    return _bjView;
    
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self scrollViewDidScroll:self.mTableView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setup];
    [self loadNetWork];
    [self commonpayways];
    // Do any additional setup after loading the view from its nib.
}


-(void)setup{
    
    
    self.toTop.constant = kStatusBarAndNavigationBarH;
    
    KAdd_Observer(@"paySuccess", self, paySuccessGotPush, nil);
    isShowMore = NO;pnumber = 1;
    self.mTableView.tableFooterView = [UILabel new];
    
    [self.mTableView registerNib:[UINib nibWithNibName:@"HotelOnlineOrderTableViewCell" bundle:nil] forCellReuseIdentifier:@"HotelOnlineOrderTableViewCell"];
    
    UIButton *btn = [self createbtn:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT-256) Action:@selector(dismis) BackGroundColor:[UIColor colorWithWhite:0.4 alpha:0.4]];
    
    [btn setHidden:YES];
    [self.view addSubview:self.bjbtn = btn];
    [self.view addSubview:self.bjView];

}


- (NSString*)weekdayStringFromDate:(NSDate*)inputDate {
    
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSWeekdayCalendarUnit;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    
    return [weekdays objectAtIndex:theComponents.weekday];
    
}


//MARK:- loadNetWork
-(void)loadNetWork{
    
    NSData * data1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"infoData"];
    userInfo * unmodel = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
    
    [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:[NSString stringWithFormat:@"%@%@",API_BASE_URL_STRING,gourmet_reserve] params:@{@"uid":unmodel.uid,@"merchant_id":self.merchants_id} complement:^(ServerResponseInfo * _Nullable serverInfo) {
        if ([serverInfo.response[@"code"] integerValue] == 200) {
            
            NSDictionary *dict = serverInfo.response[@"data"];
            
            NSArray *array = dict[@"foods"];
            
            for (int i = 0; i < [array count]; i ++) {
                NSDictionary *d = array[i];
                
                HotelOnlinesListModel *model = [[HotelOnlinesListModel alloc]init];
                model.hname = [NSString stringWithFormat:@"%@",d[@"name"]];
                model.price = [NSString stringWithFormat:@"%@",d[@"price"]];
                model.munbert = [NSString stringWithFormat:@"%@",d[@"num"]];
                model.image = [NSString stringWithFormat:@"%@%@",imgServer,d[@"image"]];
                
                [self.dataArr addObject:model];
            }
            
            HotelOnlinesListModel *model = [[HotelOnlinesListModel alloc]init];
            model.all = [NSString stringWithFormat:@"%@",dict[@"all"]];
            model.Tname = [NSString stringWithFormat:@"%@",dict[@"name"]];
            model.integral = [NSString stringWithFormat:@"%@",dict[@"integral"]];
            [self.OthArr addObject:model];
            
            [self.mTableView reloadData];
        }else {
            [HUDManager showTextHud:loadError];
        }
    }];
}

//MARK:- 下单
-(void)gotoOrderHotel:(NSDictionary *)dict{

    [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:[NSString stringWithFormat:@"%@%@",API_BASE_URL_STRING,gourmet_timely] params:dict complement:^(ServerResponseInfo * _Nullable serverInfo) {
        if ([serverInfo.response[@"code"] integerValue] == 200) {
            
            if ([serverInfo.response[@"msg"] isEqualToString:@"预定成功"]) {
                [self paySuccessGotPush];
            }else{
                
                NSDictionary *wdic = serverInfo.response[@"data"];
                [self uploadWx:wdic];
            }
            
        }else if ([serverInfo.response[@"code"] integerValue] == 201){
            
        }else
            [HUDManager showTextHud:loadError];
        
    }];
}

//MARK:- 获取支付方式
-(void)commonpayways{
    
    
    [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:[NSString stringWithFormat:@"%@%@",API_BASE_URL_STRING,commonpay_ways] params:nil complement:^(ServerResponseInfo * _Nullable serverInfo) {
        if ([serverInfo.response[@"code"] integerValue] == 200) {
            
            NSArray *array = serverInfo.response[@"data"];
            for (int i = 0; i < [array count]; i ++) {
                PaywayModel *model = [[PaywayModel alloc]initWithDict:array[i]];
                [self.payArr addObject:model];
            }
        }else if ([serverInfo.response[@"code"] integerValue] == 201){
            
        }else{
            [HUDManager showTextHud:loadError];
        }
       
        [self.mTableView reloadData];
    }];
}



//MARK:- tableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0){
        
        if ([self.dataArr count]<=3)
            return [self.dataArr count];
        else
            if (isShowMore)
                return [self.dataArr count];
            else
                return 3;
        
    }else if (section == 1)
        return 1;
    else if (section == 2)
        return 4;
    else if (section == 3)
        return 1;
    else if (section == 4)
        return [self.payArr count];
    return 0;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HotelOnlineOrderTableViewCell *cell = [HotelOnlineOrderTableViewCell tempTableViewCellWith:tableView indexPath:indexPath];
    [cell configTempCellWith:indexPath];
    
    cell.delegate = self;
    
    if (indexPath.section == 0) {
        if ([_dataArr count] > 0) {
            HotelOnlinesListModel *model = self.dataArr[indexPath.row];
            cell.listmodel = model;
        }
    }else if (indexPath.section == 1){
        if ([_dataArr count] > 0) {
            [cell setTaday:[self weekdayStringFromDate:[NSDate date]]];
        }
    }else if (indexPath.section == 2){
        if ([_OthArr count] > 0) {
            HotelOnlinesListModel *model = self.OthArr[0];
            cell.gnlable.text = model.integral;
            
        }
    }else if (indexPath.section == 3){
        if ([_dataArr count] > 0) {
            
            if ([_OthArr count] > 0) {
                HotelOnlinesListModel *model = self.OthArr[0];
                cell.taotltitlLable.text = [NSString stringWithFormat:@"共%ld个商品(合计)",[self.dataArr count]];
                cell.tatolPrice.text = [NSString stringWithFormat:@"￥%@",model.all];
                cell.tatolPriceo.text = [NSString stringWithFormat:@"合计：￥%@",model.all];
                
            }
        }
    }
    
    else if (indexPath.section == 4){
        
        cell.selectedIndexPath = indexPath;
        if (_selectedIndexPath == indexPath){
            cell.pBtn.selected = YES;
        }else
            cell.pBtn.selected = NO;
        
        if ([_payArr count]> 0) {
            PaywayModel *model = self.payArr[indexPath.row];
            cell.modellist = model;
        }
    }
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSLog(@"%ld%ld",indexPath.section,indexPath.row);
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 105;
    }else if (indexPath.section == 1){
        return 181;
    }else if (indexPath.section == 2){
        if (indexPath.row == 3)
            return 60;
        return 44;
    }else if(indexPath.section == 3){
        return 108;
    }else{
        return 50;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *v = [[UIView alloc]init];
    UILabel *lable = [UILabel new];
    lable.textColor = UIColor.blackColor;
    lable.font = [UIFont systemFontOfSize:14];
    
    [v setBackgroundColor:UIColor.whiteColor];
    
    if (section == 0) {
        [v setFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 44)];
        [lable setFrame:CGRectMake(12, 12, KSCREEN_WIDTH-24, 20)];
        lable.text = @"商家菜品";
    }else if (section == 1){
        [v setFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 44)];
        [lable setFrame:CGRectMake(12, 12, KSCREEN_WIDTH-24, 20)];
        lable.text = @"可预约时间";
    }else if (section == 2){
        
    }else if (section == 3){
        
    }else if (section == 4){
        [v setFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 44)];
        [lable setFrame:CGRectMake(12, 12, KSCREEN_WIDTH-24, 20)];
        lable.text = @"请选择支付方式";
    }
              
    [v addSubview:lable];
    
    return v;
}


-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 0) {
        
        if ([self.dataArr count] <= 3) {
            
        }else{
            UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 30)];
            
            v.backgroundColor = UIColor.whiteColor;
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            
            if (isShowMore)
                [btn setTitle:@"收起" forState:0];
            else
                [btn setTitle:@"显示全部" forState:0];
            
            btn.titleLabel.font = [UIFont systemFontOfSize:12];
            [btn setTitleColor:[UIColor lightGrayColor] forState:0];
            [btn setFrame:CGRectMake(0, 0, 106, 30)];
            btn.center = v.center;
            
            [btn addTarget:self action:@selector(Action:) forControlEvents:UIControlEventTouchUpInside];
            
            [v addSubview:self.moreBtn = btn];
            
            return v;
        }
    }
    return nil;
}


-(void)Action:(UIButton *)btn{
    isShowMore = !isShowMore;
    [self.mTableView reloadData];
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 30;
    }else{
        return 0;
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0 || section == 1|| section == 4) {
        return 44;
    }
    return 8;
}


//MARK:-cellDelegate
- (void)handleSelectedSelectedIndexPath:(NSIndexPath *)selectedIndexPath{
    if (selectedIndexPath.section == 4) {
        HotelOnlineOrderTableViewCell *celled = [self.mTableView cellForRowAtIndexPath:_selectedIndexPath];
        celled.pBtn.selected = NO;
        //记录当前选中的位置索引
        _selectedIndexPath = selectedIndexPath;
        //当前选择的打勾
        HotelOnlineOrderTableViewCell *cell = [self.mTableView cellForRowAtIndexPath:selectedIndexPath];
        cell.pBtn.selected = YES;
        selectIndexPaths = selectedIndexPath.row;
        PaywayModel *model = self.payArr[selectedIndexPath.row];
            self.payStatue = model.pid;
    }
}


- (IBAction)gotoOrder:(UIButton *)sender {
    
    NSData * data1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"infoData"];
    userInfo * unmodel = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
    
    if (!self.timeStr) {
        [HUDManager showTextHud:@"请选择时间"];
        return;
    }else if (!self.payStatue){
        [HUDManager showTextHud:@"请选择支付方式"];
        return;
    }else{}
    
    NSDictionary *dict = @{@"uid":unmodel.uid,@"merchant_id":self.merchants_id,@"people":@(pnumber),@"remark":@"",@"dinnertime":self.timeStr,@"method":self.payStatue,@"is_integral":@"0"};
    
    [self gotoOrderHotel:dict];
    
}



-(void)selectDataker:(UIButton *)btn{
    if (btn.tag == 300) {
        pnumber-=1;
        if (pnumber<=0) {
            pnumber = 1;
        }
    }else if (btn.tag == 301){
        pnumber+=1;
    }else{
        [self show];
    }
    if (btn.tag < 300)
        return;
    
    HotelOnlineOrderTableViewCell *cell = (HotelOnlineOrderTableViewCell *)btn.superview.superview;
    cell.numberplable.text = [NSString stringWithFormat:@"%ld人",pnumber];
}


-(void)show{
    [UIView animateWithDuration:0.3 animations:^{
        [_bjView setFrame:CGRectMake(0, KSCREEN_HEIGHT-310, KSCREEN_WIDTH, KSCREEN_HEIGHT-310)];
        [self.bjbtn setHidden:NO];
    } completion:^(BOOL finished) {
        
    }];
}


-(void)dismis{
    [UIView animateWithDuration:0.3 animations:^{
        [_bjView setFrame:CGRectMake(0, KSCREEN_HEIGHT, KSCREEN_WIDTH, KSCREEN_HEIGHT-310)];
        [self.bjbtn setHidden:YES];
    } completion:^(BOOL finished) {
        
    }];
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.mTableView){
        UITableView *tableview = (UITableView *)scrollView;
        CGFloat sectionHeaderH = 44;
        CGFloat sectionFooterH = 30;
        CGFloat offsetY = tableview.contentOffset.y;
        if (offsetY >= 0 && offsetY <= sectionHeaderH)
        {
            tableview.contentInset = UIEdgeInsetsMake(-offsetY, 0, -sectionFooterH, 0);
            
        }else if (offsetY >= sectionHeaderH && offsetY <= tableview.contentSize.height - tableview.frame.size.height - sectionFooterH)
        {
            tableview.contentInset = UIEdgeInsetsMake(-sectionHeaderH, 0, -sectionFooterH, 0);
        }else if (offsetY >= tableview.contentSize.height - tableview.frame.size.height - sectionFooterH && offsetY <= tableview.contentSize.height - tableview.frame.size.height)
        {
            tableview.contentInset = UIEdgeInsetsMake(-offsetY, 0, -(tableview.contentSize.height - tableview.frame.size.height - sectionFooterH), 0);
        }
    }
}


- (void)dateChange:(UIDatePicker *)datePicker {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //设置时间格式
    formatter.dateFormat = @"YYYY-MM-DD hh:mm:ss";
    NSString *dateStr = [formatter  stringFromDate:datePicker.date];
    self.timeStr = dateStr;
}


-(UIButton *)createbtn:(CGRect)rect Action:(SEL)action BackGroundColor:(UIColor *)color{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:rect];
    
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    if (color)
        [btn setBackgroundColor:color];
    
    return btn;
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


-(void)paySuccessGotPush{
    PaySuccessViewController *pay = [[PaySuccessViewController alloc]init];
    [self.navigationController pushViewController:pay animated:YES];
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
