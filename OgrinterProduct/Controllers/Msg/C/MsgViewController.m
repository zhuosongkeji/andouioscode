//
//  MsgViewController.m
//  OgrinterProduct
//
//  Created by wongshine on 2019/11/28.
//  Copyright © 2019 RXF. All rights reserved.
//


#define merchant_merchants @"merchant/merchants"//获取商家列表

#define merchants_two @"merchant/merchants_two"//获取商家列表


#import "MsgViewController.h"
#import "MenuScreeningView.h"
#import "MsgViewCell.h"
#import "MsgModel.h"


@interface MsgViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSInteger t;
    NSInteger page;
    BOOL isselect;
}

@property (nonatomic,strong) MenuScreeningView *menuScreeningView;

@property (weak, nonatomic) IBOutlet UITableView *mTableView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toTop;

@property (nonatomic,strong)NSMutableArray *shoArr;

@property (nonatomic,strong)NSMutableArray *otherArr;

@property (nonatomic,strong)NSMutableArray *categoryArr;

@property (nonatomic,strong)NSMutableDictionary *postDict;


@end

@implementation MsgViewController


-(NSMutableDictionary *)postDict {
    if (!_postDict) {
        _postDict = [NSMutableDictionary dictionaryWithObject:[NSString stringWithFormat:@"%ld",page] forKey:@"page"];
    }
    return _postDict;
}


-(NSMutableArray *)shoArr {
    
    if (!_shoArr) {
        _shoArr = [NSMutableArray array];
    }
    return _shoArr;
}


-(NSMutableArray *)categoryArr {
    
    if (!_categoryArr) {
        _categoryArr = [NSMutableArray array];
    }
    return _categoryArr;
}


-(NSMutableArray *)otherArr {
    
    if (!_otherArr) {
        _otherArr = [NSMutableArray array];
    }
    return _otherArr;
}


//MARK:- viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    
    // Do any additional setup after loading the view from its nib.
}


-(void)setup{
    
    self.toTop.constant = kStatusBarAndNavigationBarH+MenuHeight;t = 0;page = 1;
    
    [self createMenuScreeningView];
    
    [self.mTableView registerNib:[UINib nibWithNibName:@"MsgViewCell" bundle:nil] forCellReuseIdentifier:@"MsgViewCell"];
    self.mTableView.tableFooterView = [UILabel new];
    
    self.mTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        page = 1;
        if (!isselect)
            [self.postDict setObject:[NSString stringWithFormat:@"%ld",page] forKey:@"page"];
        else
            [self.postDict setObject:[NSString stringWithFormat:@"%ld",page] forKey:@"page"];
        
        [self loadshoplistWithParams:self.postDict];
        
    }];
    
    self.mTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        page += 1;
        if (!isselect)
             [self.postDict setObject:[NSString stringWithFormat:@"%ld",page] forKey:@"page"];
        else
            [self.postDict setObject:[NSString stringWithFormat:@"%ld",page] forKey:@"page"];
        
        [self loadshoplistWithParams:self.postDict];
    }];
    
    [self.mTableView.mj_footer setHidden:YES];
    [self.mTableView.mj_header beginRefreshing];
    
}


-(void)createMenuScreeningView {
    
    _menuScreeningView = [[MenuScreeningView alloc]initWithFrame:CGRectMake(0, kStatusBarAndNavigationBarH, KSCREEN_WIDTH, MenuHeight) title:@[@"商家分类",@"地区选择",@"排序方式"] withtype:MenuScreeningViewTypeOne];
    _menuScreeningView.backgroundColor = KSRGBA(255, 255, 255, 1);
    
    __weak typeof(&*self)weakSelf = self;
    _menuScreeningView.selcctblock = ^(NSString *str) {
        NSArray *array = [str componentsSeparatedByString:@"-"];
        NSDictionary *dict = nil;
        
        isselect = YES;
        page = 1;
        
        if ([array count] == 2) {
            NSString *length = array.lastObject;
            
            if (length.length == 0) {
                
                dict = @{@"merchant_type_id":array[0]};
                
            }else{
                
                dict = @{@"type":@""};
            }
            
        }else{
            
            dict = @{@"province_id":array[0],@"city_id":array[1],@"area_id":array[2]};
        }
        
        [weakSelf setpostDictwithdict:dict];
    };
    
    [self.view addSubview:_menuScreeningView];
}


-(void)setpostDictwithdict:(NSDictionary *)dict{
    
    if (self.postDict)
        [self.postDict removeAllObjects];
    
    [self.postDict setDictionary:dict];
    [self.postDict setObject:[NSString stringWithFormat:@"%ld",page] forKey:@"page"];
    
    [self.mTableView.mj_header beginRefreshing];
}


-(void)loadshoplistWithParams:(NSDictionary *)dict{
    
    NSString *urlStr = nil;
    if (t == 0) {
        urlStr = [NSString stringWithFormat:@"%@%@",API_BASE_URL_STRING,merchant_merchants];
    }else{
        urlStr = [NSString stringWithFormat:@"%@%@",API_BASE_URL_STRING,merchants_two];
    }
    
    [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:urlStr params:dict complement:^(ServerResponseInfo * _Nullable serverInfo) {
        
        if ([serverInfo.response[@"code"] integerValue] == 200) {
            NSDictionary *dict1 = [serverInfo.response objectForKey:@"data"];
            
            NSArray *merchants = dict1[@"merchants"];
            
            if (t == 0) {
                
                [self creatPlistFileWithArr:dict1[@"merchant_type"] Name:@"merchanttype"];
                
                [self creatPlistFileWithArr:dict1[@"districts"] Name:@"districts"];
                t = 1;
                
            }else {
                
            }
            
            NSMutableArray *array = [NSMutableArray array];
            for (int i = 0; i < [merchants count]; i ++) {
                MsgModel *model = [[MsgModel alloc]initWithDict:merchants[i]];
                [array addObject:model];
            }
            
            if ([self.mTableView.mj_header isRefreshing]) {
                [self.shoArr removeAllObjects];
                [self.shoArr addObjectsFromArray:array];
                [self.mTableView.mj_footer resetNoMoreData];
            }else if([self.mTableView.mj_footer isRefreshing]){
                if ([array count] == 0) {
                    [self.mTableView.mj_footer endRefreshing];
                    [self.mTableView.mj_footer endRefreshingWithNoMoreData];
                }else{
                    [self.shoArr addObjectsFromArray:array];
                    [self.mTableView.mj_footer endRefreshing];
                }
            }else{
                [self.shoArr removeAllObjects];
                [self.shoArr addObjectsFromArray:array];
            }
            
            [self.mTableView.mj_header endRefreshing];
            [self.mTableView reloadData];
            
        }else{
            [HUDManager showTextHud:loadError];
        }
    }];
    
}



//MARK:-tableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    self.mTableView.mj_footer.hidden = [self.shoArr count]<10;
    return [self.shoArr count];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MsgViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MsgViewCell"];
    if (!cell) {
        NSLog(@"创建新的cell");
    }
    
    cell.selectBlock = ^(UIButton *button) {
        
    };

    if ([self.shoArr count]>0) {
        cell.listmodel = self.shoArr[indexPath.row];
        
    }
    
    return cell;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 98;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // 取消Cell的选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
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
