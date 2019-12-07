//
//  ShopingShopViewController.m
//  OgrinterProduct
//
//  Created by wongshine on 2019/12/6.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ShopingShopViewController.h"
#import "SearchResrultViewController.h"
#import "ShopHomeViewCell.h"
#import "MDBannerModel.h"

@interface ShopingShopViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *leftTbleView;

@property (weak, nonatomic) IBOutlet UITableView *rigthTableView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lefttoTop;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *righttoTop;

@property(nonatomic,strong)NSArray *leftArr;

@property(nonatomic,strong)NSArray *rightArr;

@property (nonatomic,strong)UIView *searchField;

@property (nonatomic,strong)UIButton *searchBtn;

@end

@implementation ShopingShopViewController

//MARK:-searchField
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
    
    self.leftArr = @[@"玩具",@"娱乐",@"商品",@"电影",@"其他"];
    
    self.leftTbleView.tableFooterView = [UILabel new];
    self.rigthTableView.tableFooterView = [UILabel new];
    
    [self.rigthTableView registerNib:[UINib nibWithNibName:@"ShopHomeViewCell" bundle:nil] forCellReuseIdentifier:@"ShopHomeViewCell"];
    
    self.navigationItem.titleView = self.searchField;
    
    // Do any additional setup after loading the view from its nib.
}


//MARK:- table
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView == self.rigthTableView) {
        return [self.leftArr count];
    }
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.leftTbleView)
        return self.leftArr.count;
    else if (tableView == self.rigthTableView)
        return 1;
    else
        return 0;
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.leftTbleView) {
        static NSString *idfier = @"idfier";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idfier];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idfier];
        }
        cell.textLabel.text = [self.leftArr objectAtIndex:indexPath.row];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.textColor = [UIColor lightGrayColor];
        
        return cell;
        
    }else if (tableView == self.rigthTableView){
        ShopHomeViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShopHomeViewCell"];
        if (!cell) {
            NSLog(@"创建ShopHomeViewCell");
        }
        
        [cell setEnumtype:MyEnumValueB];
        cell.itemBlock = ^(NSInteger idex, NSIndexPath *indexpath) {
            
        };
        
        return cell;
        
    }else {
        
        return nil;
    }
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.leftTbleView) {
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
        [self.rigthTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:indexPath.row] animated:NO scrollPosition:UITableViewScrollPositionBottom];
    }
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _leftTbleView) {
        return 50;
    }
    return KSCREEN_HEIGHT-2;
}


//MARK:- searchaction
-(void)searchaction {
    SearchResrultViewController *result = [[SearchResrultViewController alloc]init];
    result.type = SearchCollectionViewtypeTwo;
    [self.navigationController pushViewController:result animated:YES];
}


//-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    if (tableView == self.rigthTableView) {
//        return [self.leftArr objectAtIndex:section];
//    }
//    return nil;
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
