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

#define order_add_order @"order/add_order"//购买

#define cart_addcar @"cart/addcar"//加入购物车

#define group_puzzle_detail @"group/puzzle_detail"//拼团详情

#define sec_details @"goods/sec_details"//秒杀详情
#define goodssec_goods @"goods/sec_goods"//秒杀操作

#define groupgroup_order @"group/group_order"//团购操作

#define bottomH 3*(KSCREEN_HEIGHT/5)


#import "ShopSeckillDetailsViewController.h"
#import "ShopSeckillDetailsSubViewController.h"
#import "OnlineBookingViewController.h"
#import "ShopShopkeeperViewController.h"
#import "ZBNMyAddressVC.h"
#import "ZBNShopingCartVC.h"


#import "FSScrollContentView.h"
#import "SDCycleScrollView.h"
#import "BeserveView.h"
#import "QCouponView.h"

#import "HotelBottomTableViewCell.h"
#import "SeckillTableViewCell.h"

#import "ShopDetalisModel.h"
#import "BeseModel.h"

#import <UMShare/UMShare.h>
#import <UMCommon/UMCommon.h>
//#import "ShareView.h"
#import "KillModelt.h"
#import "OYCountDownManager.h"



@interface ShopSeckillDetailsViewController ()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate,FSPageContentViewDelegate,FSSegmentTitleViewDelegate,UIAlertViewDelegate>

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

@property (weak, nonatomic) IBOutlet UIView *pView;
@property (weak, nonatomic) IBOutlet UIView *mView;
@property (weak, nonatomic) IBOutlet UIView *ptView;



@property (nonatomic, strong) HotelBottomTableViewCell *contentCell;
@property (nonatomic, strong) FSSegmentTitleView *titleView;
@property (nonatomic,strong) QCouponView *couponView;
@property (nonatomic,strong) BeserveView *bottomView;

@property (nonatomic, assign) BOOL canScroll;
@property (nonatomic,strong)NSArray *VcStrArr;
@property (nonatomic,strong)SDCycleScrollView *cycleScrollView;

@property (nonatomic,strong)NSMutableArray *dataArr;
@property (nonatomic,strong)NSMutableArray *dataArr1;
@property (nonatomic,strong)NSMutableArray *dataArr2;



@property(nonatomic,strong)NSMutableArray *ggArr;

@property (nonatomic,weak)UIButton *bjbtn;

@property(nonatomic,strong)userInfo * unmodel;

@property(nonatomic,strong)NSDictionary *ggDict;
@property(nonatomic,strong)NSString *orderNumberStr;
@property(nonatomic,strong)NSDictionary *dicte;

@property (weak, nonatomic) IBOutlet UILabel *ktgmlable;

@property (weak, nonatomic) IBOutlet UILabel *ddgolable;


@end


@implementation ShopSeckillDetailsViewController

-(NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

-(NSMutableArray *)dataArr1 {
    if (!_dataArr1) {
        _dataArr1 = [NSMutableArray array];
    }
    return _dataArr1;
}

-(NSMutableArray *)dataArr2 {
    if (!_dataArr2) {
        _dataArr2 = [NSMutableArray array];
    }
    return _dataArr2;
}


-(NSMutableArray *)ggArr {
    if (!_ggArr) {
        _ggArr = [NSMutableArray array];
    }
    return _ggArr;
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
    
    [self loadNetWork:@"0"];
    
    // Do any additional setup after loading the view from its nib.
}


//MARK:- post
-(void)loadcollection:(NSString *)type{
    
    NSDictionary *dict = nil;
    
    NSString *url = [NSString stringWithFormat:@"%@%@",API_BASE_URL_STRING,shopcollection];
    
    if (self.unmodel)
        dict = @{@"id":self.cpid,@"uid":self.unmodel.uid,@"type":type};
    else
        dict = @{@"id":self.cpid,@"type":type};
    
    [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:url params:dict complement:^(ServerResponseInfo * _Nullable serverInfo) {
        
        if ([serverInfo.response[@"code"] integerValue] == 200) {
            if ([type isEqualToString:@"0"])
                [HUDManager showTextHud:@"已取消收藏"];
            else
                [HUDManager showTextHud:@"已收藏"];
            
        }else
            [HUDManager showTextHud:loadError];
        
        [self loadNetWork:@"1"];
        
    }];
}


-(void)loadNetWork:(NSString *)type{
    
    NSDictionary *dict = nil;
    
    if (self.unmodel.uid)
        dict = @{@"uid":self.unmodel.uid,@"id":self.cpid};
    else
        dict  = @{@"id":self.cpid};
    
    NSString *url = [NSString stringWithFormat:@"%@%@",API_BASE_URL_STRING,shopdetails];
    
    if (self.seckillType == ShopSeckillDetailsTypeKill) {
        [kCountDownManager start];
        
        [self.pView setHidden:YES];
        [self.mView setHidden:NO];
        NSString *url2 = [NSString stringWithFormat:@"%@%@",API_BASE_URL_STRING,sec_details];
        
        [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:url2 params:@{@"sec_id":self.sec_id} complement:^(ServerResponseInfo * _Nullable serverInfo) {
            if ([serverInfo.response[@"code"] integerValue] == 200) {
                self.dicte = serverInfo.response[@"data"];
                self.ktgmlable.text = [NSString stringWithFormat:@"￥%@",self.dicte[@"kill_price"]];
                [self.mTableView reloadData];
                
            }else {
                [HUDManager showTextHud:loadError];
            }
            
        }];
        
    }else if (self.seckillType == ShopSeckillDetailsTypeOrder){
//        url = [NSString stringWithFormat:@"%@%@",API_BASE_URL_STRING,shopdetails];
        
    }else if (self.seckillType == ShopSeckillDetailsTypeOther){
        [kCountDownManager start];
        [self.pView setHidden:YES];
        [self.ptView setHidden:NO];
        
        NSString *url1 = [NSString stringWithFormat:@"%@%@/%@",API_BASE_URL_STRING,group_puzzle_detail,self.cpid];
        
        [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_GET pathUrl:url1 params:nil complement:^(ServerResponseInfo * _Nullable serverInfo) {
            if ([serverInfo.response[@"code"] integerValue] == 200) {
                NSDictionary *dict = serverInfo.response[@"data"];
                KillModelt *model = [[KillModelt alloc]initWithDict:dict];
                [self.dataArr1 addObject:model];
                [self.mTableView reloadData];
            }else if([serverInfo.response[@"code"] integerValue] == 404){
                [HUDManager showTextHud:serverInfo.response[@"msg"]];
                
                [self.navigationController popViewControllerAnimated:YES];
                
            }else {
                [HUDManager showTextHud:loadError];
            }
            
        }];
    }
    
    
    [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:url params:dict complement:^(ServerResponseInfo * _Nullable serverInfo) {
        if ([serverInfo.response[@"code"] integerValue] == 200) {
            NSDictionary *dict = serverInfo.response[@"data"];
            [self.dataArr removeAllObjects];
            
            ShopDetalisModel *model = [[ShopDetalisModel alloc]initWithDict:dict];
            self.ddgolable.text = [NSString stringWithFormat:@"￥%@",model.price];
            [self.dataArr addObject:model];
            [_cycleScrollView setImageURLStringsGroup:model.bStrArr];
            
        }else
            [HUDManager showTextHud:loadError];
        
        if ([type isEqualToString:@"1"]) {
            
            [UIView setAnimationsEnabled:NO];
            [self.mTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:0 inSection:0], nil] withRowAnimation:UITableViewRowAnimationFade];
            [UIView setAnimationsEnabled:YES];
            
        }else {
            [self.mTableView reloadData];
        }
    }];
}


-(void)loadshopspecslist{
    
    NSString *url = [NSString stringWithFormat:@"%@%@",API_BASE_URL_STRING,shopspecslist];
    
    NSDictionary *dict = @{@"id":self.cpid};
    
    [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:url params:dict complement:^(ServerResponseInfo * _Nullable serverInfo) {
        if ([serverInfo.response[@"code"] integerValue] == 200) {
            BeseModel *model = [[BeseModel alloc]initWithDict:[serverInfo.response objectForKey:@"data"]];
            [_bottomView setListModel:model];
            NSLog(@"%@",dict);
        }else {
            [HUDManager showTextHud:loadError];
        }
        
    }];
}


//MARK:- 结算
-(void)loadOrderNetWork:(NSDictionary *)dict type:(NSString *)types{
    
    NSString *urlStr = nil;
    if ([types isEqualToString:@"0"])
        urlStr = [NSString stringWithFormat:@"%@%@",API_BASE_URL_STRING,order_add_order];
    else if ([types isEqualToString:@"1"])
        urlStr = [NSString stringWithFormat:@"%@%@",API_BASE_URL_STRING,cart_addcar];
    
    [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:urlStr params:dict complement:^(ServerResponseInfo * _Nullable serverInfo) {
        if ([serverInfo.response[@"code"] integerValue] == 200) {
            if ([types isEqualToString:@"0"]) {
                OnlineBookingViewController *Online = [[OnlineBookingViewController alloc]init];
                Online.payType = OnlineBookingViewProductPay;
                Online.order_sn = [[serverInfo.response objectForKey:@"data"] objectForKey:@"order_sn"];
                
                Online.issect = NO; [self.navigationController pushViewController:Online animated:YES];
            }else if ([types isEqualToString:@"1"]){
                [HUDManager showTextHud:[serverInfo.response objectForKey:@"msg"]];
            }else{}
            
        }else if ([serverInfo.response[@"code"] integerValue] == 201){
            [HUDManager showTextHud:serverInfo.response[@"msg"]];
            ZBNMyAddressVC *add = [[ZBNMyAddressVC alloc]init];
            [self.navigationController pushViewController:add animated:YES];
            
        }else{
            [HUDManager showTextHud:loadError];
        }
    }];
}


-(void)setup{
    
    self.canScroll = YES;
    
    KAdd_Observer(@"OtherTop", self, changeScroll, nil);
    
    NSData * data1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"infoData"];
    
    self.unmodel = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
    
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
    
    UIButton *btn = [self createbtn:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT-bottomH+58) Action:@selector(dissView:) BackGroundColor:[UIColor colorWithWhite:0.4 alpha:0.4]];
    [btn setHidden:YES];
    [[UIApplication sharedApplication].keyWindow addSubview:self.bjbtn = btn];
    
    _bottomView = [[NSBundle mainBundle]loadNibNamed:@"BeserveView" owner:self options:nil].lastObject;
    [_bottomView setFrame:CGRectMake(0, KSCREEN_HEIGHT, KSCREEN_WIDTH,bottomH)];
    
    __weak typeof(&*self)WeakSelf = self;
    _bottomView.payBlock = ^(UIButton *btn, NSInteger number, NSString *cpId) {
        ShopDetalisModel *model =  WeakSelf.dataArr[0];
//            立即购买
        if (WeakSelf.unmodel)
            WeakSelf.ggDict = @{@"goods_id":WeakSelf.cpid,@"uid":WeakSelf.unmodel.uid,@"merchant_id":model.merchant_id,@"goods_sku_id":cpId,@"num":[@(number) stringValue]};
        else
            WeakSelf.ggDict = @{@"goods_id":WeakSelf.cpid,@"uid":@"",@"merchant_id":model.merchant_id,@"goods_sku_id":cpId,@"num":[@(number) stringValue]};
        
        if (btn.tag == 105)
            [WeakSelf dissView:@"1"];
        else
            [WeakSelf dissView:@"0"];
        
    
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
        if (self.seckillType == ShopSeckillDetailsTypeOther) {
            return 4;
        }else if (self.seckillType == ShopSeckillDetailsTypeOrder){
            return 4;
        }else if (self.seckillType == ShopSeckillDetailsTypeKill){
            return 4;
        }else{
            return 0;
            
        }
    }
    return 1;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        SeckillTableViewCell *cell = [SeckillTableViewCell tempTableViewCellWith:self.mTableView indexPath:indexPath type:self.seckillType];
        
        [cell configTempCellWith:indexPath];
        if (self.seckillType == ShopSeckillDetailsTypeOther) {
            if ([self.dataArr1 count]) {
                KillModelt *model =  self.dataArr1[0];
                cell.kmodelist = model;
            }
            
//            if ([self.dataArr count]) {
//                ShopDetalisModel *model =  self.dataArr[0];
//                cell.dmodelist = model;
//            }
        }else if (self.seckillType == ShopSeckillDetailsTypeOrder){
            
//            if ([self.dataArr count]) {
//                ShopDetalisModel *model =  self.dataArr[0];
//                cell.dmodelist = model;
//            }
        }else if(self.seckillType == ShopSeckillDetailsTypeKill){
            if (self.dicte)
                [cell setDic:self.dicte];
        }else{}
        
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
        
        if (self.seckillType == ShopSeckillDetailsTypeOther) {
            if (indexPath.row == 3){
                [self pusHoperController];
            }
        }else if (self.seckillType == ShopSeckillDetailsTypeOrder){
            if (indexPath.row == 2) {
                [self arterShow];
            }else if (indexPath.row == 3){
                [self pusHoperController];
            }
        }else if (self.seckillType == ShopSeckillDetailsTypeKill){
            if (indexPath.row == 3){
                [self pusHoperController];
            }
        }else{
            
        }
        
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (self.seckillType == ShopSeckillDetailsTypeOrder) {
            return [[@[@"84",@"40",@"40",@"64"] objectAtIndex:indexPath.row] floatValue];
        }else if (self.seckillType == ShopSeckillDetailsTypeKill){
            return [[@[@"45",@"84",@"40",@"64"] objectAtIndex:indexPath.row] floatValue];
        }else if (self.seckillType == ShopSeckillDetailsTypeOther){
            return [[@[@"84",@"84",@"64",@"138"] objectAtIndex:indexPath.row] floatValue];}
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

//MARK:- 店铺 客服 购物车 加入购物车 立即购买
- (IBAction)joinCartClick:(UIButton *)sender {
    KPreventRepeatClickTime(1)
    if (sender.tag == 2000) {
        [self pusHoperController];
    }else if (sender.tag == 2001){
        [HUDManager showTextHud:@"客服"];
    }else if (sender.tag == 2002){
        ZBNShopingCartVC *zbn = [[ZBNShopingCartVC alloc]init];
        [self.navigationController pushViewController:zbn animated:YES];
    }else if (sender.tag == 2003 || sender.tag == 2004){
        [self showView];
    }
}


//MARK:-couponView
-(void)arterShow{
    KPreventRepeatClickTime(1)
    [[QWAlertView sharedMask] show:self.couponView withType:QWAlertViewStyleActionSheetDown animationFinish:^{
        
    } dismissHandle:^{
        
    }];
}

//MARK:- view消失
-(void)dissView:(NSString *)type{
    
    [UIView animateWithDuration:0.3 animations:^{
        _bottomView.frame = CGRectMake(0, KSCREEN_HEIGHT, KSCREEN_WIDTH, bottomH);
        [self.bjbtn setHidden:YES];
        
    } completion:^(BOOL finished) {
        if ([type isKindOfClass:[UIButton class]])
            return;
        else
            [self loadOrderNetWork:self.ggDict type:type];
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


-(UIButton *)createbtn:(CGRect)rect Action:(SEL)action BackGroundColor:(UIColor *)color{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:rect];
    
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    if (color)
        [btn setBackgroundColor:color];
    
    return btn;
}


-(void)pusHoperController {
    ShopDetalisModel *model =  self.dataArr[0];
    ShopShopkeeperViewController *shoper = [[ShopShopkeeperViewController alloc]init];
    shoper.shoperId = model.merchant_id;
    if (self.unmodel) {
        shoper.u_id = self.unmodel.uid;
    }else {shoper.u_id = @"";}
    [self.navigationController pushViewController:shoper animated:YES];
}

//MARK:立即秒杀
- (IBAction)killAccess:(UIButton *)sender {
    
    UIAlertView * alter = [[UIAlertView alloc]initWithTitle:@"提示：" message:@"您确定要秒杀该商品？" delegate:self cancelButtonTitle:@"容我想想" otherButtonTitles:@"那必须的", nil];
    [alter setTag:100];
    [alter show];
}

- (IBAction)kaituan:(UIButton *)sender {
    UIAlertView * alter = [[UIAlertView alloc]initWithTitle:@"提示：" message:@"您确定团？" delegate:self cancelButtonTitle:@"容我想想" otherButtonTitles:@"那必须的", nil];
    [alter setTag:101];
    [alter show];
    
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
//        NSLog(@"quxiao");
    }else if (buttonIndex == 1){
        if (alertView.tag == 100) {
            NSDictionary *dic = nil;
            if (self.unmodel)
                dic = @{@"sec_id":self.sec_id,@"uid":self.unmodel.uid};
            else{
                dic = @{@"sec_id":self.sec_id};
            }
            
            NSString *url2 = [NSString stringWithFormat:@"%@%@",API_BASE_URL_STRING,goodssec_goods];
            
            [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:url2 params:dic complement:^(ServerResponseInfo * _Nullable serverInfo) {
                if ([serverInfo.response[@"code"] integerValue] == 200) {
                    [HUDManager showTextHud:@"恭喜您!拿下该商品"];
                }else {
                    [HUDManager showTextHud:loadError];
                }
            }];
        }else if (alertView.tag == 101){
            
            NSDictionary *dic = nil;
            if (self.unmodel)
                dic = @{@"num":@"3",@"uid":self.unmodel.uid,@"puzzle_id":self.cpid,@"open_join":@"1"};
                
            NSString *url2 = [NSString stringWithFormat:@"%@%@",API_BASE_URL_STRING,groupgroup_order];
            
            [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:url2 params:dic complement:^(ServerResponseInfo * _Nullable serverInfo) {
                if ([serverInfo.response[@"code"] integerValue] == 200) {
                    [HUDManager showTextHud:@"恭喜您!成功开团"];
                    OnlineBookingViewController *Online = [[OnlineBookingViewController alloc]init];
                    Online.payType = OnlineBookingViewProductPay;
                    Online.secDict = serverInfo.response[@"data"];
                    Online.order_sn = [[serverInfo.response objectForKey:@"data"] objectForKey:@"order_sn"];
                    Online.issect = YES;
                    [self.navigationController pushViewController:Online animated:YES];
                }else {
                    [HUDManager showTextHud:loadError];
                }
            }];
        }
        
    }
}

//MARK:

//MARK:- dealloc
-(void)dealloc {
     NSLog(@"释放-");
    [kCountDownManager invalidate];
    KRemove_Observer(self);
}


-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [kCountDownManager invalidate];
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
