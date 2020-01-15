//
//  ShopShopkeeperViewController.m
//  OgrinterProduct
//
//  Created by wongshine on 2019/12/16.
//  Copyright © 2019 RXF. All rights reserved.
//

#define merchant_goods @"merchant/merchant_goods"

#import "ShopCollectionViewCell.h"
#import "ShopShopkeeperViewController.h"
#import "MenuScreeningView.h"
#import "CuomtentView.h"
#import "WSLWaterFlowLayout.h"
#import "SearchResrultViewController.h"
#import "ShoperModel.h"


@interface ShopShopkeeperViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,WSLWaterFlowLayoutDelegate,CuomtentViewDelegate>


@property (weak, nonatomic) IBOutlet UICollectionView *mCollectionView;


@property (nonatomic,strong) MenuScreeningView *menuScreeningView;
@property (weak, nonatomic) IBOutlet UIImageView *topimgView;

@property (weak, nonatomic) IBOutlet UIImageView *login_imgView;

@property (weak, nonatomic) IBOutlet UILabel *shoperNameLabel;

@property (nonatomic,strong)NSMutableArray *dataArr;

@property (nonatomic,strong)CuomtentView *cmenuView;
@property(nonatomic,weak)UIButton *bjbtn;

@property (nonatomic,strong)NSDictionary *sdict;

@property (nonatomic,strong)UIView *searchField;

@property (nonatomic,strong)UIButton *searchBtn;


@end


@implementation ShopShopkeeperViewController


-(NSMutableArray *)dataArr{
    
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

-(UIView *)searchField{
    
    if (!_searchField) {
        
        _searchField = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topimgView.frame), KSCREEN_WIDTH, 44)];
        
        _searchField.backgroundColor = KSRGBA(255, 255, 255, 1);
        _searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _searchBtn.layer.cornerRadius = 6;
        _searchBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        _searchBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        
        [_searchBtn setBackgroundColor:KSRGBA(240, 240, 240, 1)];
        [_searchBtn setFrame:CGRectMake(16, 12, _searchField.width-32, 30)];
        [_searchBtn setTitle:[NSString stringWithFormat:@"   %@",searchplaceholder] forState:0];
        [_searchBtn setTitle:[NSString stringWithFormat:@"   %@",searchplaceholder] forState:UIControlStateHighlighted];
        [_searchBtn setTitleColor:[UIColor lightGrayColor] forState:0];
        
        [_searchBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        [_searchBtn addTarget:self action:@selector(ssearchaction) forControlEvents:UIControlEventTouchUpInside];
        [_searchField addSubview:_searchBtn];
    }
    
    return _searchField;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"店铺详情";
    
    [self loadmColletion];
    [self setup];
    
    [self loadNetWork:@{@"id":self.shoperId,@"uid":self.u_id} type:@"nonal"];
    // Do any additional setup after loading the view from its nib.
}


//MARK:-
-(void)loadNetWork:(NSDictionary *)dict type:(NSString *)types{
    
    NSString *url = [NSString stringWithFormat:@"%@%@",API_BASE_URL_STRING,merchant_goods];
    
    [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:url params:dict complement:^(ServerResponseInfo * _Nullable serverInfo) {
        
        if ([serverInfo.response[@"code"] integerValue] == 200) {
            NSDictionary *dict1 = serverInfo.response[@"data"];
            
            if ([self.dataArr count] > 0)
                [self.dataArr removeAllObjects];
            
            ShoperModel *model = [[ShoperModel alloc]initWithDict:dict1];
                
            [self.dataArr addObject:model];
            
            if ([types isEqualToString:@"nonal"]) {
                [self.topimgView sd_setImageWithURL:[NSURL URLWithString:model.bannerImg] completed:nil];
                [self.login_imgView sd_setImageWithURL:[NSURL URLWithString:model.logoimg] completed:nil];
                self.shoperNameLabel.text = model.name;
                [_cmenuView setTypArr:model.typesArr];
            }else {}
            
            [self.mCollectionView reloadData];
            
        }else {
            [HUDManager showTextHud:loadError];
        }
        
    }];
}


-(void)setup {
    
    UIButton *btn1 = [self createbtn:CGRectMake(0, kStatusBarAndNavigationBarH, KSCREEN_WIDTH*0.2, KSCREEN_HEIGHT-kStatusBarAndNavigationBarH) Action:@selector(dissView:) BackGroundColor:[UIColor colorWithWhite:0.4 alpha:0.4]];
    [[UIApplication sharedApplication].keyWindow addSubview:self.bjbtn = btn1];
    
    [self.bjbtn setHidden:YES];
    
    UIButton *btn = [self createbtn:CGRectMake(2*(KSCREEN_WIDTH/3)+1, 0, KSCREEN_WIDTH-1,36) Action:@selector(action) BackGroundColor:nil];
    
    _cmenuView = [[NSBundle mainBundle]loadNibNamed:@"CuomtentView" owner:self options:nil].lastObject;
    [_cmenuView setFrame:CGRectMake(KSCREEN_WIDTH, kStatusBarAndNavigationBarH, KSCREEN_WIDTH*0.8, KSCREEN_HEIGHT-kStatusBarAndNavigationBarH)];
    _cmenuView.delegate = self;
    
    _menuScreeningView = [[MenuScreeningView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topimgView.frame)+44, KSCREEN_WIDTH, MenuHeight) title:@[@"销量",@"价格"] withtype:MenuScreeningViewTypeOne];
    
    _menuScreeningView.backgroundColor = KSRGBA(255, 255, 255, 1);
    
    
    [self.view addSubview:self.searchField];
    
    [_menuScreeningView addSubview:btn];
    [self.view addSubview:_menuScreeningView];
    [self.view addSubview:self.cmenuView];
    
}

-(void)loadmColletion{
    
    WSLWaterFlowLayout *layout = [[WSLWaterFlowLayout alloc]init];
    
    layout.delegate = self;
    
    [self.mCollectionView setCollectionViewLayout:layout];
    
    [self.mCollectionView registerNib:[UINib nibWithNibName:@"ShopCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"ShopCollectionViewCell"];
}


//MARK:-collection
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if ([self.dataArr count] > 0) {
        ShoperModel *model = self.dataArr[0];
        return [model.goodsArr count];
    }
    return 0;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ShopCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ShopCollectionViewCell" forIndexPath:indexPath];
    
    if ([self.dataArr count] > 0) {
        ShoperModel *model = self.dataArr[0];
        cell.listmodels = model.goodsArr[indexPath.item];
    }
    
    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

//MARK:-WSLWaterFlowLayout
- (CGSize)waterFlowLayout:(WSLWaterFlowLayout *)waterFlowLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((KSCREEN_WIDTH-30)/2,234);}


-(CGFloat)columnCountInWaterFlowLayout:(WSLWaterFlowLayout *)waterFlowLayout{
    return 2;}

/** 行数*/
-(CGFloat)rowCountInWaterFlowLayout:(WSLWaterFlowLayout *)waterFlowLayout{
    if ([self.dataArr count] > 0) {
        ShoperModel *model = self.dataArr[0];
        if ([model.goodsArr count]%2 == 0) {
            return [model.goodsArr count]/2;
        }else
            return [model.goodsArr count]/2+1;
    }
    return 0;
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

//MARK:- search
-(void)ssearchaction{
    SearchResrultViewController *search = [[SearchResrultViewController alloc]init];
    [search setType:SearchCollectionViewtypeOne];
    [self.navigationController pushViewController:search animated:YES];
}


-(void)didselectSure:(NSString *)uid index:(NSInteger)index{
    if (index == 2000) {
        
    }else{
        self.sdict = @{@"id":self.shoperId,@"uid":self.u_id,@"type_id":uid};
        [self dissView:@"load"];
    }
    
}


-(void)action{
    
    KPreventRepeatClickTime(1);
    [UIView animateWithDuration:0.3 animations:^{
        _cmenuView.frame = CGRectMake(KSCREEN_WIDTH - KSCREEN_WIDTH *0.8, kStatusBarAndNavigationBarH, KSCREEN_WIDTH *0.8, KSCREEN_HEIGHT-kStatusBarAndNavigationBarH);

    } completion:^(BOOL finished) {
        [self.bjbtn setHidden:NO];
    }];
}


-(void)dissView:(NSString *)type{
    KPreventRepeatClickTime(1);
    [UIView animateWithDuration:0.3 animations:^{
        [self.bjbtn setHidden:YES];
        _cmenuView.frame = CGRectMake(KSCREEN_WIDTH, kStatusBarAndNavigationBarH, KSCREEN_WIDTH *0.8, KSCREEN_HEIGHT-kStatusBarAndNavigationBarH);
    } completion:^(BOOL finished) {
        if ([type isKindOfClass:[UIButton class]])
            return ;
        if ([type isEqualToString:@"load"]) {
            [self loadNetWork:self.sdict type:nil];
        }
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

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self dissView:nil];
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
