//
//  HotelOnlineViewController.m
//  OgrinterProduct
//
//  Created by wongshine on 2020/1/16.
//  Copyright © 2020 RXF. All rights reserved.
//

#define gourmet_dishtype @"gourmet/details"//饭店商家；


#import "HotelOnlineViewController.h"
#import "SDCycleScrollView.h"
#import "HotelBottomTableViewCell.h"
#import "HotelOnlineTableViewCell.h"
#import "HotelOnlineSubViewController.h"
#import "OnlineOrderModel.h"



@interface HotelOnlineViewController ()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate,FSPageContentViewDelegate,FSSegmentTitleViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *bannerbjView;

@property (weak, nonatomic) IBOutlet UITableView *mTableView;

@property (nonatomic, strong) HotelBottomTableViewCell *contentCell;

@property (nonatomic, assign) BOOL canScroll;

@property(nonatomic,strong)SDCycleScrollView *cycleScrollView;
@property (weak, nonatomic) IBOutlet UIImageView *topimgView;

@property(nonatomic,strong)NSMutableArray *dataArr;

@property (nonatomic, strong) FSSegmentTitleView *titleView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *Totop;

@end


@implementation HotelOnlineViewController


-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}


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
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.Totop.constant = kStatusBarAndNavigationBarH;
    
    self.mTableView.tableFooterView = [UILabel new];
    
    [self.mTableView registerNib:[UINib nibWithNibName:@"HotelDetilsTopViewCell" bundle:nil] forCellReuseIdentifier:@"HotelDetilsTopViewCell"];
    
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
        _contentCell.pageContentView = [[FSPageContentView alloc]initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT-kStatusBarAndNavigationBarH) childVCs:contentVCs parentVC:self delegate:self];
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


-(void)dealloc{
    KRemove_Observer(self);
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
