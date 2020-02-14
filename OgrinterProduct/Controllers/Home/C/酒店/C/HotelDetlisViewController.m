//
//  HotelDetlisViewController.m
//  OgrinterProduct
//
//  Created by wongshine on 2019/12/9.
//  Copyright © 2019 RXF. All rights reserved.
//

#define details_list @"details/list"


#import "HotelDetlisViewController.h"
#import "HotelBottomTableViewCell.h"
#import "HotelDetlisSubViewOneController.h"
#import "SDCycleScrollView.h"

#import "HotelDetilsTopViewCell.h"
#import "FSScrollContentView.h"
#import "HolelModel.h"



@interface HotelDetlisViewController ()<UITableViewDelegate,UITableViewDataSource,FSPageContentViewDelegate,FSSegmentTitleViewDelegate,SDCycleScrollViewDelegate>


@property (weak, nonatomic) IBOutlet UITableView *mTableView;

@property (nonatomic, assign) BOOL canScroll;
@property (nonatomic, strong) FSSegmentTitleView *titleView;
@property (nonatomic, strong) HotelBottomTableViewCell *contentCell;
@property(nonatomic,strong)SDCycleScrollView *cycleScrollView;

@property (nonatomic,strong)NSArray *VcStrArr;
@property(nonatomic,strong)NSMutableArray *dataArr;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toTop;

@end


@implementation HotelDetlisViewController


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
    
    
    KAdd_Observer(@"leaveTop", self, changeScrollStatus, nil);
    self.toTop.constant = kStatusBarAndNavigationBarH;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self setup];
    // Do any additional setup after loading the view from its nib.
}


-(void)setup{
    
    self.canScroll = YES;
    
    self.mTableView.tableFooterView = [UILabel new];
    
    self.mTableView.tableHeaderView = self.cycleScrollView;
    
    [self.mTableView registerNib:[UINib nibWithNibName:@"HotelDetilsTopViewCell" bundle:nil] forCellReuseIdentifier:@"HotelDetilsTopViewCell"];

    
    __weak typeof(self) weakSelf = self;
    self.mTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf insertRowAtTop];
    }];

    [self loadNetWork];
}


-(void)loadNetWork{
    
    NSString *url = [NSString stringWithFormat:@"%@%@",API_BASE_URL_STRING,details_list];
    
    NSString *uidStr = nil;
    
    NSData * data1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"infoData"];
    userInfo * unmodel = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
    
    if (unmodel.token)
        uidStr = unmodel.uid;
    else
        uidStr = @"";
    
    
    [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:url params:@{@"id":self.jid,@"uid":uidStr} complement:^(ServerResponseInfo * _Nullable serverInfo) {
        if ([serverInfo.response[@"code"] integerValue] == 200) {
            if ([_dataArr count] > 0)
                [_dataArr removeAllObjects];
            
            HolelModel *model = [[HolelModel alloc]initWithDict:serverInfo.response[@"data"]];
            [self.dataArr addObject:model];
            self.cycleScrollView.imageURLStringsGroup = model.facilities;
            
            [self.mTableView reloadData];
            
        }else {
            [HUDManager showTextHud:loadError];
        }
    }];
}


/*!insertRowAtTop */
- (void)insertRowAtTop {
    self.contentCell.currentTagStr = HotelDetailsListArr[self.titleView.selectIndex];
    self.contentCell.isRefresh = YES;
    [self.mTableView.mj_header endRefreshing];
}


-(void)changeScrollStatus {
    self.canScroll = YES;
    self.contentCell.cellCanScroll = NO;
}


//MARK:- UITableView
#pragma mark UITableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1)
        return 1;
    return 1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 196;
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
    self.titleView = [[FSSegmentTitleView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 50) titles:HotelDetailsListArr delegate:self indicatorType:FSIndicatorTypeEqualTitle];
    
    self.titleView.backgroundColor = KSRGBA(255, 255, 255, 255);
    
    return self.titleView;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        HotelDetilsTopViewCell *cell = [HotelDetilsTopViewCell tempTableViewCellWith:self.mTableView indexPath:indexPath];
        if ([self.dataArr count] > 0) {
            HolelModel *model = self.dataArr[0];
            cell.listModel = model;
        }
        
        [cell configTempCellWith:indexPath];
        
        return cell;
    }
    
    if (indexPath.section == 1) {
        
        _contentCell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        
        if (!_contentCell) {
            _contentCell = [[HotelBottomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell" withtype:HotelBottomTableViewCellTypeOne];
            _contentCell.contentView.backgroundColor = [UIColor whiteColor];
        }
        
        NSMutableArray *contentVCs = [NSMutableArray array];
        
        for (int i = 0 ; i < HotelDetailsListArr.count; i++) {
            if ([_dataArr count]) {
                HolelModel *model = _dataArr[0];
                HotelDetlisSubViewOneController *vc = [[HotelDetlisSubViewOneController alloc]init];
                vc.title = HotelDetailsListArr[i];
                vc.str = vc.title;
                vc.sid = model.jdid;
                vc.desc = model.desc;
                
                if (i == HotelDetailsListArr.count-1)
                    vc.imgArr = [NSArray arrayWithArray:model.facilities];
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



//MARK:- dealloc
-(void)dealloc {
    KRemove_Observer(self);
}



//#pragma mark - vc push
//-(UIViewController *)pushViewControllerWithString:(NSString *)nameStr{
//    Class class = NSClassFromString(nameStr);
//    UIViewController *vc = [[class alloc]initWithNibName:nameStr bundle:nil];
//
//    return vc;
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
