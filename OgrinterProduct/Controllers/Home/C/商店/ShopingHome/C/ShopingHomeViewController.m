//
//  ShopingHomeViewController.m
//  OgrinterProduct
//
//  Created by wongshine on 2019/11/29.
//  Copyright © 2019 RXF. All rights reserved.
//

#define shopApi @"goods/index"


#import "ShopingHomeViewController.h"
#import "ShopSeckillDetailsViewController.h"
#import "MDShockBannerView.h"
#import "ShopHomeSectionView.h"
#import "ShopHomeViewCell.h"
#import "MDBannerModel.h"
#import "MdBannerListModel.h"


@interface ShopingHomeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) MDShockBannerView *bannerView;

@property (weak, nonatomic) IBOutlet UITableView *mTableView;

@property (weak, nonatomic) IBOutlet UIView *topBannerView;

@property (nonatomic,strong)NSMutableArray *dataArr;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toTop;


@end


@implementation ShopingHomeViewController


-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

//MARK:- MDShockBannerView
-(MDShockBannerView *)bannerView {
    if (!_bannerView) {
        _bannerView = [[MDShockBannerView alloc]initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, bannerH)];
        _bannerView.pageSelectImage = [UIImage imageNamed:@"dati2"];
        _bannerView.pageUnselectImage = [UIImage imageNamed:@"dati1"];
        if (self.dataArr) {
            MDBannerModel *model = [self.dataArr objectAtIndex:0];
            NSArray *array = [model.dataDic objectForKey:@"banner"];
            NSMutableArray *listArr = [NSMutableArray array];
            for (int i = 0; i < [array count]; i ++) {
                MdBannerListModel *list = array[i];
                list.bgImg = @"http://md-juhe.oss-cn-hangzhou.aliyuncs.com/upload/ad/20180417/9bc42ce40490c854eab2e9969ac8e328caab0a17.png";
                [listArr addObject:list];
            }
            _bannerView.banners = listArr;
        }
    }
    
    return _bannerView;
}


//MARK:- viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
    [self loadNetWork];
    // Do any additional setup after loading the view from its nib.
}


-(void)loadNetWork{
    NSString *url = [NSString stringWithFormat:@"%@%@",API_BASE_URL_STRING,shopApi];
    [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:url params:@{} complement:^(ServerResponseInfo * _Nullable serverInfo) {
        if ([serverInfo.response[@"code"] integerValue] == 200) {
            NSDictionary *dict = serverInfo.response[@"data"];
            MDBannerModel *model = [[MDBannerModel alloc] initWithDict:dict];
            [self.dataArr addObject:model];
            
            [self.topBannerView addSubview:self.bannerView];
            [self.mTableView reloadData];
            [self.mTableView.mj_header endRefreshing];
        }
    }];
}


-(void)setup{
    
    self.mTableView.tableFooterView = [UILabel new];
    
    [self.mTableView registerNib:[UINib nibWithNibName:@"ShopHomeViewCell" bundle:nil] forCellReuseIdentifier:@"ShopHomeViewCell"];
    
    self.mTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadNetWork];
    }];
    
    [self.mTableView.mj_header beginRefreshing];
}

//MARK: -TableViewDelegate or dataScroe
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ShopHomeViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShopHomeViewCell"];
    if (!cell) {
        NSLog(@"创建cell");
    }
    
    [cell setEnumtype:MyEnumValueA];
    
    cell.itemBlock = ^(NSInteger idex, NSIndexPath *indexpath) {
        ShopSeckillDetailsViewController *seckill = [[ShopSeckillDetailsViewController alloc]init];
        seckill.seckillType = ShopSeckillDetailsTypeOrder;
        [self.navigationController pushViewController:seckill animated:YES];
        NSLog(@"%ld===%ld",idex,indexpath.section);
    };
    
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
    return 234*3+40;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // 取消Cell的选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


//MARK:-
- (IBAction)btnClick:(UIButton *)sender {
    KPreventRepeatClickTime(1)
    if (sender.tag == 10008) {
        ShopSeckillDetailsViewController *seckill = [[ShopSeckillDetailsViewController alloc]init];
        seckill.seckillType = ShopSeckillDetailsTypeKill;
        [self.navigationController pushViewController:seckill animated:YES];
    }else if (sender.tag == 10009){
        
    }else{
        
    }
}


////MARK:-scrollView
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    CGFloat offY = scrollView.contentOffset.y;
//    if (offY >= (bannerH-kStatusBarAndNavigationBarH) ) {
//        [self defnavalpha];
//    }else{
//        [self setnavalpha];
//    }
//}


////MARK:-setnavalpha
//-(void)setnavalpha{
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBar.shadowImage = [UIImage new];
//}
//
//
//-(void)defnavalpha {
//    self.navigationController.navigationBar.translucent = YES; [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav"] forBarMetrics:UIBarMetricsDefault];
//}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
