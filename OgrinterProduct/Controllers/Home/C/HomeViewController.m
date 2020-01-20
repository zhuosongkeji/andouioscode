//
//  HomeViewController.m
//  OgrinterProduct
//
//  Created by wongshine on 2019/11/28.
//  Copyright © 2019 RXF. All rights reserved.
//


#define BannerApi @"index/index"

#define gourmet_list @"gourmet/list"//获取 饭店数据

#import "HomeViewController.h"
#import "HQImagePageControl.h"
#import "CustomSectionView.h"
#import "HomeTableViewCell.h"
#import "CitylistViewController.h"
#import "KXWebViewViewController.h"
#import "iCarousel.h"

#import "HQFlowView.h"
#import "MarqueeView.h"
#import "RedPacketView.h"
#import "PacketModel.h"
#import "HomeModel.h"
#import "OnlineOrderModel.h"


@interface HomeViewController ()<HQFlowViewDelegate,HQFlowViewDataSource,UITableViewDataSource,UITableViewDelegate,iCarouselDelegate,iCarouselDataSource>{
    NSArray *imgArrs;
}


@property (weak, nonatomic) IBOutlet UITableView *mTableView;
@property (weak, nonatomic) IBOutlet UIView *topBananerView;
@property (weak, nonatomic) IBOutlet UIView *noticeView;
@property (weak, nonatomic) IBOutlet UIView *noticebjView;
@property (weak, nonatomic) IBOutlet UIView *iCarouselBJView;

@property (nonatomic,strong) iCarousel *icarousel;
@property (nonatomic, strong) HQImagePageControl *pageC;
@property (nonatomic, strong) HQFlowView *pageFlowView;

@property (nonatomic,strong) MarqueeView *queeView;

@property (nonatomic,strong) NSMutableArray *imgArr;
@property (nonatomic,strong) NSMutableArray *imgOArr;
@property (nonatomic,strong) NSMutableArray *notisArr;
@property (nonatomic,strong) NSMutableArray *merchantArr;

@property(nonatomic,strong)NSMutableArray *mData;


@property (nonatomic, strong) UIView *selectView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toTop;
@property(nonatomic,strong)UIView *imgView;
@property (nonatomic)CGFloat ralpha;


@end


@implementation HomeViewController


//MARK:-imgArr
-(NSMutableArray *)imgArr {
    if (!_imgArr) {
        _imgArr = [NSMutableArray array];
    }
    return _imgArr;
}

//MARK:-imgArr
-(NSMutableArray *)mData {
    if (!_mData) {
        _mData = [NSMutableArray array];
    }
    return _mData;
}

//MARK:-imgArr
-(NSMutableArray *)imgOArr {
    if (!_imgOArr) {
        _imgOArr = [NSMutableArray array];
    }
    return _imgOArr;
}

//MARK:-imgArr
-(NSMutableArray *)notisArr {
    if (!_notisArr) {
        _notisArr = [NSMutableArray array];
    }
    return _notisArr;
}

//MARK:-imgArr
-(NSMutableArray *)merchantArr {
    if (!_merchantArr) {
        _merchantArr = [NSMutableArray array];
    }
    return _merchantArr;
}


- (HQFlowView *)pageFlowView {
    if (!_pageFlowView) {
        
        _pageFlowView = [[HQFlowView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 168)];
        _pageFlowView.delegate = self;
        _pageFlowView.dataSource = self;
        _pageFlowView.minimumPageAlpha = 0.3;
        _pageFlowView.leftRightMargin = 15;
        _pageFlowView.topBottomMargin = 20;
        _pageFlowView.orginPageCount = self.imgArr.count;
        _pageFlowView.isOpenAutoScroll = YES;
        _pageFlowView.autoTime = 3.0;
        _pageFlowView.orientation = HQFlowViewOrientationHorizontal;
        
    }
    return _pageFlowView;
}

- (HQImagePageControl *)pageC{
    if (!_pageC) {
        if (!_pageC) {
            _pageC = [[HQImagePageControl alloc]initWithFrame:CGRectMake(0, self.topBananerView.frame.size.height - 35, KSCREEN_WIDTH, 7.5)];
        }
        
        [self.pageFlowView.pageControl setCurrentPage:0];
        self.pageFlowView.pageControl = _pageC;
        
    }
    return _pageC;
}


-(MarqueeView *)queeView{
    if (!_queeView) {
        
        NSMutableArray *array = [NSMutableArray array];
        for (int i = 0; i < [_notisArr count]; i ++) {
            HomeModel *model = _notisArr[i];
            [array addObject:model.content];
        }
        _queeView = [[MarqueeView alloc]initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH - 74,30) withTitle:array];
        _queeView.titleFont = [UIFont systemFontOfSize:12];
        
        self.queeView.handlerTitleClickCallBack = ^(NSInteger index){
            
        };
    }
    
    return _queeView;
}


//MARK:- iCarousel
-(iCarousel *)icarousel{
    if (_icarousel == nil) {
        _icarousel = [[iCarousel alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 150)];
        _icarousel.delegate = self;
        _icarousel.dataSource = self;
        _icarousel.bounces = YES;
        _icarousel.pagingEnabled = NO;
        _icarousel.type = iCarouselTypeRotary;
    }
    return _icarousel;
}

//MARK:- viewDidLoad
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setup];
    [self openRedPacket];
    
    [self loadNetWork];
    [self floadNetWork];

    // Do any additional setup after loading the view from its nib.
}


-(void)setup{
    
    self.navigationItem.title = @"";
    
    [self wr_setNavBarBackgroundAlpha:0];
    
    self.mTableView.tableFooterView = [UILabel new];
    [self.mTableView registerNib:[UINib nibWithNibName:@"HomeTableViewCell" bundle:nil] forCellReuseIdentifier:@"HomeTableViewCell"];
    
}


//MARK:- openRedPacket
- (void)openRedPacket {
    
    [self.topBananerView addSubview:self.pageFlowView];
    [self.pageFlowView addSubview:self.pageC];
    [self.iCarouselBJView addSubview:self.icarousel];
    
    PacketModel *data = ({
        PacketModel *data = [[PacketModel alloc]init];
        data.money = 128.00;
//        data.avatarImage = [UIImage imageNamed:@""];
        data.content = @"最高可得500.00";
//        data.userName  = @"小雨同学";
        data;
    });
    
    [RedPacketView ShowRedpacketWithData:data cancelBlock:^{
        NSLog(@"取消领取");
    } finishBlock:^(float money) {
        NSLog(@"领取500.0");
    }];
}


-(void)loadNetWork {
    
    [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:[NSString stringWithFormat:@"%@%@",API_BASE_URL_STRING,BannerApi] params:@{} complement:^(ServerResponseInfo * _Nullable serverInfo) {
        if ([serverInfo.response[@"code"] integerValue] == 200) {
            NSDictionary *dict = serverInfo.response[@"data"];
            
            if ([_imgArr count])
                [_imgArr removeAllObjects];
            
            for (int i = 0; i < [dict[@"banner"] count]; i ++) {
                HomeModel *model = [[HomeModel alloc]initWithDict:dict[@"banner"][i]];
                [self.imgArr addObject:model];
            }
            
            if ([_imgOArr count])
                [_imgOArr removeAllObjects];
            
            for (int i = 0; i < [dict[@"merchant_type"] count];  i ++) {
                HomeModel *model = [[HomeModel alloc]initWithDict:dict[@"merchant_type"][i]];
                [self.imgOArr addObject:model];
            }
            
            if ([_notisArr count])
                [_notisArr removeAllObjects];
            
            for (int i = 0; i < [dict[@"notice"] count]; i ++) {
                HomeModel *model = [[HomeModel alloc]initWithDict:dict[@"notice"][i]];
                [self.notisArr addObject:model];
            }
            
            if ([_merchantArr count])
                [_merchantArr removeAllObjects];
            
            for (int i = 0; i < [dict[@"merchants"] count]; i ++) {
                HomeModel *model = [[HomeModel alloc]initWithDict:dict[@"merchants"][i]];
                [self.merchantArr addObject:model];
            }
            
            [self.noticebjView addSubview:self.queeView];
            [self.pageFlowView reloadData];//刷新轮播
            [self.icarousel reloadData];
            
            [self.mTableView reloadData];
            
        }else {
            
        }
    }];
}

//MARK:- 获取饭店数据
-(void)floadNetWork{
    
    [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:[NSString stringWithFormat:@"%@%@",API_BASE_URL_STRING,gourmet_list] params:nil complement:^(ServerResponseInfo * _Nullable serverInfo) {
        if ([serverInfo.response[@"code"] integerValue] == 200) {
            
            NSArray *arr = serverInfo.response[@"data"];
            for (int i = 0; i < [arr count]; i ++) {
                NSDictionary *dic = arr[i];
                OnlineOrderModel *model = [[OnlineOrderModel alloc]initWithDict:dic];
                [self.mData addObject:model];
            }
    
        }else {
            [HUDManager showTextHud:loadError];
        }
    }];
    [self.mTableView reloadData];
}


//MARK:- FlowViewDelegate
- (CGSize)sizeForPageInFlowView:(HQFlowView *)flowView {
    return CGSizeMake(KSCREEN_WIDTH - 2*30, self.topBananerView.frame.size.height-2*3);
}


- (void)didSelectCell:(UIView *)subView withSubViewIndex:(NSInteger)subIndex {
    HomeModel *model = _imgArr[subIndex];
    
    KXWebViewViewController *web = [[KXWebViewViewController alloc]init];
    web.kxurl = model.url;
    web.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:web animated:YES];
}


//MARK:- numberOfPagesInFlowView
- (NSInteger)numberOfPagesInFlowView:(HQFlowView *)flowView {
    return self.imgArr.count;
}


- (HQIndexBannerSubview *)flowView:(HQFlowView *)flowView cellForPageAtIndex:(NSInteger)index {
    
    HQIndexBannerSubview *bannerView = (HQIndexBannerSubview *)[flowView dequeueReusableCell];
    HomeModel *model = self.imgArr[index];
    
    if (!bannerView) {
        bannerView = [[HQIndexBannerSubview alloc] initWithFrame:CGRectMake(0, 0, self.pageFlowView.width, self.pageFlowView.height)];
        bannerView.layer.cornerRadius = 5;
        bannerView.layer.masksToBounds = YES;
    }

    //在这里下载网络图片
        [bannerView.mainImageView sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:nil];
    //加载本地图片
//    bannerView.mainImageView.image = [UIImage imageNamed:self.imgArr[index]];
    
    return bannerView;
    
}

- (void)didScrollToPage:(NSInteger)pageNumber inFlowView:(HQFlowView *)flowView {
    [self.pageFlowView.pageControl setCurrentPage:pageNumber];
}


//MARK:- tableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0 || section == 1)
        return 1;
    else
        return [_mData count];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeTableViewCell *cell = [HomeTableViewCell tempTableViewCellWith:tableView indexPath:indexPath];
    [cell configTempCellWith:indexPath];
    
    cell.tag = indexPath.row;
    if (indexPath.section == 0) {
        if ([self.merchantArr count])
            cell.listArr = self.merchantArr;
        
    }else if (indexPath.section == 1){
        
    }else if (indexPath.section == 2){
        
        if ([self.mData count]) {
            cell.modelist = self.mData[indexPath.row];
        }
        
    }else{}
    
    cell.mblock = ^(NSInteger idx) {
        
    };
    
    return cell;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    CustomSectionView *v;
    @try {
        v = [[NSBundle mainBundle] loadNibNamed:@"CustomSectionView" owner:self options:nil].lastObject;
    } @catch (NSException *exception) {
        NSLog(@"exception = %@", exception);
    } @finally {
        
    }
    
    if (section != 0) {
        v.titimgView.hidden = YES;
        v.titleLabel.hidden = NO;
        v.contentLabel.hidden = NO;
    }else{
        v.titimgView.hidden = NO;
        v.titleLabel.hidden = YES;
        v.contentLabel.hidden = YES;
    }
    
    v.backgroundColor = KSRGBA(255, 255, 255, 1);
    [v setFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 54)];
    
    __weak typeof(&*self)WeakSelf = self;
    v.btnclickBlock = ^(UIButton * _Nonnull btn) {
        if (section == 2) {
            [WeakSelf pushViewControllerWithString:@"OnlineOrderViewController"];
        }else if (section == 0){
            KPost_Notify(@"tabBarController", nil, nil);
        }else{[HUDManager showTextHud:OtherMsg];}
    };
    
    return v;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 54;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [[@[@"138",@"138",@"222"] objectAtIndex:indexPath.section] floatValue];
}


#pragma mark - scrollViewDidScroll
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.mTableView) {
        CGFloat conOffY = scrollView.contentOffset.y;
        CGFloat maxAlphaOffset = 168;
        CGFloat alpha = (conOffY) / (maxAlphaOffset);
        
        [self wr_setNavBarBackgroundAlpha:alpha];
    }
}


-(void)setLoctionStr:(NSString *)loctionStr {
    _loctionStr = loctionStr;
    if (!loctionStr)
        [HUDManager showTextHud:loctionError];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:[self createbtn]];
}


//MARK:-
-(void)action:(UIButton *)item{
    [self pushViewControllerwithString:@"CitylistViewController"];
}


//MARK:- iCarouselDataSource
-(NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel{
    return self.imgOArr.count;
}

-(UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view{
    
    if ([self.imgOArr count] > 0) {
        HomeModel *model = self.imgOArr[index];
        
        if (view == nil) {
            
            view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 120, 140)];
            view.backgroundColor = [UIColor clearColor];
            
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(2, 2, 116, 136)];
            imageView.tag = 1000+index;
            [view addSubview:imageView];
        }
        UIImageView *imageView = [view viewWithTag:1000+index];
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:model.img] completed:nil];
        
        return view;
    }
    return nil;
}


#pragma mark - iCarouselDelegate
- (void)carouselDidEndScrollingAnimation:(iCarousel *)carousel{
    UIView *view = carousel.currentItemView;
    view.backgroundColor = [UIColor whiteColor];
    self.selectView = view;
//    self.filmNameLab.text = self.filmNameArr[carousel.currentItemIndex];
}


- (void)carouselDidScroll:(iCarousel *)carousel{
//    NSLog(@"___2 %lu",carousel.currentItemIndex);
    if (self.selectView != carousel.currentItemView) {
        self.selectView.backgroundColor = [UIColor clearColor];
        UIView *view = carousel.currentItemView;
        view.backgroundColor = [UIColor whiteColor];
    }
}

- (void)carouselCurrentItemIndexDidChange:(iCarousel *)carousel{
    NSLog(@"___3 %lu",carousel.currentItemIndex);
    self.selectView = carousel.currentItemView;
}

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index{
    NSLog(@"点击了第%ld个",index);
    if (index == 0) {
        [self pushViewControllerwithString:ControllerVCArr[index]];
    }else if(index == 1){
        [self pushViewControllerWithString:ControllerVCArr[index]];
    }else if (index == 2){
        [self pushViewControllerWithString:@"OnlineOrderViewController"];
    }else {
        [HUDManager showTextHud:OtherMsg];
    }
}

-(CATransform3D)carousel:(iCarousel *)carousel itemTransformForOffset:(CGFloat)offset baseTransform:(CATransform3D)transform{
    
    static CGFloat max_sacle = 1.0f;
    static CGFloat min_scale = 0.6f;
    
    if (offset <= 1 && offset >= -1) {
        float tempScale = offset < 0 ? 1+offset : 1-offset;
        float slope = (max_sacle - min_scale) / 1;
        CGFloat scale = min_scale + slope * tempScale;
        transform = CATransform3DScale(transform, scale, scale, 1);
    }else{
        transform = CATransform3DScale(transform, min_scale, min_scale,1);
    }
    return CATransform3DTranslate(transform, offset *self.icarousel.itemWidth * 1.2, 0.0, 0.0);
    
}


- (void)setNeedsNavigationBackground:(CGFloat)alpha hidden:(BOOL)hidden{
    if (alpha >= 1)
        hidden = NO;
    [self.navigationController.navigationBar.subviews objectAtIndex:0].hidden = hidden;
    [self.navigationController.navigationBar.subviews objectAtIndex:0].alpha = alpha;
}

- (void)dealloc {
    self.pageFlowView.delegate = nil;
    self.pageFlowView.dataSource = nil;
    [self.pageFlowView stopTimer];
}


-(UIButton *)createbtn {
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    [btn setFrame:CGRectMake(0, 0, 64, 17)];
    [btn setTitle:_loctionStr forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
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
