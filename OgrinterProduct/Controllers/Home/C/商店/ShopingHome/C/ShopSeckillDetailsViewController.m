//
//  ShopSeckillDetailsViewController.m
//  OgrinterProduct
//
//  Created by wongshine on 2019/12/12.
//  Copyright © 2019 RXF. All rights reserved.
//

#define shopdetails @"goods/goods"
#define shopcollection @"goods/collection"//收藏或取消收藏
#define shopspecslist @"goods/specslist"//产品规格

#define bottomH 290


#import "ShopSeckillDetailsViewController.h"
#import "ShopSeckillDetailsSubViewController.h"
#import "OnlineBookingViewController.h"
#import "ShopShopkeeperViewController.h"
#import "SeckillTableViewCell.h"
#import "HotelBottomTableViewCell.h"
#import "FSScrollContentView.h"
#import "SDCycleScrollView.h"
#import <UMShare/UMShare.h>
#import <UMCommon/UMCommon.h>
#import "BeserveView.h"
#import "QCouponView.h"
#import "ShopDetalisModel.h"
//#import "ShareView.h"



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

@property (nonatomic, strong) HotelBottomTableViewCell *contentCell;
@property (nonatomic, strong) FSSegmentTitleView *titleView;
@property (nonatomic,strong) QCouponView *couponView;
@property (nonatomic,strong) BeserveView *bottomView;

@property (nonatomic, assign) BOOL canScroll;
@property (nonatomic,strong)NSArray *VcStrArr;
@property (nonatomic,strong)SDCycleScrollView *cycleScrollView;

@property (nonatomic,strong)NSMutableArray *dataArr;

@property (nonatomic,weak)UIButton *bjbtn;

@end


@implementation ShopSeckillDetailsViewController

-(NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}


//MARK:- cycleScrollView
-(SDCycleScrollView *) cycleScrollView{
    if (!_cycleScrollView){
        
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 280) delegate:self placeholderImage:nil];
        
        _cycleScrollView.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _cycleScrollView.autoScrollTimeInterval = 2.0;
        
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


//MARK:-viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"商品详情";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self setup];
    [self createBottomView];
    [self shareitem];

//    self.mTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        [self loadNetWork];
//    }];
    [self loadNetWork];
    // Do any additional setup after loading the view from its nib.
}


//MARK:- post
-(void)loadcollection:(NSString *)type{
    
    NSString *url = [NSString stringWithFormat:@"%@%@",API_BASE_URL_STRING,shopcollection];
    
    NSDictionary *dict = @{@"id":self.cpid,@"uid":@"",@"type":type};
    
    
    [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:url params:dict complement:^(ServerResponseInfo * _Nullable serverInfo) {
        
        if ([serverInfo.response[@"code"] integerValue] == 200) {
            NSDictionary *dict = serverInfo.response[@"data"];
            NSLog(@"%@",dict);
            
        }else {
            [HUDManager showTextHud:loadError];
        }
        
        [self.mTableView reloadData];
    }];
    
}


-(void)loadNetWork{
    
    NSString *url = [NSString stringWithFormat:@"%@%@",API_BASE_URL_STRING,shopdetails];
    NSDictionary *dict = @{@"id":self.cpid};
    
    [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:url params:dict complement:^(ServerResponseInfo * _Nullable serverInfo) {
        if ([serverInfo.response[@"code"] integerValue] == 200) {
            NSDictionary *dict = serverInfo.response[@"data"];
            ShopDetalisModel *model = [[ShopDetalisModel alloc]initWithDict:dict];
            [self.dataArr addObject:model];
            [_cycleScrollView setImageURLStringsGroup:model.bStrArr];
            
        }else {
            [HUDManager showTextHud:loadError];
        }
        
        [self.mTableView reloadData];
    }];
}


-(void)loadshopspecslist{
    
    NSString *url = [NSString stringWithFormat:@"%@%@",API_BASE_URL_STRING,shopspecslist];
    
    NSDictionary *dict = @{@"id":self.cpid};
    
    [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:url params:dict complement:^(ServerResponseInfo * _Nullable serverInfo) {
        if ([serverInfo.response[@"code"] integerValue] == 200) {
            NSLog(@"%@",dict);
        }else {
            [HUDManager showTextHud:loadError];
        }
        
    }];
    
}


-(void)setup{
    
    self.canScroll = YES;
    
    KAdd_Observer(@"OtherTop", self, changeScroll, nil);
    
    [self wr_setNavBarBackgroundAlpha:0];
    
    self.mTableView.tableFooterView = [UILabel new];
    [self.mTableView registerNib:[UINib nibWithNibName:@"SeckillTableViewCell" bundle:nil] forCellReuseIdentifier:@"SeckillTableViewCell"];
    
    [self.topBannerbjView addSubview:self.cycleScrollView];
    [self.topBannerbjView bringSubviewToFront:self.bannernumLable];
    [self.topBannerbjView bringSubviewToFront:self.bannerbjlable];
    [self.topBannerbjView bringSubviewToFront:self.shareBtn];
    
}


//MARK:-createBottomView
-(void)createBottomView {
    
    UIButton *btn = [self createbtn:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT-bottomH+58) Action:@selector(dissView) BackGroundColor:[UIColor colorWithWhite:0.4 alpha:0.4]];
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


-(void)shareitem{
    
    UIButton *btn = [self createbtn:CGRectMake(0, 0, 32, 32) Action:@selector(shareClick:) BackGroundColor:nil];
    [btn setBackgroundImage:[UIImage imageNamed:@"分享"] forState:0];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
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
        if ([self.dataArr count]) {
            ShopDetalisModel *model =  self.dataArr[0];
            cell.dmodelist = model;
        }
        
        cell.selectBlock = ^(UIButton *btn) {
            
            if (btn.selected == YES)
                [self loadcollection:@"0"];
            else
                [self loadcollection:@"1"];
        };
        
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
                vc.cp_id = self.cpid;
                
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



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
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
        }else{}
    }else{
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
    
    CGFloat bottomCellOffset = [self.mTableView rectForSection:1].origin.y-kStatusBarAndNavigationBarH;
    CGFloat conOffY = scrollView.contentOffset.y;
    CGFloat maxAlphaOffset = 168;

    CGFloat alpha = (conOffY) / (maxAlphaOffset);
    
    [self wr_setNavBarBackgroundAlpha:alpha];
    
    if (conOffY >= bottomCellOffset) {
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
- (void)shareClick:(UIButton *)sender {
    KPreventRepeatClickTime(1)
    
//    [[QWAlertView sharedMask] show:self.shareView withType:QWAlertViewStyleAlert animationFinish:^{
//
//    } dismissHandle:^{
//
//    }];
    
//    NSArray *baseDisplaySnsPlatforms = @[@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_Sina)];
//    [UMSocialUIManager setPreDefinePlatforms:baseDisplaySnsPlatforms];
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    UMShareWebpageObject*shareObject = [UMShareWebpageObject shareObjectWithTitle:@"挑战你的记忆力"descr:@"鱼的记忆有七秒，你的呢？"thumImage:[UIImage imageNamed:@"loginIcon"]];
    
    shareObject.webpageUrl = @"www.baidu.com";
    messageObject.shareObject= shareObject;
    
    [[UMSocialManager defaultManager]shareToPlatform:UMSocialPlatformType_WechatSession  messageObject:messageObject currentViewController:nil completion:^(id result, NSError *error) {
        if (error) {
            NSLog(@"分享失败：%@",error);
            [HUDManager showTextHud:@"分享失败!未安装应用"];
        }else{
            NSLog(@"分享 result = %@",result);
        }
    }];
}

//分享
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
    } completion:^(BOOL finished) {
        [self loadshopspecslist];
    }];
}


-(void)pushToPayController {
    OnlineBookingViewController *Online = [[OnlineBookingViewController alloc]init];
    Online.payType = OnlineBookingViewProductPay;
    [self.navigationController pushViewController:Online animated:YES];
}


-(UIButton *)createbtn:(CGRect)rect Action:(SEL)action BackGroundColor:(UIColor *)color{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:rect];
    
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    if (color)
        [btn setBackgroundColor:color];
    
    return btn;
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
