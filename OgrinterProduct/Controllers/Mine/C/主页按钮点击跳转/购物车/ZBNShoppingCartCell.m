//
//  ZBNShoppingCartCell.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/10.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ZBNShoppingCartCell.h"
#import "ZBNShoppingCartModel.h"


@interface ZBNShoppingCartCell ()

/*! 用户或者商户的图标 */
@property (weak, nonatomic) IBOutlet UIImageView *userIconV;
/*! 用户名或者商户名 */
@property (weak, nonatomic) IBOutlet UILabel *userName;
/*! 商品图片 */
@property (weak, nonatomic) IBOutlet UIImageView *goodsImagev;
/*! 选中按钮 */
@property (weak, nonatomic) IBOutlet UIButton *selectedBtn;
/*! 商品介绍/名  */
@property (weak, nonatomic) IBOutlet UILabel *goodsIntrolLabel;
/*! 商品的价格 */
@property (weak, nonatomic) IBOutlet UILabel *goodsPrice;
/*! 减号按钮 */
@property (weak, nonatomic) IBOutlet UIButton *reduceBtn;
/*! 商品的数量 */
@property (weak, nonatomic) IBOutlet UILabel *goosCountLabel;
/*! 总数量label的背景view */
@property (weak, nonatomic) IBOutlet UIView *labelView;
@property (weak, nonatomic) IBOutlet UIView *plusBackView;
@property (weak, nonatomic) IBOutlet UIView *reduceBackView;

@property (nonatomic, strong) NSMutableArray *selectedArry;

@end

@implementation ZBNShoppingCartCell


/*! 设置模型数据 */
- (void)setShoppingCartModel:(ZBNShoppingCartModel *)shoppingCartModel
{
    _shoppingCartModel = shoppingCartModel;
    
    
    self.goodsImagev.image = [UIImage imageNamed:shoppingCartModel.image];
    self.goodsIntrolLabel.text = shoppingCartModel.name;
    self.goodsPrice.text = shoppingCartModel.money;
    self.goosCountLabel.text = [NSString stringWithFormat:@"%d",shoppingCartModel.count];
    self.reduceBtn.enabled = (shoppingCartModel.count > 0);
}


- (IBAction)reduceBtnClick:(UIButton *)sender {
    self.shoppingCartModel.count--;
    self.goosCountLabel.text = [NSString stringWithFormat:@"%d",self.shoppingCartModel.count];
    if (self.shoppingCartModel.count == 0) {
        self.reduceBtn.enabled = NO;
    }
    if ([self.delegate respondsToSelector:@selector(shoppingCartCellDidClickReduceButton:)]) {
        [self.delegate shoppingCartCellDidClickReduceButton:self];
    }
}

- (IBAction)plusBtnClick:(UIButton *)sender {
    // 修改模型
    self.shoppingCartModel.count++;
    // 修改Label的数量
    self.goosCountLabel.text = [NSString stringWithFormat:@"%d",self.shoppingCartModel.count];
    // 减号能点击
    self.reduceBtn.enabled = YES;
    // block 代理
    if ([self.delegate respondsToSelector:@selector(shoppingCartCellDidClickPlusButton:)]) {
        [self.delegate shoppingCartCellDidClickPlusButton:self];
    }
}

- (IBAction)deleteBtnClick:(UIButton *)sender {
    
    self.shoppingCartModel.isDelete = YES;
    if (self.deleteBtnClick) {
        self.deleteBtnClick(self.shoppingCartModel);
    }
    
}

/*! 当购物车Cell选择按点击的时候 */
- (IBAction)selecBtnClick:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    if (self.selectedBtn.selected == YES) {
        self.shoppingCartModel.selected = YES;
    } else {
        self.shoppingCartModel.selected = NO;
    }
    
    if ([self.delegate respondsToSelector:@selector(shoppingCartCellDidClickSelectedButton:)]) {
        [self.delegate shoppingCartCellDidClickSelectedButton:self];
    }
    
}




- (void)awakeFromNib {
    [super awakeFromNib];
   
    
    self.labelView.layer.borderWidth = 0.5;
    self.labelView.layer.borderColor = [UIColor colorWithRed:100/255.0 green:100/255.0  blue:100/255.0  alpha:1].CGColor;
    
    self.reduceBackView.layer.borderWidth = 0.5;
       self.reduceBackView.layer.borderColor = [UIColor colorWithRed:100/255.0 green:100/255.0  blue:100/255.0  alpha:1].CGColor;
    
    self.plusBackView.layer.borderWidth = 0.5;
    self.plusBackView.layer.borderColor = [UIColor colorWithRed:100/255.0 green:100/255.0  blue:100/255.0  alpha:1].CGColor;
    
    self.userIconV.layer.cornerRadius = 5;
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
