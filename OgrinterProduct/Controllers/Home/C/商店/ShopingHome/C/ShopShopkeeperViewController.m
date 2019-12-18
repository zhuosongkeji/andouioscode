//
//  ShopShopkeeperViewController.m
//  OgrinterProduct
//
//  Created by wongshine on 2019/12/16.
//  Copyright © 2019 RXF. All rights reserved.
//


#import "ShopShopkeeperViewController.h"
#import "ShopHomeViewCell.h"
#import "MenuScreeningView.h"
#import "SearchResrultViewController.h"


@interface ShopShopkeeperViewController ()<UITableViewDelegate,UITableViewDataSource>


@property (weak, nonatomic) IBOutlet UITableView *mTableView;

@property (nonatomic,strong) MenuScreeningView *menuScreeningView;
@property (weak, nonatomic) IBOutlet UIImageView *topimgView;


@property (nonatomic,strong)UIView *searchField;

@property (nonatomic,strong)UIButton *searchBtn;


@end


@implementation ShopShopkeeperViewController


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
    
    [self setup];
    // Do any additional setup after loading the view from its nib.
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
    
    cell.itemBlock = ^(NSInteger idex, NSIndexPath * _Nullable indexpath) {
        NSLog(@"%ld---==---%ld",idex,indexpath.row);
    };
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return KSCREEN_HEIGHT - 36- kStatusBarAndNavigationBarH;
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
