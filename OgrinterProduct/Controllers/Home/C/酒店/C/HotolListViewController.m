//
//  HotolListViewController.m
//  OgrinterProduct
//
//  Created by wongshine on 2019/12/7.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "HotolListViewController.h"
#import "SearchResrultViewController.h"
#import "MenuScreeningView.h"
#import "MsgViewCell.h"
#import "MsgModel.h"


@interface HotolListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UIView *searchField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toTop;

@property (nonatomic,strong)UIButton *searchBtn;

@property (weak, nonatomic) IBOutlet UITableView *mTableView;

@property (nonatomic,strong) MenuScreeningView *menuScreeningView;


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


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.toTop.constant = MenuHeight;
    [self setup];
    // Do any additional setup after loading the view from its nib.
}


//MARK:- loadsubViews
-(void)setup {
    _menuScreeningView = [[MenuScreeningView alloc]initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, MenuHeight)];
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
    return 12;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MsgViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MsgViewCell"];
    if (!cell) {
        NSLog(@"chuangjian");
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // 取消Cell的选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
