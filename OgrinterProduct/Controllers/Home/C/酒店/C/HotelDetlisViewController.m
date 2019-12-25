//
//  HotelDetlisViewController.m
//  OgrinterProduct
//
//  Created by wongshine on 2019/12/9.
//  Copyright © 2019 RXF. All rights reserved.
//


#import "HotelDetlisViewController.h"
#import "HotelBottomTableViewCell.h"
#import "HotelDetlisSubViewOneController.h"
#import "HotelDetilsTopViewCell.h"
#import "FSScrollContentView.h"



@interface HotelDetlisViewController ()<UITableViewDelegate,UITableViewDataSource,FSPageContentViewDelegate,FSSegmentTitleViewDelegate>


@property (weak, nonatomic) IBOutlet UITableView *mTableView;


@property (nonatomic, assign) BOOL canScroll;


@property (nonatomic, strong) FSSegmentTitleView *titleView;

@property (nonatomic, strong) HotelBottomTableViewCell *contentCell;


@property (nonatomic,strong)NSArray *VcStrArr;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toTop;

@end


@implementation HotelDetlisViewController

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
    
    [self.mTableView registerNib:[UINib nibWithNibName:@"HotelDetilsTopViewCell" bundle:nil] forCellReuseIdentifier:@"HotelDetilsTopViewCell"];

    
    __weak typeof(self) weakSelf = self;
    self.mTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf insertRowAtTop];
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
    if (section == 1) {
        return 1;
    }
    return 2;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 168;
        }
        return 196;
    }else if (indexPath.section == 1){
        return KSCREEN_HEIGHT-kStatusBarAndNavigationBarH;
    }
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
        
        [cell configTempCellWith:indexPath];
        
        return cell;
    }
    
    if (indexPath.section == 1) {
        _contentCell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        
        if (!_contentCell) {
            
            _contentCell = [[HotelBottomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell" withtype:HotelBottomTableViewCellTypeOne];
            _contentCell.contentView.backgroundColor = [UIColor redColor];
            
            NSMutableArray *contentVCs = [NSMutableArray array];
            for (int i = 0 ; i < HotelDetailsListArr.count; i++) {
                HotelDetlisSubViewOneController *vc = [[HotelDetlisSubViewOneController alloc]init];
                vc.title = HotelDetailsListArr[i];
                vc.str = vc.title;
                
                [contentVCs addObject:vc];
            }
            _contentCell.viewControllers = contentVCs;
            _contentCell.pageContentView = [[FSPageContentView alloc]initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT-kStatusBarAndNavigationBarH) childVCs:contentVCs parentVC:self delegate:self];
            [_contentCell.contentView addSubview:_contentCell.pageContentView];
        }
        
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
