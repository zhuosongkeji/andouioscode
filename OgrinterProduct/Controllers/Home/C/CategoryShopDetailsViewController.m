//
//  CategoryShopDetailsViewController.m
//  OgrinterProduct
//
//  Created by wongshine on 2019/12/19.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "CategoryShopDetailsViewController.h"
#import "ShopSeckillDetailsViewController.h"
#import "SearchResrultViewController.h"
#import "ShopHomeViewCell.h"
#import "MenuScreeningView.h"


@interface CategoryShopDetailsViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) MenuScreeningView *menuScreeningView;

@property (nonatomic,strong)UIView *searchField;

@property (nonatomic,strong)UIButton *searchBtn;

@property (weak, nonatomic) IBOutlet UITableView *mTableView;

@end

@implementation CategoryShopDetailsViewController

//MARK:-
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
        [_searchBtn addTarget:self action:@selector(SearchAction) forControlEvents:UIControlEventTouchUpInside];
        [_searchField addSubview:_searchBtn];
    }
    
    
    return _searchField;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.titleView = self.searchField;
    [self setup];
    // Do any additional setup after loading the view from its nib.
}


-(void)setup{
    
    _menuScreeningView = [[MenuScreeningView alloc]initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, MenuHeight)];
    _menuScreeningView.backgroundColor = KSRGBA(255, 255, 255, 1);
    [self.view addSubview:_menuScreeningView];
    
    self.mTableView.tableFooterView = [UILabel new];
    
    [self.mTableView registerNib:[UINib nibWithNibName:@"ShopHomeViewCell" bundle:nil] forCellReuseIdentifier:@"ShopHomeViewCell"];
}


//MARK: -TableViewDelegate or dataScroe
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
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


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 234*3+40;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // 取消Cell的选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


-(void)SearchAction {
    SearchResrultViewController *result = [[SearchResrultViewController alloc]init];
    result.type = SearchCollectionViewtypeOne;
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
