//
//  ZBNHTComCell.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/11.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNHTComCell.h"
#import "ZBNHTComModel.h"  // cell模型类


@interface ZBNHTComCell ()
/*! 状态label */
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
/*! 从左至右第一个按钮 */
@property (weak, nonatomic) IBOutlet UIButton *firsetBtn;
/*! 第二个 */
@property (weak, nonatomic) IBOutlet UIButton *secBtn;
/*! 第三个 */
@property (weak, nonatomic) IBOutlet UIButton *thiBtn;

/*! 商家LOGO */
@property (weak, nonatomic) IBOutlet UIImageView *shopIcon;
/*! 商家名 */
@property (weak, nonatomic) IBOutlet UILabel *shopName;
/*! 订单号 */
@property (weak, nonatomic) IBOutlet UILabel *order_num;
/*! 商品图 */
@property (weak, nonatomic) IBOutlet UIImageView *goodsImage;
/*! 商品名 */
@property (weak, nonatomic) IBOutlet UILabel *goodsName;
/*! 商品规格 */
@property (weak, nonatomic) IBOutlet UILabel *goods_attr;
/*! 商品单价 */
@property (weak, nonatomic) IBOutlet UILabel *goods_price;
/*! 商品数量 */
@property (weak, nonatomic) IBOutlet UILabel *goods_num;
/*! 总价格 */
@property (weak, nonatomic) IBOutlet UILabel *total_price;

@end


@implementation ZBNHTComCell


- (void)setComM:(ZBNHTComModel *)comM
{
    _comM = comM;
    
    
}


- (void)awakeFromNib
{
    [super awakeFromNib];
    
    if ([self.comM.status intValue] == 20) { //待入住
        self.firsetBtn.hidden = YES;
        self.secBtn.hidden = YES;
        self.thiBtn.hidden = NO;
        [self.thiBtn setTitle:@"订单详情" forState:UIControlStateNormal];
        [self.thiBtn setTitleColor:KSRGBA(97, 194, 156, 1) forState:UIControlStateNormal];
        self.thiBtn.layer.borderColor = KSRGBA(97, 194, 156, 1).CGColor;
    }
    
}



#pragma mark -- 按钮点击事件

/*! 第一个按钮点击 */
- (IBAction)firstBtnClick:(id)sender {
}
/*! 第二个按钮点击 */
- (IBAction)secBtnClick:(id)sender {
}
/*! 第三个按钮点击 */
- (IBAction)thiBtnClick:(id)sender {
}







+ (instancetype)regiserCellForTable:(UITableView *)tableView
{
    static NSString * const ZBNHTComCellID = @"ZBNHTComCellID";
    ZBNHTComCell *cell = [tableView dequeueReusableCellWithIdentifier:ZBNHTComCellID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ZBNHTComCell" owner:nil options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

@end
