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

- (NSMutableArray *)goodsArray
{
    if (!_goodsArray) {
        _goodsArray = [NSMutableArray array];
    }
    return _goodsArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的购物车";
    [self setupTable];
    // 数据加载
    [self loadData];
   
}

- (void)setupTable
{
    [self.tableView registerNib:[UINib nibWithNibName:@"ZBNShoppingCartCell" bundle:nil] forCellReuseIdentifier:ZBNShopingCartCellID];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)loadData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSData * data1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"infoData"];
    userInfo * unmodel = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
    params[@"uid"] = unmodel.uid;
    params[@"token"] = unmodel.token;
    ADWeakSelf;
    [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:@"http://andou.zhuosongkj.com/api/order/index" params:params complement:^(ServerResponseInfo * _Nullable serverInfo) {
        weakSelf.goodsArray = [ZBNShoppingCartModel mj_objectArrayWithKeyValuesArray:serverInfo.response[@"data"]];
        [weakSelf.tableView reloadData];
    }];
}


/*! 全选按钮的点击 */
- (IBAction)allSelectedBtnClick:(UIButton *)sender {
    
    sender.selected = !sender.selected;
   
    if (sender.selected) {
        for (ZBNShoppingCartModel *model in self.goodsArray) {
               if (model.selected) {
                   continue;
               } else {
                   model.selected = YES;
               }
            NSInteger totalPrice = self.totalPriceLabel.text.intValue + model.price.intValue * model.num.integerValue;
            self.totalPriceLabel.text = [NSString stringWithFormat:@"%zd",totalPrice];
           }
        [self.tableView reloadData];
    } else {
        for (ZBNShoppingCartModel *model in self.goodsArray) {
            if (model.selected == NO) {
                continue;
            } else {
                model.selected = NO;
            }
            NSInteger totalPrice = self.totalPriceLabel.text.intValue - model.num.integerValue * model.num.integerValue;
            self.totalPriceLabel.text = [NSString stringWithFormat:@"%zd",totalPrice];
        }
        [self.tableView reloadData];
    }
    
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



#pragma mark -- cell的代理方法

/*! 当减号按钮点击的时候 */
- (void)shoppingCartCellDidClickReduceButton:(ZBNShoppingCartCell *)shoppingCartCell
{
    if (shoppingCartCell.shoppingCartModel.selected == YES) {
    //计算总价
    int totalPrice = self.totalPriceLabel.text.intValue - shoppingCartCell.shoppingCartModel.num.intValue;
    //设置总价
    self.totalPriceLabel.text = [NSString stringWithFormat:@"%d",totalPrice];
    self.buyButton.enabled = totalPrice > 0;

    }
}

/*! 当加号按钮点击的时候调用 */
- (void)shoppingCartCellDidClickPlusButton:(ZBNShoppingCartCell *)shoppingCartCell
{
    
    if (shoppingCartCell.shoppingCartModel.selected == YES) {
    // 计算总价
    int totalPrice = self.totalPriceLabel.text.intValue + shoppingCartCell.shoppingCartModel.num.intValue;
    // 设置总价
    self.totalPriceLabel.text = [NSString stringWithFormat:@"%d",totalPrice];
    // 设置按钮可以点击
    self.buyButton.enabled = YES;
    }
}
/*! 当用户点击了选取按钮的时候 */
- (void)shoppingCartCellDidClickSelectedButton:(ZBNShoppingCartCell *)shoppingCartCell
{
    // 如果按钮是被选择状态
    if (shoppingCartCell.shoppingCartModel.selected == YES) {
        // 计算总价
        int totalPrice = self.totalPriceLabel.text.intValue + shoppingCartCell.shoppingCartModel.price.intValue * shoppingCartCell.shoppingCartModel.num.intValue;
        // 设置总价
        self.totalPriceLabel.text = [NSString stringWithFormat:@"%d",totalPrice];
        
        if ([self.goodsCar containsObject:shoppingCartCell.shoppingCartModel]) return;
           // 添加到购物车
           [self.goodsCar addObject:shoppingCartCell.shoppingCartModel];
           
    } else { // 如果按钮是非选择的状态
        // 计算总价
        int totalPrice = self.totalPriceLabel.text.intValue - shoppingCartCell.shoppingCartModel.price.intValue * shoppingCartCell.shoppingCartModel.num.intValue;
        // 设置总价
        self.totalPriceLabel.text = [NSString stringWithFormat:@"%d",totalPrice];
        [self.goodsCar removeObject:shoppingCartCell.shoppingCartModel];
        
    }
    
    
}

/*! 当用户点击了删除按钮的时候 */
- (void)shoppingCartCellDidClickDeleteButton:(ZBNShoppingCartCell *)shoppingCartCell
{
    
    [ZBNAlertTool zbn_alertTitle:@"确定要删除吗?" type:UIAlertControllerStyleAlert message:@"删了就没得老喔" didTask:^{
        if ([self.goodsArray containsObject:shoppingCartCell.shoppingCartModel]) {
            [self.goodsArray removeObject:shoppingCartCell.shoppingCartModel];
        }
        if (shoppingCartCell.shoppingCartModel.selected == YES) {
            int totalPrice = self.totalPriceLabel.text.intValue - shoppingCartCell.shoppingCartModel.price.intValue * shoppingCartCell.shoppingCartModel.num.intValue;
            self.totalPriceLabel.text = [NSString stringWithFormat:@"%d",totalPrice];
        }
        [self.tableView reloadData];
    }];
}

@end
