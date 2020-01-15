//
//  ZBNHTComCell.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/11.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNHTComCell.h"
#import "ZBNHTComModel.h"  // cell模型类
#import "ZBNHTCancelVC.h"  // 取消
#import "ZBNHTHadInVC.h"   // 待评价
#import "ZBNHTWaitInDetailVC.h"  // 待入住
#import "ZBNHTGoCommentVC.h"  // 评论控制器

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
/*! 商品数 */
@property (weak, nonatomic) IBOutlet UILabel *goods_attr;
/*! 商品单价 */
@property (weak, nonatomic) IBOutlet UILabel *goods_price;
/*! 总价 */
@property (weak, nonatomic) IBOutlet UILabel *totalPrice;

@end


@implementation ZBNHTComCell


- (void)setComM:(ZBNHTComModel *)comM
{
    
    
    
    _comM = comM;
    // 商家LOGO
    [self.shopIcon sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",imgServer,comM.logo_img]]];
    // 商家名
    self.shopName.text = comM.merchants_name;
    // 订单号
    self.order_num.text = comM.book_sn;
    // 商品图
    [self.goodsImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",imgServer,comM.img]]];
    // 商品名
    self.goodsName.text = comM.house_name;
    // 商品数
    // 商品价格
    self.goods_price.text = comM.price;
    // 总价格
    self.totalPrice.text = comM.price;
    
    if ([comM.status intValue] == 20) { //待入住
        self.firsetBtn.hidden = YES;
        self.secBtn.hidden = YES;
        self.thiBtn.hidden = NO;
        [self.thiBtn setTitle:@"订单详情" forState:UIControlStateNormal];
        [self.stateLabel setText:@"待入住"];
    } else if ([comM.status intValue] == 40) { // 已入住
        self.firsetBtn.hidden = YES;
        self.secBtn.hidden = NO;
        self.thiBtn.hidden = NO;
        [self.secBtn setTitle:@"去评价" forState:UIControlStateNormal];
        [self.thiBtn setTitle:@"订单详情" forState:UIControlStateNormal];
        [self.stateLabel setText:@"待评价"];
    } else if ([comM.status intValue] == 0) { // 已取消
        self.firsetBtn.hidden = YES;
        self.secBtn.hidden = YES;
        self.thiBtn.hidden = NO;
        [self.thiBtn setTitle:@"订单详情" forState:UIControlStateNormal];
        [self.stateLabel setText:@"已取消"];
    }
    
}



//获取控制器

- (UIViewController *)viewController
{
        for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];

         if ([nextResponder isKindOfClass:[UIViewController class]]) {
         return (UIViewController *)nextResponder;
     }
        
     }
      return nil;
}



- (void)awakeFromNib
{
    [super awakeFromNib];
    
}



#pragma mark -- 按钮点击事件

/*! 第一个按钮点击 */
- (IBAction)firstBtnClick:(id)sender {
}
/*! 第二个按钮点击 */
- (IBAction)secBtnClick:(id)sender {
    
    if (self.comM.status.intValue == 40) {  // 待评价的去评价
        ZBNHTGoCommentVC *vc = [[ZBNHTGoCommentVC alloc] init];
        [[self viewController].navigationController pushViewController:vc animated:YES];
    }
    
}
/*! 第三个按钮点击 */
- (IBAction)thiBtnClick:(id)sender {
    
    if (self.comM.status.intValue == 0) {  // 已取消的订单详情 ZBNHTCancelVC
        ZBNHTCancelVC *vc = [[ZBNHTCancelVC alloc] init];
        vc.book_sn = self.comM.book_sn;
        [[self viewController].navigationController pushViewController:vc animated:YES];
    } else if (self.comM.status.intValue == 20) { // 待入住的订单详情
        ZBNHTWaitInDetailVC *vc = [[ZBNHTWaitInDetailVC alloc] init];
        vc.book_sn = self.comM.book_sn;
        [[self viewController].navigationController pushViewController:vc animated:YES];    
    } else if (self.comM.status.intValue == 40) { // 待评价的订单详情
        ZBNHTHadInVC *vc = [[ZBNHTHadInVC alloc] init];
        vc.book_sn = self.comM.book_sn;
        [[self viewController].navigationController pushViewController:vc animated:YES];
    }
    
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
