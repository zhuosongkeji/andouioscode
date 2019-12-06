//
//  ShopingHomeViewController.m
//  OgrinterProduct
//
//  Created by wongshine on 2019/11/29.
//  Copyright © 2019 RXF. All rights reserved.
//


#import "ShopingHomeViewController.h"
#import "SearchResrultViewController.h"
#import "MDShockBannerView.h"
#import "ShopHomeSectionView.h"
#import "ShopHomeViewCell.h"
#import "MDBannerModel.h"


@interface ShopingHomeViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchControllerDelegate,UISearchResultsUpdating>

@property (nonatomic,strong) MDShockBannerView *bannerView;
@property (nonatomic,strong)UIButton *searchBtn;

@property (weak, nonatomic) IBOutlet UITableView *mTableView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toTop;


@end


@implementation ShopingHomeViewController


//MARK:- MDShockBannerView
-(MDShockBannerView *)bannerView {
    if (!_bannerView) {
        _bannerView = [[MDShockBannerView alloc]initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, bannerH)];
        _bannerView.pageSelectImage = [UIImage imageNamed:@"dati2"];
        _bannerView.pageUnselectImage = [UIImage imageNamed:@"dati1"];
        MDBannerModel *model = [[MDBannerModel alloc]init];
        MDBannerModel *model2 = [[MDBannerModel alloc]init];
        model.img = @"http://md-juhe.oss-cn-hangzhou.aliyuncs.com/upload/ad/20180417/6265b5b9bf8686f009cf44c366cfa4abd26b1a79.png";
        model.bgImg = @"http://md-juhe.oss-cn-hangzhou.aliyuncs.com/upload/ad/20180417/9bc42ce40490c854eab2e9969ac8e328caab0a17.png";
        
        model2.img = @"http://md-juhe.oss-cn-hangzhou.aliyuncs.com/upload/ad/20180417/16f7ab6124ae4688f0adef43ff3ab3b1f09ccc67.png";
        model2.bgImg = @"http://md-juhe.oss-cn-hangzhou.aliyuncs.com/upload/ad/20180417/81e9ad49cba8dc479a09d146a1fabf4b9ef3504d.png";
        
        _bannerView.banners = @[model,model2];
        
    }
    
    return _bannerView;
}


-(UIView *)headBanner {
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, bannerH)];
    [v addSubview:self.bannerView];
    
    return v;
}


-(UIView *)searchField{
        
    UIView *titView = [[UIView alloc] initWithFrame:CGRectMake(28, 7, KSCREEN_WIDTH-56, 30)];
    titView.backgroundColor = KSRGBA(255, 255, 255, 1);
    titView.layer.cornerRadius = 16;
    
    _searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_searchBtn setFrame:CGRectMake(16, 0, titView.width-32, 30)];
    _searchBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    
    [_searchBtn setTitle:searchplaceholder forState:0];
    [_searchBtn setTitle:searchplaceholder forState:UIControlStateHighlighted];
    [_searchBtn setTitleColor:[UIColor lightGrayColor] forState:0];
    [_searchBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    
    _searchBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [_searchBtn addTarget:self action:@selector(searchaction) forControlEvents:UIControlEventTouchUpInside];
    [titView addSubview:_searchBtn];
    
    return titView;
}


//MARK:- viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];

    self.toTop.constant = kStatusBarAndNavigationBarHeight;
    self.mTableView.tableFooterView = [UILabel new];
    self.mTableView.tableHeaderView = self.headBanner;
    self.navigationItem.titleView = [self searchField];
    
    [self.mTableView registerNib:[UINib nibWithNibName:@"ShopHomeViewCell" bundle:nil] forCellReuseIdentifier:@"ShopHomeViewCell"];
    
    // Do any additional setup after loading the view from its nib.
}


//MARK: -TableViewDelegate or dataScroe
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ShopHomeViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShopHomeViewCell"];
    if (!cell) {
        NSLog(@"创建cell");
    }
    
    return cell;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    ShopHomeSectionView *v = [[NSBundle mainBundle]loadNibNamed:@"ShopHomeSectionView" owner:self options:nil].lastObject;
    v.backgroundColor = KSRGBA(255, 255, 255, 1);
    
    return v;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 64;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 234*5+60;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // 取消Cell的选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


//MARK:-scrollView
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offY = scrollView.contentOffset.y;
    if (offY >= (bannerH-kStatusBarAndNavigationBarH) ) {
        [self defnavalpha];
    }else{
        [self setnavalpha];
    }
}


//MARK:-setnavalpha
-(void)setnavalpha{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
}


-(void)defnavalpha {
    self.navigationController.navigationBar.translucent = YES; [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav"] forBarMetrics:UIBarMetricsDefault];
}


//MARK:- searchaction
-(void)searchaction {
    SearchResrultViewController *result = [[SearchResrultViewController alloc]init];
    [self presentViewController:result animated:NO completion:^{
        
    }];
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
