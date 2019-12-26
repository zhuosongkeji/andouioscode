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


@interface ShopingHomeViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSArray *sectionArr;
}

@property (nonatomic,strong) MDShockBannerView *bannerView;
@property (weak, nonatomic) IBOutlet UITableView *mTableView;
@property (weak, nonatomic) IBOutlet UIView *topBannerView;
@property (nonatomic,strong)NSMutableArray *dataArr;
@property (weak, nonatomic) IBOutlet UIView *categoryBjView;

@property (nonatomic,strong)NSMutableArray *btns;
@property (nonatomic,strong)NSMutableArray *SDarray;


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
        if ([self.dataArr count] > 0) {
            MDBannerModel *model = [self.dataArr objectAtIndex:0];
            NSArray *Barray = [model.dataDic objectForKey:@"banner"];
            NSMutableArray *listArr = [NSMutableArray array];
            for (int i = 0; i < [Barray count]; i ++) {
                MdBannerListModel *list = Barray[i];
                list.bgImg = @"http://md-juhe.oss-cn-hangzhou.aliyuncs.com/upload/ad/20180417/9bc42ce40490c854eab2e9969ac8e328caab0a17.png";
                [listArr addObject:list];
            }
            _bannerView.banners = listArr;
//            NSArray *Carray = [model.dataDic objectForKey:@"category"];
//            for (int i = 0; i < [Carray count]; i ++ ) {
//                MdBannerListModel *list = Carray[i];
//                UIButton *btn = _btns[i];
//                [btn sd_setImageWithURL:[NSURL URLWithString:list.img] forState:0];
//                [btn setTitle:list.name forState:0];
//            }
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
        }else {
            [HUDManager showTextHud:loadError];
        }
        
        [self.mTableView reloadData];
        [self.mTableView.mj_header endRefreshing];
    }];
}


-(void)setup{
    
    self.mTableView.tableFooterView = [UILabel new];
    
    [self.mTableView registerNib:[UINib nibWithNibName:@"ShopHomeViewCell" bundle:nil] forCellReuseIdentifier:@"ShopHomeViewCell"];
    
    _btns = [NSMutableArray array];
    for (UIButton *b in self.categoryBjView.subviews) {
        if ([b isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)b;
            [_btns addObject:btn];
        }
    }
    
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
    
    if ([self.dataArr count] > 0) {
        MDBannerModel *mode = self.dataArr[0];
        _SDarray = [NSMutableArray arrayWithObjects:[mode.dataDic objectForKey:@"recommend_goods"],[mode.dataDic objectForKey:@"bargain_goods"], nil];
        cell.modellist = _SDarray[indexPath.section];
    }
    
    cell.itemBlock = ^(NSInteger idex, NSIndexPath *indexpath) {
        
        MdBannerListModel *model = [_SDarray[indexpath.section] objectAtIndex:idex];
        
        ShopSeckillDetailsViewController *seckill = [[ShopSeckillDetailsViewController alloc]init];
        seckill.seckillType = ShopSeckillDetailsTypeOrder;
        seckill.cpid = model.uid;
        
        [self.navigationController pushViewController:seckill animated:YES];
    };
    
    return cell;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    ShopHomeSectionView *v = [[NSBundle mainBundle]loadNibNamed:@"ShopHomeSectionView" owner:self options:nil].lastObject;
    [v setTag:section];
    v.backgroundColor = KSRGBA(255, 255, 255, 1);
    v.btnclickBlcok = ^(UIButton *btn) {
        UIView *view = (UIButton *)btn.superview;
//        if (view.tag == 0) {
//            NSLog(@"你点击了%ld",section);
//        }else if (view.tag == 1){
//            NSLog(@"你点击了%ld",section);
//        }else{}
    };
    
    return v;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 64;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 234*2+30;
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
