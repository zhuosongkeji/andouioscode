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
#import "FKHRequestManager.h"

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

@property (weak, nonatomic) IBOutlet UIButton *allSelectedBtn;


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
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"uid"] = @"uid";
    param[@"token"] = @"token";

    [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:@"http://andou.zhuosongkj.com/api/cart/index" params:param complement:^(ServerResponseInfo * _Nullable serverInfo) {
        NSLog(@"%@",serverInfo.response);
    }];
   
}

- (void)setupTable
{
    [self.tableView registerNib:[UINib nibWithNibName:@"ZBNShoppingCartCell" bundle:nil] forCellReuseIdentifier:ZBNShopingCartCellID];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}







- (IBAction)allSelectedBtnClick:(UIButton *)sender {
    
    
    
    
}




#pragma mark - Table view data source

/*! 设置有多少数据 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.goodsArray.count;
}
/*! 设置没个Cell的数据 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZBNShoppingCartCell *cell = [tableView dequeueReusableCellWithIdentifier:ZBNShopingCartCellID];
    cell.delegate = self;
    cell.shoppingCartModel = self.goodsArray[indexPath.row];
    return cell;
}

/*! 设置行高 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 155;
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
    // 计算总价
    int totalPrice = self.totalPriceLabel.text.intValue + shoppingCartCell.shoppingCartModel.money.intValue;
    // 设置总价
    self.totalPriceLabel.text = [NSString stringWithFormat:@"%d",totalPrice];
    // 设置按钮可以点击
    self.buyButton.enabled = YES;
    // 如果商品已经在购物车中添加过,
    if ([self.goodsCar containsObject:shoppingCartCell.shoppingCartModel]) return;
    // 添加到购物车
    [self.goodsCar addObject:shoppingCartCell.shoppingCartModel];
    
}



@end
