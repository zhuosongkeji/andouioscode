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

@property (nonatomic,strong)UIButton *searchBtn;

@end

@implementation ShopingShopViewController


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.leftArr = @[@"玩具",@"娱乐",@"商品",@"电影",@"其他"];
    
    self.leftTbleView.tableFooterView = [UILabel new];
    self.rigthTableView.tableFooterView = [UILabel new];
    
    [self.rigthTableView registerNib:[UINib nibWithNibName:@"ShopHomeViewCell" bundle:nil] forCellReuseIdentifier:@"ShopHomeViewCell"];
    
    // Do any additional setup after loading the view from its nib.
}


#pragma mark - tableView 数据源代理方法 -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == self.leftTbleView) return [self.leftArr count];
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if (tableView == self.leftTbleView) return 1;
    return [self.leftArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 左边的 view
    if (tableView == self.leftTbleView) {
        
        static NSString *idfier = @"idfier";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idfier];
        
        if (!cell) {
            
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.text = self.leftArr[indexPath.row];
        
        return cell;
        // 右边的 view
    } else {
        
       ShopHomeViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShopHomeViewCell"];
        
        if (!cell) {
            NSLog(@"xhuangjian");
        }
        
        [cell setEnumtype:MyEnumValueB];
        
        return cell;
        
    }
    
    return nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    if (tableView == self.rigthTableView) return [NSString stringWithFormat:@"第 %ld 组", section];
    
    return nil;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.leftTbleView) {
        return 50;
    }
    return 1300;
}


//MARK: - 一个方法就能搞定 右边滑动时跟左边的联动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    // 如果是 左侧的 tableView 直接return
    if (scrollView == self.leftTbleView) return;
    
    // 取出显示在 视图 且最靠上 的 cell 的 indexPath
    NSIndexPath *topHeaderViewIndexpath = [[self.rigthTableView indexPathsForVisibleRows] firstObject];
    
    // 左侧 talbelView 移动的 indexPath
    NSIndexPath *moveToIndexpath = [NSIndexPath indexPathForRow:topHeaderViewIndexpath.section inSection:0];
    
    // 移动 左侧 tableView 到 指定 indexPath 居中显示
    [self.leftTbleView selectRowAtIndexPath:moveToIndexpath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
    
}

//MARK: - 点击 cell 的代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 选中 左侧 的 tableView
    if (tableView == self.leftTbleView) {
        
        NSIndexPath *moveToIndexPath = [NSIndexPath indexPathForRow:0 inSection:indexPath.row];
        
        // 将右侧 tableView 移动到指定位置
        [self.rigthTableView selectRowAtIndexPath:moveToIndexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
        
        // 取消选中效果
        [self.rigthTableView deselectRowAtIndexPath:moveToIndexPath animated:YES];
    }
}


////MARK:- searchaction
//-(void)searchaction {
//    SearchResrultViewController *result = [[SearchResrultViewController alloc]init];
//    result.type = SearchCollectionViewtypeTwo;
//    [self.navigationController pushViewController:result animated:YES];
//}


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
