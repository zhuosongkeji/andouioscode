//
//  ShopSeckillDetailsViewController.m
//  OgrinterProduct
//
//  Created by wongshine on 2019/12/12.
//  Copyright © 2019 RXF. All rights reserved.
//


#import "ShopSeckillDetailsViewController.h"
#import "ShopSeckillDetailsSubViewController.h"
#import "ShopShopkeeperViewController.h"
#import "QCouponView.h"
#import "SeckillTableViewCell.h"
#import "HotelBottomTableViewCell.h"
#import "FSScrollContentView.h"
#import "SDCycleScrollView.h"



@interface ShopSeckillDetailsViewController ()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate,FSPageContentViewDelegate,FSSegmentTitleViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *mTableView;
@property (weak, nonatomic) IBOutlet UIView *topBannerbjView;
@property (weak, nonatomic) IBOutlet UILabel *YPrice;//优惠价格
@property (weak, nonatomic) IBOutlet UILabel *SPrice;//实际价格
@property (weak, nonatomic) IBOutlet UILabel *dowuplable;//倒计时
@property (weak, nonatomic) IBOutlet UILabel *bannernumLable;
@property (weak, nonatomic) IBOutlet UILabel *cpcontent;//产品说明
@property (weak, nonatomic) IBOutlet UILabel *gittype;//货运方式
@property (weak, nonatomic) IBOutlet UILabel *valuem;//销量
@property (weak, nonatomic) IBOutlet UILabel *stock;//库存


@property (weak, nonatomic) IBOutlet UIImageView *cpIcon;
@property (weak, nonatomic) IBOutlet UILabel *cptitle;
@property (weak, nonatomic) IBOutlet UILabel *cpremark;//产品备注

@property (weak, nonatomic) IBOutlet UIButton *collect;//收藏

@property (nonatomic, strong) FSSegmentTitleView *titleView;
@property (nonatomic, assign) BOOL canScroll;
@property (nonatomic, strong) HotelBottomTableViewCell *contentCell;

@property (nonatomic,strong)NSArray *VcStrArr;

@property (nonatomic,strong) QCouponView *couponView;

@end


@implementation ShopSeckillDetailsViewController


//MARK:- couponView
-(QCouponView *)couponView{
    if (!_couponView) {
        _couponView = [[[NSBundle mainBundle]loadNibNamed:@"QCouponView" owner:self options:nil]lastObject];
        [_couponView setFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 2*(KSCREEN_HEIGHT/3))];
    }
    
    return _couponView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    KAdd_Observer(@"OtherTop", self, changeScroll, nil);
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self setup];
    // Do any additional setup after loading the view from its nib.
}


-(void)setup{
    
    self.canScroll = YES;
    
    NSArray *imagesURLStrings = @[
                                  @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
                                  @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
                                  @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg",
                                  @"http://img3.qianzhan123.com/news/201409/15/20140915-2b319c7d7cf0ad8a_550x1300.jpg"
                                  ];
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0,  KSCREEN_WIDTH, 280) delegate:self placeholderImage:nil];
    cycleScrollView.scrollDirection = UICollectionViewScrollDirectionVertical;
    cycleScrollView.onlyDisplayText = YES;
    
    self.mTableView.tableFooterView = [UILabel new];
    [self.mTableView registerNib:[UINib nibWithNibName:@"SeckillTableViewCell" bundle:nil] forCellReuseIdentifier:@"SeckillTableViewCell"];
    
    [self.topBannerbjView addSubview:cycleScrollView];

}


/*!insertRowAtTop */
- (void)insertRowAtTop {
    self.contentCell.currentTagStr = SeckillDetailsListArr[self.titleView.selectIndex];
    self.contentCell.isRefresh = YES;
    [self.mTableView.mj_header endRefreshing];
}


//MARK:-
-(void)changeScroll {
    self.canScroll = YES;
    self.contentCell.cellCanScroll = NO;
}


//MARK:-UITableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 4;
    }
    return 1;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        SeckillTableViewCell *cell = [SeckillTableViewCell tempTableViewCellWith:self.mTableView indexPath:indexPath type:self.seckillType];
        
        [cell configTempCellWith:indexPath];
        
        return cell;
    }else if (indexPath.section == 1) {
        _contentCell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        
        if (!_contentCell) {
            _contentCell = [[HotelBottomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell" withtype:HotelBottomTableViewCellTypeTwo];
            _contentCell.contentView.backgroundColor = [UIColor redColor];
            
            NSMutableArray *contentVCs = [NSMutableArray array];
            for (int i = 0 ; i < SeckillDetailsListArr.count; i++) {
                ShopSeckillDetailsSubViewController *vc = [[ShopSeckillDetailsSubViewController alloc]init];
                vc.title = SeckillDetailsListArr[i];
                vc.str = vc.title;
                
                [contentVCs addObject:vc];
            }
            _contentCell.viewControllers = contentVCs;
            _contentCell.pageContentView = [[FSPageContentView alloc]initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT-kStatusBarAndNavigationBarH - 50) childVCs:contentVCs parentVC:self delegate:self];
            [_contentCell.contentView addSubview:_contentCell.pageContentView];
        }
        
        return _contentCell;
        
    }
    
    return nil;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // 取消Cell的选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (indexPath.section == 0) {
        if (indexPath.row == 2) {
            [self arterShow];
        }else if (indexPath.row == 3){
            
            ShopShopkeeperViewController *shoper = [[ShopShopkeeperViewController alloc]init];
            [self.navigationController pushViewController:shoper animated:YES];
        }
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (self.seckillType == ShopSeckillDetailsTypeOrder) {
            return [[@[@"84",@"40",@"40",@"64"] objectAtIndex:indexPath.row] floatValue];
        }else if (self.seckillType == ShopSeckillDetailsTypeKill){
            return [[@[@"45",@"65",@"40",@"64"] objectAtIndex:indexPath.row] floatValue];
        }
        
    }else{
        
        return KSCREEN_HEIGHT-kStatusBarAndNavigationBarH-50;
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
    self.titleView = [[FSSegmentTitleView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 50) titles:SeckillDetailsListArr delegate:self indicatorType:FSIndicatorTypeEqualTitle];
    
    self.titleView.backgroundColor = KSRGBA(255, 255, 255, 255);
    
    return self.titleView;
}

//MARK:- SDCScroll
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
}


//MARK:- FSSegmentTitleViewDelegate
- (void)FSContenViewDidEndDecelerating:(FSPageContentView *)contentView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex {
    self.titleView.selectIndex = endIndex;
    self.mTableView.scrollEnabled = YES;
}


- (void)FSSegmentTitleView:(FSSegmentTitleView *)titleView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex{
    self.contentCell.pageContentView.contentViewCurrentIndex = endIndex;
}


- (void)FSContentViewDidScroll:(FSPageContentView *)contentView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex progress:(CGFloat)progress{
    self.mTableView.scrollEnabled = NO;
}


//MARK:- UIScrollView
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


-(void)arterShow{
    KPreventRepeatClickTime(1)
    [[QWAlertView sharedMask] show:self.couponView withType:QWAlertViewStyleAlert animationFinish:^{
        
    } dismissHandle:^{
       
    }];
}


//MARK:- dealloc
-(void)dealloc {
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
