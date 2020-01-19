//
//  ZBNSHAppReturnGoodsCell.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/19.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNSHAppReturnGoodsCell.h"
#import "ZBNReturnGoodsM.h"
#import "ZBNReturnGoodsReasonView.h"
#import "ZBNSHReturnGoodsComM.h"

@interface ZBNSHAppReturnGoodsCell ()

/*! 商品图片 */
@property (weak, nonatomic) IBOutlet UIImageView *goods_img;
/*! 商品名字 */
@property (weak, nonatomic) IBOutlet UILabel *goods_name;
/*! 商品规格 */
@property (weak, nonatomic) IBOutlet UILabel *goods_intro;
/*! 商品价格 */
@property (weak, nonatomic) IBOutlet UILabel *goods_price;
/*! 商品数量 */
@property (weak, nonatomic) IBOutlet UILabel *goods_num;
/*! 退款理由 */
@property (weak, nonatomic) IBOutlet UILabel *return_reason;
/*! 退款金额 */
@property (weak, nonatomic) IBOutlet UILabel *return_money;
/*! 退款说明 */
@property (weak, nonatomic) IBOutlet UITextField *return_detail;
/*! 上传r图片的view */
@property (weak, nonatomic) IBOutlet UIView *upImgV;

@property (nonatomic, copy) NSString *goods_id;

@end



@implementation ZBNSHAppReturnGoodsCell

- (void)setGoodsM:(ZBNReturnGoodsM *)goodsM
{
    _goodsM = goodsM;
    
    [self.goods_img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",imgServer,goodsM.goodsImg]]];
    self.goods_name.text = goodsM.goodsName;
    self.goods_num.text = [NSString stringWithFormat:@"x%@",goodsM.goodsNum];
    self.goods_price.text = [NSString stringWithFormat:@"¥%@",goodsM.goodsPrice];
    self.goods_id = goodsM.goodsID;
    self.return_money.text = [NSString stringWithFormat:@"¥%@",goodsM.goodsPrice];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    
    // 设置手势
    [self setupGes];
    
}


- (void)setupGes
{
    self.return_reason.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick)];
    [self.return_reason addGestureRecognizer:tapGes];
}

- (void)labelClick
{
    ZBNSHReturnGoodsComM *model = [ZBNSHReturnGoodsComM sharedInstance];
    ZBNReturnGoodsReasonView *reView = [ZBNReturnGoodsReasonView viewFromXib];
    reView.width = KSCREEN_WIDTH;
    QWAlertView *alertV = [QWAlertView sharedMask];
    ADWeakSelf;
    [alertV show:reView withType:0 animationFinish:nil dismissHandle:^{
        [weakSelf.return_reason setText:model.content];
    }];
}


@end
