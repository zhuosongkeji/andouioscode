//
//  OnlineOrderViewController.m
//  OgrinterProduct
//
//  Created by wongshine on 2019/12/18.
//  Copyright © 2019 RXF. All rights reserved.
//

#define gourmet_list @"gourmet/list"

#import "OnlineOrderViewController.h"
#import "MenuScreeningView.h"
#import "OnlineOrderModel.h"
#import "HomeTableViewCell.h"
#import "HotelOnlineViewController.h"


@interface OnlineOrderViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger page;
}

@property (weak, nonatomic) IBOutlet UITableView *mTableView;

@property (weak, nonatomic) IBOutlet UIView *bjTopView;

@property (weak, nonatomic) IBOutlet UIView *TopbjView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toTop;

@property(nonatomic,strong)NSMutableArray *mData;


@property (nonatomic,strong) MenuScreeningView *menuScreeningView;

@end

@implementation OnlineOrderViewController


-(NSMutableArray *)mData {
    if (!_mData) {
        _mData = [NSMutableArray array];
    }
    return _mData;
}


-(MenuScreeningView *)menuScreeningView{
    if (!_menuScreeningView) {
        _menuScreeningView = [[MenuScreeningView alloc]initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, MenuHeight) title:@[@"1",@"2",@"3"] withtype:MenuScreeningViewTypeOne];
        _menuScreeningView.backgroundColor = KSRGBA(255, 255, 255, 1);
    }
    return _menuScreeningView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    page = 0;
    
    [self setup];
    [self loadNetWork];
    // Do any additional setup after loading the view from its nib.
}


-(void)setup{
    
    self.toTop.constant = kStatusBarAndNavigationBarH;
    
    self.mTableView.tableFooterView = [UILabel new];
    [self.mTableView registerNib:[UINib nibWithNibName:@"HomeTableViewCell" bundle:nil] forCellReuseIdentifier:@"HomeTableViewCell"];
    self.mTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        page = 0;
        [self loadNetWork];
    }];
    self.mTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        page += 1;
        [self loadNetWork];
    }];
    [self.mTableView.mj_footer setHidden:YES];
    
    [self.mTableView.mj_header beginRefreshing];
}


-(void)loadNetWork{
    
    [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:[NSString stringWithFormat:@"%@%@",API_BASE_URL_STRING,gourmet_list] params:@{@"page":@(page)} complement:^(ServerResponseInfo * _Nullable serverInfo) {
        if ([serverInfo.response[@"code"] integerValue] == 200) {
            
            NSMutableArray *array = [NSMutableArray array];
            NSArray *arr = serverInfo.response[@"data"];
            for (int i = 0; i < [arr count]; i ++) {
                NSDictionary *dic = arr[i];
                OnlineOrderModel *model = [[OnlineOrderModel alloc]initWithDict:dic];
                [array addObject:model];
            }
            
            if ([self.mTableView.mj_header isRefreshing]) {
                
                [_mData removeAllObjects];
                [self.mData addObjectsFromArray:array];
                [self.mTableView.mj_footer resetNoMoreData];
            }else if ([self.mTableView.mj_footer isRefreshing]){
                if ([array count] == 0){
                    [self.mTableView.mj_footer endRefreshing];
                    [self.mTableView.mj_footer endRefreshingWithNoMoreData];
                }else{
                    
                    [self.mData addObjectsFromArray:array];
                    [self.mTableView.mj_footer endRefreshing];
                }
            }else{}

        }else {
            [HUDManager showTextHud:loadError];
        }
        [self.mTableView reloadData];
        [self.mTableView.mj_header endRefreshing];
    }];
}


//MARK:- tableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section != 3) {
        return 0;
    }else {
        self.mTableView.mj_footer.hidden = [self.mData count]<10;
        return [self.mData count];
    }
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HomeTableViewCell *cell = [HomeTableViewCell tempTableViewCellWith:tableView indexPath:indexPath];
    [cell configTempCellWith:indexPath];
    
    if ([_mData count]) {
        cell.tag = indexPath.row;
        cell.modelist = self.mData[indexPath.row];
    }
    
    cell.mblock = ^(NSInteger idx) {
        OnlineOrderModel *model = self.mData[idx];
        
        HotelOnlineViewController *hotel = [[HotelOnlineViewController alloc]init];
        hotel.sid = model.oid;
        hotel.sname = model.name;
        [self.navigationController pushViewController:hotel animated:YES];
    };
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // 取消Cell的选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSLog(@"%ld%ld",indexPath.section,indexPath.row);
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section != 3) {
        return 0;
    }else{
        return 222;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 3) {
        UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 37)];
        [v addSubview:self.menuScreeningView];
        return v;
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 3) {
        return 37;
    }
    return 0;
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
