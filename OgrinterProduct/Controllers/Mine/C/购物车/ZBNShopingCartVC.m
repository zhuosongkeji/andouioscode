//
//  ZBNShopingCartVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/10.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ZBNShopingCartVC.h"
#import "ZBNShoppingCartCell.h"
#import "ZBNShoppingCartModel.h"


@interface ZBNShopingCartVC () <UITableViewDelegate, UITableViewDataSource, ZBNShoppingCartCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
/*! 总数量的label */
@property (weak, nonatomic) IBOutlet UILabel *totalPriceLabel;
/*! 购买的Button */
@property (weak, nonatomic) IBOutlet UIButton *buyButton;
/** 购物车对象（存放需要购买的商品） */
@property (nonatomic, strong) NSMutableArray *goodsCar;
/** 商品数据 */
@property (nonatomic, strong) NSMutableArray *goodsArray;
@end

@implementation ZBNShopingCartVC

static NSString * const ZBNShopingCartCellID = @"shoppingCart";

- (NSMutableArray *)goodsCar
{
    if (!_goodsCar) {
        _goodsCar = [NSMutableArray array];
    }
    return _goodsCar;
}

- (NSArray *)goodsArray
{
    if (!_goodsArray) {
        self.goodsArray = [ZBNShoppingCartModel mj_objectArrayWithFilename:@"wine.plist"];
    }
    return _goodsArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的购物车";
    [self setupTable];
   
}

- (void)setupTable
{
    [self.tableView registerNib:[UINib nibWithNibName:@"ZBNShoppingCartCell" bundle:nil] forCellReuseIdentifier:ZBNShopingCartCellID];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.goodsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZBNShoppingCartCell *cell = [tableView dequeueReusableCellWithIdentifier:ZBNShopingCartCellID];
    cell.delegate = self;
    cell.shoppingCartModel = self.goodsArray[indexPath.row];
    cell.deleteBtnClick = ^(ZBNShoppingCartModel * _Nonnull catModel) {
        [self.goodsArray removeObject:catModel];
        [self.tableView reloadData];
    };
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 180;
}


- (void)shoppingCartCellDidClickReduceButton:(ZBNShoppingCartCell *)shoppingCartCell
{
    //计算总价
    int totalPrice = self.totalPriceLabel.text.intValue - shoppingCartCell.shoppingCartModel.money.intValue;
    //设置总价
    self.totalPriceLabel.text = [NSString stringWithFormat:@"%d",totalPrice];
    self.buyButton.enabled = totalPrice > 0;
    // 将商品从购物车中移除
    if (shoppingCartCell.shoppingCartModel.count == 0) {
        [self.goodsCar removeObject:shoppingCartCell.shoppingCartModel];
    }
}

- (void)shoppingCartCellDidClickPlusButton:(ZBNShoppingCartCell *)shoppingCartCell
{
    int totalPrice = self.totalPriceLabel.text.intValue + shoppingCartCell.shoppingCartModel.money.intValue;
    
    self.totalPriceLabel.text = [NSString stringWithFormat:@"%d",totalPrice];
    
    self.buyButton.enabled = YES;
    
    if ([self.goodsCar containsObject:shoppingCartCell.shoppingCartModel]) return;
    
    [self.goodsCar addObject:shoppingCartCell.shoppingCartModel];
    
}


@end
