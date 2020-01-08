//
//  ZBNRechargeCell.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/16.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ZBNRechargeCell.h"
#import "ZBNRechargeModel.h"

@interface ZBNRechargeCell () <UITextFieldDelegate>

/*! 余的红色背景 */
@property (weak, nonatomic) IBOutlet UIView *LabelView;
/*! 充值的数量TextField */
@property (weak, nonatomic) IBOutlet UITextField *rechargeNumber;
/*! 联系号码 */
@property (weak, nonatomic) IBOutlet UITextField *contactNumber;
/*! 银联 */
@property (weak, nonatomic) IBOutlet UIButton *unionPayBtn;
/*! 微信 */
@property (weak, nonatomic) IBOutlet UIButton *weChartBtn;
/*! 支付宝 */
@property (weak, nonatomic) IBOutlet UIButton *zfbBtn;
/*! 银行卡号 */
@property (weak, nonatomic) IBOutlet UITextField *bankCardNumber;


@end

@implementation ZBNRechargeCell

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
    self.bankCardNumber.delegate = self;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (self.rechargeNumberBlock) {
        self.rechargeNumberBlock(self.rechargeNumber.text);
    }
    if (self.contactNumberBlock) {
        self.contactNumberBlock(self.contactNumber.text);
    }
    if (self.bankCardNumberBlock) {
        self.bankCardNumberBlock(self.bankCardNumber.text);
    }
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self addDelegate];
    
    self.LabelView.layer.cornerRadius = self.LabelView.height * 0.5;
    
}




/*! 支付按钮的点击 */
- (IBAction)payBtnClick:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    if (sender.tag == 10 && sender.selected) {
        self.weChartBtn.selected = NO;
        self.zfbBtn.selected = NO;
        if (self.modeBlock) {
            self.modeBlock(@"0");
        }
        NSLog(@"银联支付");
    } else if (sender.tag == 11 && sender.selected) {
        self.unionPayBtn.selected = NO;
        self.zfbBtn.selected = NO;
        if (self.modeBlock) {
            self.modeBlock(@"1");
        }
               
        NSLog(@"微信支付");
    } else if (sender.tag == 12 && sender.selected) {
        self.unionPayBtn.selected = NO;
        self.weChartBtn.selected = NO;
        if (self.modeBlock) {
            self.modeBlock(@"2");
        }
        NSLog(@"支付宝支付");
    
    } else {
        
    }
    
}






@end
