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
#import "YNImageUploadView.h"
#import "Masonry.h"
#import "WMZDialog.h"

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
/*! 上传图片的view */
@property (weak, nonatomic) IBOutlet UIView *upImgV;
@property (nonatomic, weak) YNImageUploadView *upImg;
/*! 模型 */
@property (nonatomic, strong) ZBNSHReturnGoodsComM *resonM;
@property (nonatomic, copy) NSString *goods_id;

@end



@implementation ZBNSHAppReturnGoodsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // 初始化模型数据
    self.resonM = [ZBNSHReturnGoodsComM sharedInstance];
    // 设置手势
    [self setupGes];
    // 设置图片上传控件
    [self setupUpImgView];
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
    ADWeakSelf;
    Dialog().
    wTypeSet(DialogTypeSheet).
    wDataSet(@[@"7天无理由免费退换货",@"多拍,错拍,不想要",@"商品信息描述与实际不符",@"商品变质,发霉,有异物",@"其他"]).
    wTitleSet(@"退款原因").wOKColorSet([UIColor blackColor]).
    wEventFinishSet(^(id anyID,NSIndexPath *path, DialogType type){
        
        if ([anyID isEqualToString:@"7天无理由免费退换货"]) {
            weakSelf.resonM.reason_id = @"1";
        }
        if ([anyID isEqualToString:@"多拍,错拍,不想要"]) {
            weakSelf.resonM.reason_id = @"2";
        }
        if ([anyID isEqualToString:@"商品信息描述与实际不符"]) {
            weakSelf.resonM.reason_id = @"3";
        }
        if ([anyID isEqualToString:@"商品变质,发霉,有异物"]) {
            weakSelf.resonM.reason_id = @"4";
        }
        if ([anyID isEqualToString:@"其他"]) {
            weakSelf.resonM.reason_id = @"5";
        }
        [weakSelf.return_reason setText:anyID];
    }).
    wStart();
}


- (void)setupUpImgView
{
    ADWeakSelf;
    NSData * data1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"infoData"];
    userInfo * unmodel = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
        param[@"uid"] = unmodel.uid;
        param[@"token"] = unmodel.token;
       YNImageUploadView *imageView = [[YNImageUploadView alloc] initWithConfig:^(YNImageUploadViewConfig * _Nonnull config) {
           config.insets = UIEdgeInsetsMake(5, 10, 5, 10);
           config.autoHeight = YES;
           config.isNeedUpload = YES;
           config.uploadUrl = @"http://andou.zhuosongkj.com/index.php/api/goods/uploads";
           config.parameter = param;
       }];

           [weakSelf.upImgV addSubview:imageView];
             self.upImg = imageView;
           [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
           make.left.right.equalTo(weakSelf.upImgV);
           make.height.equalTo(@(80));
           }];
}

/*! 提交申请按钮点击 */
- (IBAction)replyBtnClick:(UIButton *)sender {
        // 发起请求
        [self returnMoneyRequest];
}

/*! 退款请求 */
- (void)returnMoneyRequest
{
    // 取消之前的请求
    [FKHRequestManager cancleRequestWork];
    ADWeakSelf;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSData * data1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"infoData"];
    userInfo * unmodel = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
    params[@"uid"] = unmodel.uid;
    params[@"token"] = unmodel.token;
    // 订单编号的ID
    params[@"order_goods_id"] = weakSelf.orderNum;
    // 退款原因
    params[@"reason_id"] = weakSelf.resonM.reason_id;
    // 退款说明 （选填）
    params[@"content"] = weakSelf.return_detail.text;
    // 图片 (选填)
    params[@"image"] = weakSelf.upImg.returnURL;
    [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:ZBNApplyURL params:params complement:^(ServerResponseInfo * _Nullable serverInfo) {
        if ([[serverInfo.response objectForKey:@"code"] intValue] == 200) {
            [HUDManager showTextHud:@"退款申请提交成功"];
            if (weakSelf.requestSuccessBlock) {
                weakSelf.requestSuccessBlock();
            }
        } else {
            [HUDManager showTextHud:@"申请失败"];
        }
    }];
}


@end
