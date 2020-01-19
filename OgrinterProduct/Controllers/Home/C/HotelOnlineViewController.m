//
//  HotelOnlineViewController.m
//  OgrinterProduct
//
//  Created by wongshine on 2020/1/16.
//  Copyright © 2020 RXF. All rights reserved.
//

#define gourmet_dishtype @"gourmet/details"//饭店商家；

#define gourmet_booking @"gourmet/booking"//获取购物车列表


#import "HotelOnlineViewController.h"
#import "SDCycleScrollView.h"
#import "HotelBottomTableViewCell.h"
#import "HotelOnlineTableViewCell.h"
#import "HotelOnlineSubViewController.h"
#import "OnlineOrderModel.h"
#import "RCarlistView.h"
#import "OnlineOrderListModel.h"
#import "HotelOnlinesListModel.h"




@interface HotelOnlineViewController ()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate,FSPageContentViewDelegate,FSSegmentTitleViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *bannerbjView;

@property (weak, nonatomic) IBOutlet UITableView *mTableView;

@property (nonatomic, strong) HotelBottomTableViewCell *contentCell;

@property (nonatomic, assign) BOOL canScroll;
@property (weak, nonatomic) IBOutlet UILabel *numberLable;
@property (weak, nonatomic) IBOutlet UILabel *tatolnoney;

@property(nonatomic,strong)SDCycleScrollView *cycleScrollView;
@property (weak, nonatomic) IBOutlet UIImageView *topimgView;

@property(nonatomic,strong)NSMutableArray *dataArr;

//@property(nonatomic,strong)NSMutableArray *carArr;

@property (nonatomic, strong) FSSegmentTitleView *titleView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *Totop;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@property (weak, nonatomic) IBOutlet UIView *cartbjVew;

@property(nonatomic,strong)RCarlistView *listView;//h购物车列表
@property(nonatomic,strong)NSArray *caArr;

@property (nonatomic,weak)UIButton *bjbtn;

@end


@implementation HotelOnlineViewController


-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}


//-(NSMutableArray *)carArr{
//    if (!_carArr) {
//        _carArr = [NSMutableArray array];
//    }
//    return _carArr;
//}


//MARK:- cycleScrollView
-(SDCycleScrollView *) cycleScrollView{
    if (!_cycleScrollView){
        
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 168) delegate:self placeholderImage:nil];
        
        _cycleScrollView.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _cycleScrollView.autoScrollTimeInterval = 2.0;
        
    }
    return _cycleScrollView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
    [self loadNetWork];
    // Do any additional setup after loading the view from its nib.
}


-(void)setup{
    self.navigationItem.title = self.sname;
    
    self.canScroll = YES;
    
   KAdd_Observer(@"HotelTop", self, changeStatus, nil);
    KAdd_Observer(@"addCarNoft", self, Refnomey:, nil);
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.Totop.constant = kStatusBarAndNavigationBarH;
    
    self.mTableView.tableFooterView = [UILabel new];
    
    [self.mTableView registerNib:[UINib nibWithNibName:@"HotelDetilsTopViewCell" bundle:nil] forCellReuseIdentifier:@"HotelDetilsTopViewCell"];
    
    self.cartbjVew.layer.cornerRadius = 25;
    self.numberLable.layer.cornerRadius = 9;
    self.numberLable.layer.masksToBounds = YES;
    
    [self addlistView];
}


-(void)addlistView{
    
    UIButton *btn = [self createbtn:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT-256) Action:@selector(dissView:) BackGroundColor:[UIColor colorWithWhite:0.4 alpha:0.4]];
    
    [btn setHidden:YES];
    
    [self.view addSubview:self.bjbtn = btn];
    
    _listView = [[NSBundle mainBundle]loadNibNamed:@"RCarlistView" owner:self options:nil].lastObject;
    [_listView setFrame:CGRectMake(0, KSCREEN_HEIGHT, KSCREEN_WIDTH, 280)];
    [self.view addSubview:_listView];
    
    [self.view bringSubviewToFront:self.bottomView];
}





//MARK:- loadNetWork
-(void)loadNetWork{
    
    NSData * data1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"infoData"];
    userInfo * unmodel = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
    
    [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:[NSString stringWithFormat:@"%@%@",API_BASE_URL_STRING,gourmet_dishtype] params:@{@"id":self.sid,@"uid":unmodel.uid} complement:^(ServerResponseInfo * _Nullable serverInfo) {
        
        if ([serverInfo.response[@"code"] integerValue] == 200) {
            if ([_dataArr count] > 0)
                [self.dataArr removeAllObjects];
            
            NSDictionary *dict = serverInfo.response[@"data"];
            OnlineOrderModel *model = [[OnlineOrderModel alloc]initWithDict:dict];
            [self.dataArr addObject:model];
            [self.topimgView sd_setImageWithURL:[NSURL URLWithString:model.door_img] placeholderImage:nil];
            
        }else {
            [HUDManager showTextHud:loadError];
        }
        [self.mTableView reloadData];
//        [self.mTableView.mj_header endRefreshing];
    }];
}


//MARK:- 购物车列表
-(void)gourmetbooking {
    
    NSData * data1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"infoData"];
    userInfo * unmodel = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
    
    [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:[NSString stringWithFormat:@"%@%@",API_BASE_URL_STRING,gourmet_booking] params:@{@"merchant_id":self.sid,@"user_id":unmodel.uid} complement:^(ServerResponseInfo * _Nullable serverInfo) {
        
        if ([serverInfo.response[@"code"] integerValue] == 200) {
            
            NSArray *array = serverInfo.response[@"data"];
            NSMutableArray *mArr = [NSMutableArray array];
            for (int i = 0; i < [array count]; i ++ ) {
                
                NSDictionary *d = array[i];
                HotelOnlinesListModel *mod = [[HotelOnlinesListModel alloc]init];
                mod.hid = [NSString stringWithFormat:@"%@",d[@"id"]];
                mod.munbert = [NSString stringWithFormat:@"%@",d[@"num"]];
                mod.hname = [NSString stringWithFormat:@"%@",d[@"name"]];
                mod.price = [NSString stringWithFormat:@"%@",d[@"price"]];
                
                [mArr addObject:mod];
            }
            
            self.caArr = [NSArray arrayWithArray:mArr];
            [_listView setDArr:self.caArr];
            
        }else {
            [HUDManager showTextHud:loadError];
        }
//
        //        [self.mTableView.mj_header endRefreshing];
    }];
}


-(void)changeStatus{
    self.canScroll = YES;
    self.contentCell.cellCanScroll = NO;
}

//MARK:- table
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1)
        return 1;
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 64;
    }else if (indexPath.section == 1)
        return KSCREEN_HEIGHT-kStatusBarAndNavigationBarH;
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    }
    return 50;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    self.titleView = [[FSSegmentTitleView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 50) titles:HotelDetalsListArr delegate:self indicatorType:FSIndicatorTypeEqualTitle];
    
    self.titleView.backgroundColor = KSRGBA(255, 255, 255, 255);
    
    return self.titleView;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        HotelOnlineTableViewCell *cell = [HotelOnlineTableViewCell tempTableViewCellWith:self.mTableView indexPath:indexPath];
        
        [cell configTempCellWith:indexPath];
        
        if ([_dataArr count] > 0) {
            OnlineOrderModel *model = self.dataArr[0];
            cell.listmodel = model;
        }
        
        return cell;
    }
    
    if (indexPath.section == 1) {
        
        _contentCell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        
        if (!_contentCell) {
            _contentCell = [[HotelBottomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell" withtype:HotelBottomTableViewCellTypeThrid];
            _contentCell.contentView.backgroundColor = [UIColor whiteColor];
        }
        
        NSMutableArray *contentVCs = [NSMutableArray array];
        
        for (int i = 0 ; i < HotelDetalsListArr.count; i++) {
            if ([_dataArr count]) {
                OnlineOrderModel *model = _dataArr[0];
                HotelOnlineSubViewController *vc = [[HotelOnlineSubViewController alloc]init];
                vc.title = HotelDetalsListArr[i];
                vc.str = vc.title;
                vc.merchants_id = model.oid;
                [contentVCs addObject:vc];
            }
        }
        _contentCell.viewControllers = contentVCs;
        _contentCell.pageContentView = [[FSPageContentView alloc]initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT-kStatusBarAndNavigationBarH-114) childVCs:contentVCs parentVC:self delegate:self];
        [_contentCell.contentView addSubview:_contentCell.pageContentView];
        
        return _contentCell;
    }
    
    return nil;
}


//MARK:- FSSegmentTitleViewDelegate
- (void)FSContenViewDidEndDecelerating:(FSPageContentView *)contentView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex {
    self.titleView.selectIndex = endIndex;
    self.mTableView.scrollEnabled = YES;//此处其实是监测scrollview滚动，pageView滚动结束主tableview可以滑动，或者通过手势监听或者kvo，这里只是提供一种实现方式
}


- (void)FSSegmentTitleView:(FSSegmentTitleView *)titleView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex{
    self.contentCell.pageContentView.contentViewCurrentIndex = endIndex;
}


- (void)FSContentViewDidScroll:(FSPageContentView *)contentView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex progress:(CGFloat)progress{
    self.mTableView.scrollEnabled = NO;//pageView开始滚动主tableview禁止滑动
}


#pragma mark UIScrollView
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat bottomCellOffset = [self.mTableView rectForSection:1].origin.y;
    if (scrollView.contentOffset.y >= bottomCellOffset) {
        scrollView.contentOffset = CGPointMake(0, bottomCellOffset);
        if (self.canScroll) {
            self.canScroll = NO;
            self.contentCell.cellCanScroll = YES;
        }
    }else{
        if (!self.canScroll) {//子视图没到顶部
            scrollView.contentOffset = CGPointMake(0, bottomCellOffset);
        }
    }
    self.mTableView.showsVerticalScrollIndicator = _canScroll?YES:NO;
}



//MARK:- 去下单
- (IBAction)togoPay:(UIButton *)sender {
    
}

//MARK:- 购物车列表View
- (IBAction)carlistclick:(UIButton *)sender {
    KPreventRepeatClickTime(1)
    [self showView];
}



-(void)Refnomey:(NSNotification *)not{
    
    self.numberLable.text = [NSString stringWithFormat:@"%@",not.userInfo[@"num"]];
    self.tatolnoney.text = [NSString stringWithFormat:@"￥：%@",not.userInfo[@"nomey"]];
}



-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"HotelTop" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"addCarNoft" object:nil];
}


-(UIButton *)createbtn:(CGRect)rect Action:(SEL)action BackGroundColor:(UIColor *)color{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:rect];
    
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    if (color)
        [btn setBackgroundColor:color];
    
    return btn;
}


//MARK:- view消失
-(void)dissView:(NSString *)type{
    
    [UIView animateWithDuration:0.3 animations:^{
        _listView.frame = CGRectMake(0, KSCREEN_HEIGHT, KSCREEN_WIDTH, 280);
        [self.bjbtn setHidden:YES];
        
    } completion:^(BOOL finished) {
//        if ([type isKindOfClass:[UIButton class]])
//            return;
//        else
//            [self loadOrderNetWork:self.ggDict type:type];
    }];
}


-(void)showView{
    
    [UIView animateWithDuration:0.3 animations:^{
        _listView.frame = CGRectMake(0, KSCREEN_HEIGHT-280, self.view.frame.size.width, 280);
        [self.bjbtn setHidden:NO];
    } completion:^(BOOL finished) {
        [self gourmetbooking];
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
