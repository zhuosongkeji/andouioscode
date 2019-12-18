//
//  ShopSeckillDetailsViewController.m
//  OgrinterProduct
//
//  Created by wongshine on 2019/12/12.
//  Copyright © 2019 RXF. All rights reserved.
//

#define bottomH 290


#import "ShopSeckillDetailsViewController.h"
#import "ShopSeckillDetailsSubViewController.h"
#import "ShopShopkeeperViewController.h"
#import "QCouponView.h"
#import "SeckillTableViewCell.h"
#import "HotelBottomTableViewCell.h"
#import "FSScrollContentView.h"
#import "SDCycleScrollView.h"
#import "BeserveView.h"
#import "ShareView.h"



@interface ShopSeckillDetailsViewController ()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate,FSPageContentViewDelegate,FSSegmentTitleViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *mTableView;
@property (weak, nonatomic) IBOutlet UIView *topBannerbjView;
@property (weak, nonatomic) IBOutlet UILabel *YPrice;//优惠价格
@property (weak, nonatomic) IBOutlet UILabel *SPrice;//实际价格
@property (weak, nonatomic) IBOutlet UILabel *dowuplable;//倒计时
@property (weak, nonatomic) IBOutlet UILabel *bannerbjlable;
@property (weak, nonatomic) IBOutlet UILabel *bannernumLable;
@property (weak, nonatomic) IBOutlet UILabel *cpcontent;//产品说明
@property (weak, nonatomic) IBOutlet UILabel *gittype;//货运方式
@property (weak, nonatomic) IBOutlet UILabel *valuem;//销量
@property (weak, nonatomic) IBOutlet UILabel *stock;//库存


@property (weak, nonatomic) IBOutlet UIImageView *cpIcon;
@property (weak, nonatomic) IBOutlet UILabel *cptitle;
@property (weak, nonatomic) IBOutlet UILabel *cpremark;//产品备注

@property (weak, nonatomic) IBOutlet UIButton *collect;//收藏
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;

@property (nonatomic, strong) FSSegmentTitleView *titleView;
@property (nonatomic, assign) BOOL canScroll;
@property (nonatomic, strong) HotelBottomTableViewCell *contentCell;

@property (nonatomic,strong)NSArray *VcStrArr;

@property (nonatomic,strong) QCouponView *couponView;

@property (nonatomic,strong)SDCycleScrollView *cycleScrollView;

@property (nonatomic,strong)ShareView *shareView;

@property (nonatomic,weak)UIButton *bjbtn;

@property (nonatomic,strong)BeserveView *bottomView;

@end


@implementation ShopSeckillDetailsViewController

//MARK:- cycleScrollView
-(SDCycleScrollView *) cycleScrollView{
    if (!_cycleScrollView){
        
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 280) delegate:self placeholderImage:[UIImage imageNamed:@"banner"]];
//        _cycleScrollView.imageURLStringsGroup = imagesURLStrings;
        
        _cycleScrollView.scrollDirection = UICollectionViewScrollDirectionVertical;
        _cycleScrollView.onlyDisplayText = YES;
//        _cycleScrollView.imageURLStringsGroup = imagesURLStrings;
    }
    
    return _cycleScrollView;
}


//MARK:- couponView
-(QCouponView *)couponView{
    if (!_couponView) {
        _couponView = [[[NSBundle mainBundle]loadNibNamed:@"QCouponView" owner:self options:nil]lastObject];
        [_couponView setFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 2*(KSCREEN_HEIGHT/3))];
    }
    
    return _couponView;
}


-(ShareView *)shareView{
    if (!_shareView) {
        _shareView = [[[NSBundle mainBundle]loadNibNamed:@"ShareView" owner:self options:nil] lastObject];
        [_shareView setFrame:CGRectMake(0, 0, KSCREEN_WIDTH-64, 178)];
    }
    return _shareView;
}




//MARK:-viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"商品详情";
    
    KAdd_Observer(@"OtherTop", self, changeScroll, nil);
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self setup];
    [self createBottomView];
    // Do any additional setup after loading the view from its nib.
}


-(void)setup{
    
    self.canScroll = YES;
    
    self.mTableView.tableFooterView = [UILabel new];
    [self.mTableView registerNib:[UINib nibWithNibName:@"SeckillTableViewCell" bundle:nil] forCellReuseIdentifier:@"SeckillTableViewCell"];
    
    [self.topBannerbjView addSubview:self.cycleScrollView];
    [self.topBannerbjView bringSubviewToFront:self.bannernumLable];
    [self.topBannerbjView bringSubviewToFront:self.bannerbjlable];
    [self.topBannerbjView bringSubviewToFront:self.shareBtn];
    
}


//MARK:-createBottomView
-(void)createBottomView {
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT-bottomH+58)];
    [btn addTarget:self action:@selector(dissView) forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundColor:[UIColor colorWithWhite:0.4 alpha:0.4]];
    [btn setHidden:YES];
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.bjbtn = btn];
    
    _bottomView = [[NSBundle mainBundle]loadNibNamed:@"BeserveView" owner:self options:nil].lastObject;
    [_bottomView setFrame:CGRectMake(0, KSCREEN_HEIGHT, KSCREEN_WIDTH,bottomH)];
    
    __weak typeof(&*self)WeakSelf = self;
    _bottomView.payBlock = ^(UIButton *btn) {
        [WeakSelf dissView];
        [WeakSelf performSelector:@selector(pushToPayController) withObject:nil afterDelay:0.5];
    };
    
    [[UIApplication sharedApplication].keyWindow addSubview:_bottomView];
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


//MARK:-couponView
-(void)arterShow{
    KPreventRepeatClickTime(1)
    [[QWAlertView sharedMask] show:self.couponView withType:QWAlertViewStyleActionSheetDown animationFinish:^{
        
    } dismissHandle:^{
       
    }];
}


//MARK:- shareClick
- (IBAction)shareClick:(UIButton *)sender {
    KPreventRepeatClickTime(1)
    
    [[QWAlertView sharedMask] show:self.shareView withType:QWAlertViewStyleAlert animationFinish:^{
        
    } dismissHandle:^{
        
    }];
}


- (IBAction)joinCartClick:(UIButton *)sender {
    KPreventRepeatClickTime(1)
    if (sender.tag == 2004) {
        [self showView];
    }else {
        [HUDManager showTextHud:OtherMsg];
    }
}


//MARK:- view消失
-(void)dissView{
    
    [UIView animateWithDuration:0.3 animations:^{
        _bottomView.frame = CGRectMake(0, KSCREEN_HEIGHT, KSCREEN_WIDTH, bottomH);
        [self.bjbtn setHidden:YES];
    }];
    
}


-(void)showView{
    [UIView animateWithDuration:0.3 animations:^{
        _bottomView.frame = CGRectMake(0, KSCREEN_HEIGHT-bottomH, self.view.frame.size.width, bottomH);
        [self.bjbtn setHidden:NO];
    }];
}


-(void)pushToPayController {
    
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
