//
//  ZBNSHAppReturnGoodsCell.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/19.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNSHAppReturnGoodsCell.h"
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



- (void)awakeFromNib {
    [super awakeFromNib];
    
    // 设置手势
    [self setupGes];
    
}

- (void)setDetailsM:(ZBNSHOrderDetailsM *)detailsM
{
    _detailsM = detailsM;
    [self.goods_img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",imgServer,detailsM.img]]];
    self.goods_name.text = detailsM.name;
    self.goods_num.text = [NSString stringWithFormat:@"x%@",detailsM.num];
    self.goods_price.text = [NSString stringWithFormat:@"¥%@",detailsM.price];
    self.return_money.text = [NSString stringWithFormat:@"¥%@",detailsM.price];
    NSMutableString *muStr = [NSMutableString string];
       for (NSString *str in detailsM.attr_value) {
           [muStr appendString:[NSString stringWithFormat:@"%@",str]];
       }
       self.goods_intro.text = [NSString stringWithFormat:@"%@",muStr];
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
        if (model.content == nil) {
            [weakSelf.return_reason setText:[NSString stringWithFormat:@"请选择理由"]];
        }
    }];
}


@end
