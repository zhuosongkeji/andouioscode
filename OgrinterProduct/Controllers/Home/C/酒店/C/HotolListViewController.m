//
//  HotolListViewController.m
//  OgrinterProduct
//
//  Created by wongshine on 2019/12/7.
//  Copyright © 2019 RXF. All rights reserved.
//

#define hotel_condition @"hotel/condition"//获取星级配置

#define hotel_hotellist @"hotel/hotellist"//酒店列表

#import "HotolListViewController.h"
#import "SearchResrultViewController.h"
#import "HotelDetlisViewController.h"
#import "MenuScreeningView.h"
#import "MsgViewCell.h"
#import "MsgModel.h"


@interface HotolListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UIView *searchField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toTop;

@property (nonatomic,strong)UIButton *searchBtn;

@property (weak, nonatomic) IBOutlet UITableView *mTableView;

@property (nonatomic,strong) MenuScreeningView *menuScreeningView;

@property (nonatomic,strong)NSMutableArray *listArr;


@end


@implementation HotolListViewController

//MARK:- searchField
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


-(NSMutableArray *)listArr {
    if (!_listArr) {
        _listArr = [[NSMutableArray alloc]init];
    }
    return _listArr;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.toTop.constant = MenuHeight+kStatusBarAndNavigationBarH;
    
    [self setup];
    
    [self loadhotelcondition];
    
    [self loadhotelhotellistWith:nil];
    
    // Do any additional setup after loading the view from its nib.
}


-(void)loadhotelhotellistWith:(NSDictionary *)dict {
    
    NSString *url = [NSString stringWithFormat:@"%@%@",API_BASE_URL_STRING,hotel_hotellist];
    
    [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:url params:dict complement:^(ServerResponseInfo * _Nullable serverInfo) {
        if ([serverInfo.response[@"code"] integerValue] == 200) {
            
            if ([_listArr count])
                [_listArr removeAllObjects];
            
            NSArray *array = serverInfo.response[@"data"] ;
            for (int i = 0; i < [array  count]; i ++ ) {
                MsgModel *model = [[MsgModel alloc]initWithDict:array[i]];
                [self.listArr addObject:model];
            }
            
        }else {
            [HUDManager showTextHud:loadError];
        }
        [self.mTableView reloadData];
        
    }];
}

//MARK: - 获取酒店星级配置；
-(void)loadhotelcondition{
    
    NSString *url = [NSString stringWithFormat:@"%@%@",API_BASE_URL_STRING,hotel_condition];
    
    [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:url params:nil complement:^(ServerResponseInfo * _Nullable serverInfo) {
        if ([serverInfo.response[@"code"] integerValue] == 200) {
            
            NSArray *starArr = [serverInfo.response[@"data"] objectForKey:@"star"];
            
            NSArray *rangeArr = [serverInfo.response[@"data"] objectForKey:@"price_range"];
            
            [self creatPlistFileWithArr:@[@{@"id":@(0),@"name":@"星级",@"star":starArr},@{@"id":@(1),@"name":@"价格",@"star":rangeArr}] Name:@"StarAndPrice"];
            
        }else {
            [HUDManager showTextHud:loadError];
        }
        
    }];
}


//MARK:- loadsubViews
-(void)setup {
    
    _menuScreeningView = [[MenuScreeningView alloc]initWithFrame:CGRectMake(0, kStatusBarAndNavigationBarH, KSCREEN_WIDTH, MenuHeight) title:@[@"区域",@"星级",@"排行"] withtype:MenuScreeningViewTypeTwo];
    
    _menuScreeningView.selcctblock = ^(NSString *str) {
        NSLog(@"%@",str);
    };
    
    _menuScreeningView.backgroundColor = KSRGBA(255, 255, 255, 1);
    [self.view addSubview:_menuScreeningView];
    
    self.mTableView.tableFooterView = [UILabel new];
    self.navigationItem.titleView = self.searchField;
    
    [self.mTableView registerNib:[UINib nibWithNibName:@"MsgViewCell" bundle:nil] forCellReuseIdentifier:@"MsgViewCell"];
}


//MARK:- tableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MsgViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MsgViewCell"];
    if (!cell) {
        NSLog(@"chuangjian");
    }
    
    if ([self.listArr count] > 0) {
        
        MsgModel *model = self.listArr[indexPath.row];
        cell.listmodel = model;
    }
    
    
    cell.selectBlock = ^(UIButton *button) {
        
    };
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MsgModel *model = _listArr[indexPath.row];
    // 取消Cell的选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    HotelDetlisViewController *holel = [[HotelDetlisViewController alloc]init];
    holel.navigationItem.title = model.name;
    holel.jid = model.uid;
    
    [self.navigationController pushViewController:holel animated:YES];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 105;
}


//MARK:-SearchResrult
-(void)searchaction {
    
    SearchResrultViewController *resrult = [[SearchResrultViewController alloc]init];
    resrult.type = SearchTableViewList;
    [self.navigationController pushViewController:resrult animated:YES];
}



//MARK:-
#pragma mark - 创建plist文件
-(void)creatPlistFileWithArr:(NSArray *)array Name:(NSString *)name{
    //将字典保存到document文件->获取appdocument路径
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    //要创建的plist文件名 -> 路径
    NSString *filePath = [docPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",name]];
    //将数组写入文件
    [array writeToFile:filePath atomically:YES];
    NSLog(@"filePath = %@",filePath);
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
