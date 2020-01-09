//
//  ZBNRechargeCell.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/16.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ZBNRechargeCell.h"
#import "ZBNRechargeModel.h"
#import "ZBNWalletRechargeModel.h"

@interface ZBNRechargeCell () <UITextFieldDelegate>

/*! 余的红色背景 */
@property (weak, nonatomic) IBOutlet UIView *LabelView;
/*! 充值的数量TextField */
@property (weak, nonatomic) IBOutlet UITextField *rechargeNumber;
/*! 联系号码 */
@property (weak, nonatomic) IBOutlet UITextField *contactNumber;
/*! 微信 */
@property (weak, nonatomic) IBOutlet UIButton *weChartBtn;

@property (nonatomic, strong) ZBNWalletRechargeModel *reModel;

@end

@implementation ZBNRechargeCell


- (void)awakeFromNib
{
    [super awakeFromNib];
    [self loadData];
    [self addDelegate];
    
    self.LabelView.layer.cornerRadius = self.LabelView.height * 0.5;
}


- (void)loadData
{
    NSData * data1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"infoData"];
         userInfo * unmodel = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
         NSMutableDictionary *param = [NSMutableDictionary dictionary];
        param[@"uid"] = unmodel.uid;
        param[@"token"] = unmodel.token;
        ADWeakSelf;
            [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:@"http://andou.zhuosongkj.com/index.php/api/wallet/rechar" params:param complement:^(ServerResponseInfo * _Nullable serverInfo) {
                if ([[serverInfo.response objectForKey:@"code"] intValue] == 200) {
                    weakSelf.reModel = [ZBNWalletRechargeModel mj_objectWithKeyValues:serverInfo.response[@"data"]];
                    self.moneyLabel.text = weakSelf.reModel.money;
                    self.contactNumber.text = weakSelf.reModel.mobile;
                } else {
                    [HUDManager showTextHud:@"数据加载失败"];
                }
            }];
}



+ (instancetype)registerCellForTableView:(UITableView *)tableView
{
    static NSString * const ZBNRechargeCellID = @"oneCell";
    ZBNRechargeCell *cell = [tableView dequeueReusableCellWithIdentifier:ZBNRechargeCellID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ZBNRechargeCell" owner:nil options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)addDelegate
{
    self.rechargeNumber.delegate = self;
    self.contactNumber.delegate = self;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (self.rechargeNumberBlock) {
        self.rechargeNumberBlock(self.rechargeNumber.text);
    }
    if (self.contactNumberBlock) {
        self.contactNumberBlock(self.contactNumber.text);
    }
    
}






/*! 支付按钮的点击 */
- (IBAction)payBtnClick:(UIButton *)sender {
    
    sender.selected = !sender.selected;
   if (sender.selected) {
 
        if (self.modeBlock) {
            self.modeBlock(@"1");
             NSLog(@"微信支付");
        }
            
    
}
}






@end
