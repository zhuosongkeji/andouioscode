//
//  ZBNSHCommonPayCell.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/9.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNSHCommonPayCell.h"

#import "ZBNSHOrderDetailComM.h"
#import "ZBNSHOrderUserInfoM.h"
#import "ZBNSHOrderDetailsM.h"


@interface ZBNSHCommonPayCell () <UITextFieldDelegate>
/*! 商品图 */
@property (weak, nonatomic) IBOutlet UIImageView *img;
/*! 商品名 */
@property (weak, nonatomic) IBOutlet UILabel *name;
/*! 商品规格 */
@property (weak, nonatomic) IBOutlet UILabel *goods_attr;
/*! 价格 */
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
/*! 数量 */
@property (weak, nonatomic) IBOutlet UILabel *count;
/*! 用户名 */
@property (weak, nonatomic) IBOutlet UILabel *userName;
/*! 手机号 */
@property (weak, nonatomic) IBOutlet UILabel *phoneNumber;
/*! 地址 */
@property (weak, nonatomic) IBOutlet UILabel *addressL;
/*! 运送方式 */
@property (weak, nonatomic) IBOutlet UILabel *sendWay;
/*! 积分 */
@property (weak, nonatomic) IBOutlet UITextField *integerT;
/*! 微信选择方式按钮 */
@property (weak, nonatomic) IBOutlet UIButton *selctedBtn;
/*! 结算价格 */
@property (weak, nonatomic) IBOutlet UILabel *total_price;

@property (weak, nonatomic) IBOutlet UIButton *integraBtn;


@end


@implementation ZBNSHCommonPayCell


+ (instancetype)regiserCellForTable:(UITableView *)tableView
{
    static NSString * const ZBNSHCommonPayCellID = @"ZBNSHCommonPayCellID";
    ZBNSHCommonPayCell *cell = [tableView dequeueReusableCellWithIdentifier:ZBNSHCommonPayCellID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ZBNSHCommonPayCell" owner:nil options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}




- (void)setComM:(ZBNSHOrderDetailComM *)comM
{
    _comM = comM;
    // 运送方式
    
    // 积分
    self.integerT.text = [NSString stringWithFormat:@"需要积分%@",comM.integral];

    // 结算价格
    self.total_price.text = [NSString stringWithFormat:@"%@元",comM.order_money];
}

- (void)setDetailM:(ZBNSHOrderDetailsM *)detailM
{
    _detailM = detailM;
    // 商品图片
    [self.img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",imgServer,detailM.img]]];
    // 商品名
    self.name.text = detailM.name;
    // 商品规格
    NSMutableString *muStr = [NSMutableString string];
    for (NSString *str in detailM.attr_value) {
        [muStr appendString:[NSString stringWithFormat:@"%@",str]];
    }
    self.goods_attr.text = [NSString stringWithFormat:@"%@",muStr];
    // 价格
    self.priceLabel.text = [NSString stringWithFormat:@"¥%@",detailM.price];
    // 数量
    self.count.text = [NSString stringWithFormat:@"x%@",detailM.num];
}

// 用户模型
- (void)setUserInfoM:(ZBNSHOrderUserInfoM *)userInfoM
{
    _userInfoM = userInfoM;
    
    self.userName.text = userInfoM.name;
    self.phoneNumber.text = userInfoM.mobile;
    self.addressL.text = [NSString stringWithFormat:@"%@%@%@%@",userInfoM.province,userInfoM.city,userInfoM.area,userInfoM.address];
    
}


/*! 选择微信按钮的点击 */
- (IBAction)btnClick:(UIButton *)sender {
//    ZBNSHCommonPayModel *model = [ZBNSHCommonPayModel sharedInstance];
    sender.selected = !sender.selected;
    
    if (sender.selected) {
        if (self.selBtnClick) {
            self.selBtnClick(@"1");
        }
    } else {
        NSLog(@"heeheh");
    }
    
}
/*! 是否使用积分 */
- (IBAction)integralBtnClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (self.integerBtnClickTask) {
        self.integerBtnClickTask(sender);
    }
}


- (void)awakeFromNib
{
    [super awakeFromNib];
    self.integerT.delegate = self;
    
}






@end
