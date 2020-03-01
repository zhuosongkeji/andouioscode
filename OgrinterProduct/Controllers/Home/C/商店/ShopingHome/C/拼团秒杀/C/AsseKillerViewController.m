//
//  AsseKillerViewController.m
//  OgrinterProduct
//
//  Created by wongshine on 2020/2/20.
//  Copyright © 2020 RXF. All rights reserved.
//

#define grouptoday_top @"group/today_top"
#define groupgroup_cate @"group/group_cate"


#import "AsseKillerViewController.h"
#import "HotelBottomTableViewCell.h"
#import "AssembleKillSubViewController.h"
#import "WSLWaterFlowLayout.h"
#import "AsseCollectionViewCell1.h"
#import "AsseCollectionViewCell2.h"
#import "ShopSeckillDetailsViewController.h"
#import "AssembModel.h"
#import "KillerListAessbModel.h"



@interface AsseKillerViewController ()<UITableViewDelegate,UITableViewDataSource,FSPageContentViewDelegate,FSSegmentTitleViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,WSLWaterFlowLayoutDelegate>{
    NSInteger page;
}

@property (weak, nonatomic) IBOutlet UITableView *mTableView;
@property (weak, nonatomic) IBOutlet UICollectionView *mCollectionView1;
@property (weak, nonatomic) IBOutlet UICollectionView *mCollectionView2;
@property(nonatomic)WSLWaterFlowLayout *layout1;
@property(nonatomic)WSLWaterFlowLayout *layout2;


@property (nonatomic, strong) HotelBottomTableViewCell *contentCell;
@property (nonatomic, assign) BOOL canScroll;
@property (nonatomic, strong) FSSegmentTitleView *titleView;

@property(nonatomic,strong)NSMutableArray *dataArr;

@property(nonatomic,strong)NSArray *titArr;

@end

@implementation AsseKillerViewController


-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self wr_setNavBarBackgroundAlpha:0];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
//    page = 1;
    [self setup];
    
    // Do any additional setup after loading the view from its nib.
}

-(void)setup{
    
    _layout1 = [[WSLWaterFlowLayout alloc]init];
    _layout2 = [[WSLWaterFlowLayout alloc]init];
    
    _layout1.delegate = self;
    _layout2.delegate = self;
    
    self.mCollectionView1.delegate = self;
    self.mCollectionView2.delegate = self;
    self.mCollectionView1.dataSource = self;
    self.mCollectionView2.dataSource = self;
    
    KAdd_Observer(@"AOtherTop", self, hangeScroll, nil);
    self.canScroll = YES;
    self.mTableView.tableFooterView = [UILabel new];
    
    
    [self.mCollectionView1 setCollectionViewLayout:_layout1];
    [self.mCollectionView2 setCollectionViewLayout:_layout2];
    
    [self.mCollectionView1 registerNib:[UINib nibWithNibName:@"AsseCollectionViewCell1" bundle:nil] forCellWithReuseIdentifier:@"AsseCollectionViewCell1"];
    
    [self.mCollectionView2 registerNib:[UINib nibWithNibName:@"AsseCollectionViewCell2" bundle:nil] forCellWithReuseIdentifier:@"AsseCollectionViewCell2"];
    [self loadnetWork];
}

//MARK:今日必拼
-(void)loadnetWork{
    
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_enter(group);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSString *url = [NSString stringWithFormat:@"%@%@",API_BASE_URL_STRING,grouptoday_top];
        [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_GET pathUrl:url params:@{} complement:^(ServerResponseInfo * _Nullable serverInfo) {
            if ([serverInfo.response[@"code"] integerValue] == 200) {
                NSDictionary *dict = serverInfo.response[@"data"];
                AssembModel *model = [[AssembModel alloc]initWithDict:dict];
                [self.dataArr addObject:model];
                
                dispatch_group_leave(group);
            }else {
                dispatch_group_leave(group);
                [HUDManager showTextHud:loadError];
            }
            
        }];
    });
    
    dispatch_group_enter(group);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSString *url1 = [NSString stringWithFormat:@"%@%@",API_BASE_URL_STRING,groupgroup_cate];
        [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_GET pathUrl:url1 params:@{} complement:^(ServerResponseInfo * _Nullable serverInfo) {
            if ([serverInfo.response[@"code"] integerValue] == 200) {
                NSArray *arr = serverInfo.response[@"data"];
                NSMutableArray *mArr = [NSMutableArray array];
                for (int i = 0; i < [arr count];i ++) {
                    NSDictionary *dic = arr[i]; KillerListAessbModel *model = [[KillerListAessbModel alloc]init];
                    model.kid = dic[@"id"];
                    model.name = dic[@"name"];
                    [mArr addObject:model];
                }
                self.titArr = [NSArray arrayWithArray:mArr];
                dispatch_group_leave(group);
            }else {
                dispatch_group_leave(group);
                [HUDManager showTextHud:loadError];
            }
            
            
        }];
    });
    
    
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        
        [self.mCollectionView1 reloadData];
        [self.mCollectionView2 reloadData];
        [self.mTableView reloadData];
        
    });
    
}


//MARK:-
-(void)hangeScroll {
    self.canScroll = YES;
    self.contentCell.cellCanScroll = NO;
}


//MARK:-collection
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if ([self.dataArr count]) {
        AssembModel *model = self.dataArr[0];
        return [model.today_goods count];
    }
    return 0;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView == self.mCollectionView1) {
        AsseCollectionViewCell1 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AsseCollectionViewCell1" forIndexPath:indexPath];
        
        if ([self.dataArr count]){
            AssembModel *model = self.dataArr[0];
            KillerListAessbModel *m = model.today_goods[indexPath.item];
            cell.listmodel = m;
        }
        
        return cell;
    }else if (collectionView == self.mCollectionView2){
        AsseCollectionViewCell2 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AsseCollectionViewCell2" forIndexPath:indexPath];
        
        if ([self.dataArr count]){
            AssembModel *model = self.dataArr[0];
            KillerListAessbModel *m = model.hot_goods[indexPath.item];
            cell.lmodele = m;
        }
        
        return cell;
    }
    
    return nil;
}



-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ShopSeckillDetailsViewController *shoper = [[ShopSeckillDetailsViewController alloc]init];
    
    if ([self.dataArr count]){
        AssembModel *model = self.dataArr[0];
        
        if (collectionView == self.mCollectionView1) {
            KillerListAessbModel *m = model.today_goods[indexPath.item];
            shoper.cpid = m.goods_id;
        }else if (collectionView == self.mCollectionView2){
            KillerListAessbModel *m = model.hot_goods[indexPath.item];
            shoper.cpid = m.kid;
        }else{}
    }
    
    shoper.seckillType = ShopSeckillDetailsTypeOther;
    
    [self.navigationController pushViewController:shoper animated:YES];
}


//MARK:-WSLWaterFlowLayout
- (CGSize)waterFlowLayout:(WSLWaterFlowLayout *)waterFlowLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (waterFlowLayout == _layout1) {
        return CGSizeMake((self.view.width-30)/2,154);
    }else if (waterFlowLayout == _layout2){
        if (indexPath.row == 0) {
            return CGSizeMake((self.view.width-40)/2,226);
        }else{
            return CGSizeMake((self.view.width-40)/2,108);
        }
    }
    return CGSizeZero;
}

-(CGFloat)columnCountInWaterFlowLayout:(WSLWaterFlowLayout *)waterFlowLayout{
    if (waterFlowLayout == _layout1) {
        return 3;
    }else if (waterFlowLayout == _layout2){
        return 2;}
    return 0;
}

/** 行数*/
-(CGFloat)rowCountInWaterFlowLayout:(WSLWaterFlowLayout *)waterFlowLayout{
    return 1;
}

/** 列间距*/
-(CGFloat)columnMarginInWaterFlowLayout:(WSLWaterFlowLayout *)waterFlowLayout{
    return 10;
}
/** 行间距*/
-(CGFloat)rowMarginInWaterFlowLayout:(WSLWaterFlowLayout *)waterFlowLayout{
    return 10;
}
/** 边缘之间的间距*/
-(UIEdgeInsets)edgeInsetInWaterFlowLayout:(WSLWaterFlowLayout *)waterFlowLayout{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}


//MARK:-UITableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    _contentCell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!_contentCell) {
        _contentCell = [[HotelBottomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell" withtype:HotelBottomTableViewCellTypeFouth];
        _contentCell.contentView.backgroundColor = [UIColor redColor];
        
    }
    
    NSMutableArray *contentVCs = [NSMutableArray array];
    if (self.titArr.count > 0) {
        for (int i = 0 ; i < self.self.titArr.count; i++) {
            AssembleKillSubViewController *vc = [[AssembleKillSubViewController alloc]init];
            KillerListAessbModel *mode = self.titArr[i];
            vc.title = mode.name;
            vc.str = vc.title;
            vc.aid = mode.kid;
            
            [contentVCs addObject:vc];
            
        }
    }
    
    _contentCell.viewControllers = contentVCs;
    _contentCell.pageContentView = [[FSPageContentView alloc]initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT-kStatusBarAndNavigationBarH) childVCs:contentVCs parentVC:self delegate:self];
    [_contentCell.contentView addSubview:_contentCell.pageContentView];
    
    return _contentCell;
    
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NSMutableArray *tArr = [NSMutableArray array];
    for (int i = 0; i < [self.titArr count]; i ++) {
        KillerListAessbModel *mode = self.titArr[i];
        [tArr addObject:mode.name];
    }
    self.titleView = [[FSSegmentTitleView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 50) titles:tArr delegate:self indicatorType:FSIndicatorTypeEqualTitle];
    self.titleView.backgroundColor = KSRGBA(255, 255, 255, 255);
    
    return self.titleView;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return KSCREEN_HEIGHT;
}



//MARK:- UIScrollView
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat bottomCellOffset = [self.mTableView rectForSection:0].origin.y-kStatusBarAndNavigationBarH;
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



-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"AOtherTop" object:nil];
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
