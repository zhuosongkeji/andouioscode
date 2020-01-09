//
//  ZBNSHCommonPayVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/9.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNSHCommonPayVC.h"
#import "ZBNSHCommonPayCell.h"
#import "ZBNSHOrderDetailComM.h"
#import "ZBNSHOrderUserInfoM.h"
#import "ZBNSHOrderDetailsM.h"
@interface ZBNSHCommonPayVC () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;


/*! 价格label */
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
/*! 立即购买的按钮 */
@property (weak, nonatomic) IBOutlet UIButton *buyButton;
/*! 订单详情的模型 */
@property (nonatomic, strong) ZBNSHOrderDetailComM *comM;
@property (nonatomic, strong) ZBNSHOrderUserInfoM *userInfoM;
@property (nonatomic, strong) ZBNSHOrderDetailsM *detailM;
@end

@implementation ZBNSHCommonPayVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    
    [self loadData];
}

- (void)loadData
{
    ADWeakSelf;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
        NSData * data1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"infoData"];
        userInfo * unmodel = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
        params[@"uid"] = unmodel.uid;
        params[@"token"] = unmodel.token;
        params[@"order_sn"] = self.order_id;
        [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:@"http://andou.zhuosongkj.com/api/order/details" params:params complement:^(ServerResponseInfo * _Nullable serverInfo) {
            self.comM = [ZBNSHOrderDetailComM mj_objectWithKeyValues:serverInfo.response[@"data"]];
            self.detailM = [ZBNSHOrderDetailsM mj_objectWithKeyValues:[serverInfo.response[@"data"] valueForKeyPath:@"details"][0]];
            self.userInfoM = [ZBNSHOrderUserInfoM mj_objectWithKeyValues:[serverInfo.response[@"data"] valueForKeyPath:@"userinfo"]];
            [weakSelf.myTableView reloadData];
        }];
}







/*! 立即购买按钮的点击 */
- (IBAction)buyButtonClick:(UIButton *)sender {
    
    
}



#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZBNSHCommonPayCell *cell = [ZBNSHCommonPayCell regiserCellForTable:tableView];
    cell.comM = self.comM;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 475;
}


@end
