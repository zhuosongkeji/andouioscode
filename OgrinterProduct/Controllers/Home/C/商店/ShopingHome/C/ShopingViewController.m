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
#import "ZBNShopingCartVC.h"
#import "ShoingMineViewController.h"
#import "SearchResrultViewController.h"
#import "CategorySetingViewController.h"
#import "SegmentView.h"


@interface ShopingViewController ()<SegmentViewDelegate>


@property (nonatomic,strong) SegmentView *segmentView;
@property (nonatomic,strong)ShopingHomeViewController *ShopingHomeVc;

@property (nonatomic,strong)ShopingShopViewController *ShopingCategoryVc;
@property (nonatomic,strong)ZBNShopingCartVC *ShoingMsgVc;
@property (nonatomic,strong)ShoingMineViewController *ShoingMineVc;

@property (nonatomic,strong)UIView *searchField;
@property (nonatomic,strong)UIButton *searchBtn;
@property (nonatomic,strong)UIButton *rightitem;

@property (nonatomic) NSInteger HHR;
@property (nonatomic) NSInteger index;

@property (nonatomic,strong)UIView *titleView;
@property (nonatomic,strong)UILabel *titletxet;

@end


@implementation ShopingViewController


-(UIView *)searchField{
    
    if (!_searchField) {
        _searchField = [[UIView alloc] initWithFrame:CGRectMake(28, 7, KSCREEN_WIDTH-100, 30)];
        _searchField.backgroundColor = KSRGBA(255, 255, 255, 1);
        _searchField.layer.cornerRadius = 14;
        
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


-(UIView *)titleView{
    if (!_titleView) {
        _titleView = [[UIView alloc]initWithFrame:CGRectMake(28, 7, KSCREEN_WIDTH-56, 30)];
        _titleView.backgroundColor = [UIColor clearColor];
        _titletxet = [[UILabel alloc]initWithFrame:CGRectMake(0, 5, KSCREEN_WIDTH-56, 21)];
        _titletxet.textColor = KSRGBA(255, 255, 255, 1);
        _titletxet.font = [UIFont systemFontOfSize:18];
        _titletxet.textAlignment = NSTextAlignmentCenter;
        [_titleView addSubview:_titletxet];
    }
    return _titleView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.HHR = 0;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.rightitem];
    
    [self segmentView:self.segmentView didSelectedSegmentAtIndex:0];
    
    self.segmentView = [[SegmentView alloc]initWithTitles:TowTabBarData];
    _segmentView.frame = CGRectMake(0, KSCREEN_HEIGHT -kStatuTabBarH, KSCREEN_WIDTH, kStatuTabBarH);
    
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
//        if (self.HHR == 0) {
//            self.HHR = 1;
//            frame = CGRectMake(0, 0, KSCREEN_WIDTH,
//                               KSCREEN_HEIGHT -kStatuTabBarH);
//        }else{
            frame = CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT - kStatuTabBarH);
//        }
        [self setupChildViewController:_ShopingHomeVc frame:frame title:TowTabBarData[0]];
        self.navigationItem.titleView = self.searchField;
        [_rightitem setHidden:YES];
        
    } else if (index == 1){
        if (!_ShopingCategoryVc) {
            _ShopingCategoryVc = [[ShopingShopViewController alloc] init];
        }
        CGRect frame = CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT - kStatuTabBarH);
        [self setupChildViewController:_ShopingCategoryVc frame:frame title:TowTabBarData[1]];
        self.navigationItem.titleView = self.searchField;
        [_rightitem setHidden:NO];
    }else if (index == 2){
        if (!_ShoingMsgVc) {
            _ShoingMsgVc = [[ZBNShopingCartVC alloc] init];
        }
        CGRect frame = CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT - kStatuTabBarH);
        [self setupChildViewController:_ShoingMsgVc frame:frame title:TowTabBarData[2]];
        self.navigationItem.titleView = self.titleView;
        _titletxet.text = @"购物车";
        [_rightitem setHidden:YES];
    }else{
        if (!_ShoingMineVc) {
            _ShoingMineVc = [[ShoingMineViewController alloc] init];
        }
        
        CGRect frame = CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT - kStatuTabBarH);
        [self setupChildViewController:_ShoingMineVc frame:frame title:TowTabBarData[3]];
        self.navigationItem.titleView = self.titleView;
        _titletxet.text = @"消息";
        [_rightitem setHidden:YES];
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


-(void)btnAction:(UIButton *)action {
    KPreventRepeatClickTime(1)
    CategorySetingViewController *set = [[CategorySetingViewController alloc]init];
    [self.navigationController pushViewController:set animated:YES];
}


-(UIButton *)rightitem {
    
    if (!_rightitem) {
        _rightitem = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightitem setFrame:CGRectMake(0, 0, 30, 30)];
        [_rightitem setBackgroundImage:[UIImage imageNamed:@"category"] forState:0];
        [_rightitem addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [_rightitem setHidden:YES];
    }
    return _rightitem;
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


