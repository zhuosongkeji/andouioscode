//
//  ShopShopkeeperViewController.m
//  OgrinterProduct
//
//  Created by wongshine on 2019/12/16.
//  Copyright © 2019 RXF. All rights reserved.
//

#define merchant_goods @"merchant/merchant_goods"


#import "ShopShopkeeperViewController.h"
#import "ShopHomeViewCell.h"
#import "MenuScreeningView.h"
#import "SearchResrultViewController.h"
#import "ShoperModel.h"


@interface ShopShopkeeperViewController ()<UITableViewDelegate,UITableViewDataSource>


@property (weak, nonatomic) IBOutlet UITableView *mTableView;

@property (nonatomic,strong) MenuScreeningView *menuScreeningView;
@property (weak, nonatomic) IBOutlet UIImageView *topimgView;

@property (weak, nonatomic) IBOutlet UIImageView *login_imgView;

@property (weak, nonatomic) IBOutlet UILabel *shoperNameLabel;

@property (nonatomic,strong)NSMutableArray *dataArr;


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
    
    [self setup];
    
    [self loadNetWork];
    // Do any additional setup after loading the view from its nib.
}


//MARK:-
-(void)loadNetWork {
    
    NSString *url = [NSString stringWithFormat:@"%@%@",API_BASE_URL_STRING,merchant_goods];
    NSDictionary *dict = @{@"id":self.shoperId,@"uid":self.u_id};
    
    [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:url params:dict complement:^(ServerResponseInfo * _Nullable serverInfo) {
        if ([serverInfo.response[@"code"] integerValue] == 200) {
            NSDictionary *dict1 = serverInfo.response[@"data"];
            ShoperModel *model = [[ShoperModel alloc]initWithDict:dict1];
            
            [self.dataArr addObject:model];
            
            [self.topimgView sd_setImageWithURL:[NSURL URLWithString:model.bannerImg] completed:nil];
            [self.login_imgView sd_setImageWithURL:[NSURL URLWithString:model.logoimg] completed:nil];
            self.shoperNameLabel.text = model.name;
            
            [self.mTableView reloadData];
            
        }else {
            [HUDManager showTextHud:loadError];
        }
        
    }];
}


-(void)setup {
    
    [self.view addSubview:self.searchField];
    
    _menuScreeningView = [[MenuScreeningView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topimgView.frame)+44, KSCREEN_WIDTH, MenuHeight)];
    
    _menuScreeningView.backgroundColor = KSRGBA(255, 255, 255, 1);
    
    [self.view addSubview:_menuScreeningView];
    
    self.mTableView.tableFooterView = [UILabel new];
    
    [self.mTableView registerNib:[UINib nibWithNibName:@"ShopHomeViewCell" bundle:nil] forCellReuseIdentifier:@"ShopHomeViewCell"];
}


//MARK:- tableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ShopHomeViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShopHomeViewCell"];
    if (!cell) {
        NSLog(@"创建cell");
    }
    
    [cell setEnumtype:MyEnumValueC];
    
    if ([self.dataArr count] > 0)
        cell.listModel = self.dataArr[0];
    
    cell.itemBlock = ^(NSInteger idex, NSIndexPath * _Nullable indexpath){
        NSLog(@"%ld---==---%ld",idex,indexpath.row);
    };
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.dataArr count]) {
        ShoperModel *model = self.dataArr[0];
        if ([model.goodsArr count]%2 == 0) {
            return ([model.goodsArr count]/2)*244;
        }else
            return (([model.goodsArr count]/2)+1)*244;
    }
    return 0;
}


//MARK:- search
-(void)ssearchaction{
    SearchResrultViewController *search = [[SearchResrultViewController alloc]init];
    [search setType:SearchCollectionViewtypeOne];
    [self.navigationController pushViewController:search animated:YES];
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
