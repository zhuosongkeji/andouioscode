//
//  HomeViewController.m
//  OgrinterProduct
//
//  Created by wongshine on 2019/11/28.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "HomeViewController.h"
#import "HQImagePageControl.h"
#import "CustomSectionView.h"
#import "HomeTableViewCell.h"
#import "CitylistViewController.h"

#import "HQFlowView.h"
#import "MarqueeView.h"
#import "RedPacketView.h"
#import "PacketModel.h"


@interface HomeViewController ()<HQFlowViewDelegate,HQFlowViewDataSource,UITableViewDataSource,UITableViewDelegate>


@property (weak, nonatomic) IBOutlet UITableView *mTableView;
@property (weak, nonatomic) IBOutlet UIView *topBananerView;
@property (weak, nonatomic) IBOutlet UIView *noticeView;
@property (weak, nonatomic) IBOutlet UIView *noticebjView;

@property (nonatomic, strong) HQImagePageControl *pageC;
@property (nonatomic, strong) HQFlowView *pageFlowView;
@property (nonatomic,strong) NSMutableArray *imgArr;
@property (nonatomic,strong) MarqueeView *queeView;

@end

@implementation HomeViewController


//MARK:-imgArr
-(NSMutableArray *)imgArr {
    if (!_imgArr) {
        _imgArr = [NSMutableArray arrayWithObjects:@"image1",
                   @"image2",
                   @"image3",
                   @"image4", nil];
    }
    return _imgArr;
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


- (HQImagePageControl *)pageC
{
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
        _queeView = [[MarqueeView alloc]initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH - 74,30) withTitle:@[@"这是一条测试数据",@"这又是一条测试数据",@"这还是一条测试数据"]];
        _queeView.titleFont = [UIFont systemFontOfSize:12];
        
        self.queeView.handlerTitleClickCallBack = ^(NSInteger index){
            
        };
    }
    return _queeView;
}


//MARK:- viewDidLoad
- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.navigationItem.title = @"";
    
    [self.topBananerView addSubview:self.pageFlowView];
    [self.noticebjView addSubview:self.queeView];
    [self.pageFlowView addSubview:self.pageC];
    [self.pageFlowView reloadData];//刷新轮播
    
    // Do any additional setup after loading the view from its nib.
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self openRedPacket];
}


//MARK:- openRedPacket
- (void)openRedPacket {
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


//MARK:- FlowViewDelegate
- (CGSize)sizeForPageInFlowView:(HQFlowView *)flowView {
    return CGSizeMake(KSCREEN_WIDTH - 2*30, self.topBananerView.frame.size.height-2*3);
}


- (void)didSelectCell:(UIView *)subView withSubViewIndex:(NSInteger)subIndex {
    if (subIndex == 1) {
//        商城
//        CustomBarViewController *tabbar = [[CustomBarViewController alloc]initFrame:CustomBarTypeTwo];
//        UIWindow *window = [[UIApplication sharedApplication].delegate window];
//        CATransition *animation = [CATransition animation];
//        [animation setType:kCATransitionPush];
//        [animation setSubtype:kCATransitionFromRight];
//        [animation setDuration:0.3];
//        [[window layer] addAnimation:animation forKey:nil];
//        window.rootViewController = tabbar;
        
    }
}


//MARK:- numberOfPagesInFlowView
- (NSInteger)numberOfPagesInFlowView:(HQFlowView *)flowView {
    return self.imgArr.count;
}


- (HQIndexBannerSubview *)flowView:(HQFlowView *)flowView cellForPageAtIndex:(NSInteger)index {
    
    HQIndexBannerSubview *bannerView = (HQIndexBannerSubview *)[flowView dequeueReusableCell];
    
    if (!bannerView) {
        bannerView = [[HQIndexBannerSubview alloc] initWithFrame:CGRectMake(0, 0, self.pageFlowView.frame.size.width, self.pageFlowView.frame.size.height)];
        bannerView.layer.cornerRadius = 5;
        bannerView.layer.masksToBounds = YES;
        bannerView.coverView.backgroundColor = [UIColor darkGrayColor];
    }
    //在这里下载网络图片
    //    [bannerView.mainImageView sd_setImageWithURL:[NSURL URLWithString:self.advArray[index]] placeholderImage:nil];
    //加载本地图片
    bannerView.mainImageView.image = [UIImage imageNamed:self.imgArr[index]];
    
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
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 1;
    }else {
        return 4;
    }
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HomeTableViewCell *cell = [HomeTableViewCell tempTableViewCellWith:tableView indexPath:indexPath];
    
    [cell configTempCellWith:indexPath];
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // 取消Cell的选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    CustomSectionView *v = [[NSBundle mainBundle] loadNibNamed:@"CustomSectionView" owner:self options:nil].lastObject;
    v.backgroundColor = [UIColor whiteColor];
    [v setFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 54)];
    
    return v;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 54;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 || indexPath.section == 1) {
        return 128;
    }
    return 168;
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
//    [btn setImage:[UIImage imageNamed:@"image"] forState:UIControlStateNormal];
//    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, - btn.imageView.image.size.width, 0, btn.imageView.image.size.width)];
//    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, btn.titleLabel.bounds.size.width, 0, -btn.titleLabel.bounds.size.width)];
    
    return btn;
}


-(void)setLoctionStr:(NSString *)loctionStr {
    _loctionStr = loctionStr;
    if (!loctionStr)
        [HUDManager showTextHud:loctionError];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:[self createbtn]];
}


//MARK:-
-(void)action:(UIButton *)item{
    CitylistViewController *citylist = [[CitylistViewController alloc] init];
    citylist.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:citylist animated:YES];
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
