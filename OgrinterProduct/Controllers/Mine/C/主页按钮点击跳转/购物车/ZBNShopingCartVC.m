//
//  ZBNShopingCartVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/10.
//  Copyright © 2019 RXF. All rights reserved.
//

#define order_add_order @"order/add_order_car"//购买


#import "ZBNShopingCartVC.h"
#import "ZBNShoppingCartCell.h"
#import "ZBNShoppingCartModel.h"
#import "FKHRequestManager.h"
#import "OnlineBookingViewController.h"
#import "ZBNNewAddressVC.h"

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
/*! 全选按钮 */
@property (weak, nonatomic) IBOutlet UIButton *allSelectedBtn;
/*! 记录购物车ID */
@property (nonatomic, copy) NSString  *shopCartID;

@end

@implementation ZBNShopingCartVC

static NSString * const ZBNShopingCartCellID = @"shoppingCart";


/*! 去结算按钮的点击 */
- (IBAction)buyBtnClick:(UIButton *)sender {
    if ([self.totalPriceLabel.text integerValue] == 0) {
        [HUDManager showTextHud:@"至少要选择一个产品"];
        return;
    }
    
    
    NSData * data1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"infoData"];
    userInfo * unmodel = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",API_BASE_URL_STRING,order_add_order];
    
   NSDictionary *dicts = @{@"id":self.shopCartID,@"uid":unmodel.uid};
    
    [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:urlStr params:dicts complement:^(ServerResponseInfo * _Nullable serverInfo) {
        if ([serverInfo.response[@"code"] integerValue] == 200) {
            
            OnlineBookingViewController *Online = [[OnlineBookingViewController alloc]init];
            Online.payType = OnlineBookingViewProductPay;
            Online.order_sn = [[serverInfo.response objectForKey:@"data"] objectForKey:@"order_sn"];
            [self.navigationController pushViewController:Online animated:YES];
            
        }else if ([serverInfo.response[@"code"] integerValue] == 201){
            [HUDManager showTextHud:serverInfo.response[@"msg"]];
            ZBNNewAddressVC *vc = [[ZBNNewAddressVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            [HUDManager showTextHud:loadError];
        }
    }];

}


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
    [self setupRefresh];
   
    
}

- (void)setupTable
{
    [self.tableView registerNib:[UINib nibWithNibName:@"ZBNShoppingCartCell" bundle:nil] forCellReuseIdentifier:ZBNShopingCartCellID];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}


- (void)setupRefresh
{
    // 下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    // 自动改变透明度
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    // 马上进入刷新状态
    [self.tableView.mj_header beginRefreshing];
}

- (void)loadData
{
    // 取消之前所有的请求
    [FKHRequestManager cancleRequestWork];
    // 发起新的请求
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSData * data1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"infoData"];
    userInfo * unmodel = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
    params[@"uid"] = unmodel.uid;
    params[@"token"] = unmodel.token;
    ADWeakSelf;
    [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:@"http://andou.zhuosongkj.com/api/cart/index" params:params complement:^(ServerResponseInfo * _Nullable serverInfo) {
        weakSelf.goodsArray = [ZBNShoppingCartModel mj_objectArrayWithKeyValuesArray:serverInfo.response[@"data"]];
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_header endRefreshing];
    }];
}


/*! 全选按钮的点击 */
- (IBAction)allSelectedBtnClick:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    NSMutableString *idStr = [[NSMutableString alloc]init];
    if (sender.selected) {
        
        for (int i = 0; i < [self.goodsArray count]; i ++) {
            ZBNShoppingCartModel *model = self.goodsArray[i];
            
            if (i == [self.goodsArray count] - 1) {
                [idStr appendString:[NSString stringWithFormat:@"%@",model.ID]];
            }else{
                [idStr appendString:[NSString stringWithFormat:@"%@,",model.ID]];
            }
            
            if (model.selected) {
                continue;
            } else {
                model.selected = YES;
            }
            NSInteger totalPrice = self.totalPriceLabel.text.intValue + model.price.intValue * model.num.integerValue;
            self.totalPriceLabel.text = [NSString stringWithFormat:@"%zd",totalPrice];
            
            self.shopCartID = [NSString stringWithString:idStr];
        }
        [self.tableView reloadData];
        
    } else {
        for (ZBNShoppingCartModel *model in self.goodsArray) {
            if (model.selected == NO) {
                continue;
            } else {
                model.selected = NO;
            }
            NSInteger totalPrice = self.totalPriceLabel.text.intValue - model.price.intValue * model.num.intValue;
            self.totalPriceLabel.text = [NSString stringWithFormat:@"%zd",totalPrice];
            self.shopCartID = nil;
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
    
    self.shopCartID = shoppingCartCell.shoppingCartModel.ID;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSData * data1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"infoData"];
    userInfo * unmodel = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
    params[@"uid"] = unmodel.uid;
    params[@"token"] = unmodel.token;
    params[@"type"] = @"0";
    params[@"id"] = self.shopCartID;
    [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:@"http://andou.zhuosongkj.com/api/cart/update_num" params:params complement:^(ServerResponseInfo * _Nullable serverInfo) {
        if ([[serverInfo.response objectForKey:@"code"] integerValue] == 200) {
            if (shoppingCartCell.shoppingCartModel.selected == YES) {
            //计算总价
            int totalPrice = self.totalPriceLabel.text.intValue - shoppingCartCell.shoppingCartModel.num.intValue;
            //设置总价
            self.totalPriceLabel.text = [NSString stringWithFormat:@"%d",totalPrice];
            self.buyButton.enabled = totalPrice > 0;

            }
        }
        
    }];
    
}


/*! 当加号按钮点击的时候调用 */
- (void)shoppingCartCellDidClickPlusButton:(ZBNShoppingCartCell *)shoppingCartCell
{
    self.shopCartID = shoppingCartCell.shoppingCartModel.ID;
  
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSData * data1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"infoData"];
    userInfo * unmodel = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
    params[@"uid"] = unmodel.uid;
    params[@"token"] = unmodel.token;
    params[@"type"] = @"1";
    params[@"id"] = self.shopCartID;
    
    [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:@"http://andou.zhuosongkj.com/api/cart/update_num" params:params complement:^(ServerResponseInfo * _Nullable serverInfo) {
        if ([[serverInfo.response objectForKey:@"code"] integerValue] == 200) {
       if (shoppingCartCell.shoppingCartModel.selected == YES) {
        // 计算总价
        int totalPrice = self.totalPriceLabel.text.intValue + shoppingCartCell.shoppingCartModel.num.intValue;
        // 设置总价
        self.totalPriceLabel.text = [NSString stringWithFormat:@"%d",totalPrice];
        // 设置按钮可以点击
        self.buyButton.enabled = YES;
           
}
    }
        }];
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
    NSMutableArray *arr = [NSMutableArray array];
    NSMutableString *idStr = [NSMutableString string];
    for (ZBNShoppingCartModel *model in self.goodsArray) {
        if (model.isSelected) {
            [arr addObject:model];
        }
    }
    if (arr.count <= 0) {
        for (ZBNShoppingCartModel *model in arr) {
            self.shopCartID = model.ID;
        }
    } else {
        for (ZBNShoppingCartModel *model in arr) {
            if (model == arr.firstObject) {
                [idStr appendString:[NSString stringWithFormat:@"%@",model.ID]];
            } else {
                [idStr appendString:[NSString stringWithFormat:@",%@",model.ID]];
            }
        }
        self.shopCartID = idStr;
    }
    if (self.goodsArray.count == arr.count) {
        self.allSelectedBtn.selected = YES;
    } else {
        self.allSelectedBtn.selected = NO;
    }
    
}

/*! 当用户点击了删除按钮的时候 */
- (void)shoppingCartCellDidClickDeleteButton:(ZBNShoppingCartCell *)shoppingCartCell
{
    
    [ZBNAlertTool zbn_alertTitle:@"确定要删除吗?" type:UIAlertControllerStyleAlert message:@"删了就没得老喔" didTask:^{
        self.shopCartID = shoppingCartCell.shoppingCartModel.ID;
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        NSData * data1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"infoData"];
        userInfo * unmodel = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
        params[@"uid"] = unmodel.uid;
        params[@"token"] = unmodel.token;
        params[@"id"] = self.shopCartID;
        [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:@"http://andou.zhuosongkj.com/api/cart/delcar" params:params complement:^(ServerResponseInfo * _Nullable serverInfo) {
            
            if ([[serverInfo.response objectForKey:@"code"] integerValue] == 200) {
                if ([self.goodsArray containsObject:shoppingCartCell.shoppingCartModel]) {
                    [self.goodsArray removeObject:shoppingCartCell.shoppingCartModel];
                }
                if (shoppingCartCell.shoppingCartModel.selected == YES) {
                    int totalPrice = self.totalPriceLabel.text.intValue - shoppingCartCell.shoppingCartModel.price.intValue * shoppingCartCell.shoppingCartModel.num.intValue;
                    self.totalPriceLabel.text = [NSString stringWithFormat:@"%d",totalPrice];
                    
                    if (self.goodsArray.count == 0) {
                        self.allSelectedBtn.selected = NO;
                    }
                    
                    if (self.goodsCar.count == 0) {
                        self.allSelectedBtn.selected = NO;
                    }
                    
                }
                [self.tableView reloadData];
            }
            
        }];
    
    }];
}

@end
