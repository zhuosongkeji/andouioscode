//
//  ShopingViewController.m
//  OgrinterProduct
//
//  Created by wongshine on 2019/12/6.
//  Copyright © 2019 RXF. All rights reserved.
//


#import "ShopingViewController.h"
#import "ShopingHomeViewController.h"
#import "ShopingShopViewController.h"
#import "ShoingMsgViewController.h"
#import "ShoingMineViewController.h"
#import "SearchResrultViewController.h"
#import "SegmentView.h"


@interface ShopingViewController ()<SegmentViewDelegate>


@property (nonatomic,strong) SegmentView *segmentView;

@property (nonatomic,strong)ShopingHomeViewController *ShopingHomeVc;

@property (nonatomic,strong)ShopingShopViewController *ShopingCategoryVc;
@property (nonatomic,strong)ShoingMsgViewController *ShoingMsgVc;
@property (nonatomic,strong)ShoingMineViewController *ShoingMineVc;

@property (nonatomic,strong)UIView *searchField;

@property (nonatomic,strong)UIButton *searchBtn;

@property (nonatomic) NSInteger HHR;
@property (nonatomic) NSInteger index;

@end


@implementation ShopingViewController


-(UIView *)searchField{
    
    if (!_searchField) {
        _searchField = [[UIView alloc] initWithFrame:CGRectMake(28, 7, KSCREEN_WIDTH-56, 30)];
        _searchField.backgroundColor = KSRGBA(255, 255, 255, 1);
        _searchField.layer.cornerRadius = 16;
        
        _searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_searchBtn setFrame:CGRectMake(16, 0, _searchField.width-32, 30)];
        _searchBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        
        [_searchBtn setTitle:searchplaceholder forState:0];
        [_searchBtn setTitle:searchplaceholder forState:UIControlStateHighlighted];
        [_searchBtn setTitleColor:[UIColor lightGrayColor] forState:0];
        [_searchBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        
        _searchBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_searchBtn addTarget:self action:@selector(searchaction) forControlEvents:UIControlEventTouchUpInside];
        [_searchField addSubview:_searchBtn];
    }
    
    
    return _searchField;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.HHR = 0;
    [self segmentView:self.segmentView didSelectedSegmentAtIndex:0];
    
    self.segmentView = [[SegmentView alloc]initWithTitles:TowTabBarData];
    _segmentView.frame = CGRectMake(0, KSCREEN_HEIGHT - kStatusBarAndNavigationBarH-kStatuTabBarH, KSCREEN_WIDTH, kStatuTabBarH);
    
    _segmentView.delegate = self;
    [self.view addSubview:_segmentView];
    
    self.navigationItem.titleView = self.searchField;
    // Do any additional setup after loading the view.
}


//MARK:-setupChildViewController
- (void)setupChildViewController:(UIViewController *)VC frame:(CGRect)frame title:(NSString *)title {
    VC.view.frame = frame;
    [self.view addSubview:VC.view];
    [self addChildViewController:VC];
    self.navigationItem.title = title;
}


//MARK:-segmentView
- (void)segmentView:(SegmentView *)segmentView didSelectedSegmentAtIndex:(NSInteger)index {
    self.index = index;
    if (index == 0) {
        if (!_ShopingHomeVc) {
            _ShopingHomeVc = [[ShopingHomeViewController alloc] init];
        }
        CGRect frame;
        if (self.HHR == 0) {
            self.HHR = 1;
            frame = CGRectMake(0, 0, KSCREEN_WIDTH,
                               KSCREEN_HEIGHT -kStatuTabBarH);
        }else{
            frame = CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT - kStatusBarAndNavigationBarH-kStatuTabBarH);
        }
        [self setupChildViewController:_ShopingHomeVc frame:frame title:TowTabBarData[0]];
        if (_searchField && _searchField.isHidden == YES) {
            [_searchField setHidden:NO];
        }
        
    } else if (index == 1){
        if (!_ShopingCategoryVc) {
            _ShopingCategoryVc = [[ShopingShopViewController alloc] init];
        }
        CGRect frame = CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT - kStatusBarAndNavigationBarH-kStatuTabBarH);
        [self setupChildViewController:_ShopingCategoryVc frame:frame title:TowTabBarData[1]];
        if (_searchField && _searchField.isHidden == YES) {
            [_searchField setHidden:NO];
        }
    }else if (index == 2){
        if (!_ShoingMsgVc) {
            _ShoingMsgVc = [[ShoingMsgViewController alloc] init];
        }
        CGRect frame = CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT - kStatusBarAndNavigationBarH-kStatuTabBarH);
        [self setupChildViewController:_ShoingMsgVc frame:frame title:TowTabBarData[2]];
        [_searchField setHidden:YES];
    }else{
        if (!_ShoingMineVc) {
            _ShoingMineVc = [[ShoingMineViewController alloc] init];
        }
        CGRect frame = CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT - kStatusBarAndNavigationBarH-kStatuTabBarH);
        [self setupChildViewController:_ShoingMineVc frame:frame title:TowTabBarData[3]];
        [_searchField setHidden:YES];
    }
}


//MARK:- searchaction
-(void)searchaction {
    SearchResrultViewController *result = [[SearchResrultViewController alloc]init];
    if (self.index == 0) {
        result.type = SearchCollectionViewtypeOne;
    }else if (self.index == 1){
        result.type = SearchCollectionViewtypeTwo;
    }else {}
    
    [self.navigationController pushViewController:result animated:YES];
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


