//
//  ZBNSHGoAndEvaluateCell.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/6.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNSHGoAndEvaluateCell.h"
#import "TggStarEvaluationView.h"
#import "ZBNSHGoAndEvaluateModel.h"
#import "YNImageUploadView.h"
#import "Masonry.h"

@interface ZBNSHGoAndEvaluateCell () <UITextViewDelegate>
/*! 星星view */
@property (weak, nonatomic) IBOutlet UIView *starView;
/*!  */
@property (nonatomic, weak) TggStarEvaluationView *starCommentV;
/*! 评论内容 */
@property (weak, nonatomic) IBOutlet UITextView *textV;

/*! 商品图片的View */
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
/*! 上传图片的View */
@property (weak, nonatomic) IBOutlet UIView *upImgView;
@property (nonatomic, weak) YNImageUploadView *upImg;
/*! 模型 */
@property (nonatomic, strong) ZBNSHGoAndEvaluateModel *model;
@end


@implementation ZBNSHGoAndEvaluateCell

/*! 评论按钮点击 */
- (IBAction)commentBtnClick:(UIButton *)sender {
    // 发起评论请求
    [self commentRequest];
}

- (void)commentRequest
{
  
    [FKHRequestManager cancleRequestWork];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSData * data1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"infoData"];
    userInfo * unmodel = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
    params[@"uid"] = unmodel.uid;
    params[@"token"] = unmodel.token;
    params[@"goods_id"] = self.model.goods_id;
    params[@"order_id"] = self.model.order_id;
    params[@"merchants_id"] = self.model.merchants_id;
    params[@"content"] = self.model.content;
    params[@"stars"] = self.model.stars;
    params[@"image"] = self.upImg.returnURL;
       ADWeakSelf;
       [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:@"http://andou.zhuosongkj.com/index.php/api/order/addcomment" params:params complement:^(ServerResponseInfo * _Nullable serverInfo) {
           if ([[serverInfo.response objectForKey:@"code"] intValue] == 200) {
               if (weakSelf.commentBtnClickTask) {
                   weakSelf.commentBtnClickTask();
               }
           } else {
               [HUDManager showTextHud:@"评论失败"];
           }
       }];
}


- (void)setModel:(ZBNSHGoAndEvaluateModel *)model
{
    _model = model;
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",imgServer,model.imageName]]];
    
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    // 获取模型数据
    self.model = [ZBNSHGoAndEvaluateModel sharedInstance];
    
    self.textV.delegate = self;
    
    // 设置图片上传控件
    [self setupUpLoadImgView];
    
    ADWeakSelf;
    self.starCommentV = [TggStarEvaluationView evaluationViewWithChooseStarBlock:^(NSUInteger count) {
        ZBNSHGoAndEvaluateModel *model = [ZBNSHGoAndEvaluateModel sharedInstance];
        [model setStars:[NSString stringWithFormat:@"%zd",count]];
    }];
    [weakSelf.starView addSubview:weakSelf.starCommentV];

}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.starCommentV.frame = CGRectMake(0, 0, self.starView.width, self.starView.height);
    
}


- (void)textViewDidBeginEditing:(UITextView *)textView
{
    self.textV.text = nil;
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    ZBNSHGoAndEvaluateModel *model = [ZBNSHGoAndEvaluateModel sharedInstance];
    [model setContent:self.textV.text];
}




- (void)setupUpLoadImgView
{
    ADWeakSelf;
    NSData * data1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"infoData"];
    userInfo * unmodel = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"uid"] = unmodel.uid;
    param[@"token"] = unmodel.token;
    YNImageUploadView *imageView = [[YNImageUploadView alloc] initWithConfig:^(YNImageUploadViewConfig * _Nonnull config) {
        config.insets = UIEdgeInsetsMake(5, 10, 5, 10);
        config.photoCount = 1;
        config.autoHeight = YES;
        config.isNeedUpload = YES;
        config.uploadUrl = ZBNImgUpLoadURL;
        config.parameter = param;
       }];

        [weakSelf.upImgView addSubview:imageView];
        self.upImg = imageView;
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf.upImgView);
        make.height.equalTo(@(80));
           }];
}


+ (instancetype)regiserCellForTable:(UITableView *)tableView
{
    static NSString * const ZBNSHGoAndEvaluateCellID = @"ZBNSHGoAndEvaluateCellID";
    ZBNSHGoAndEvaluateCell *cell = [tableView dequeueReusableCellWithIdentifier:ZBNSHGoAndEvaluateCellID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ZBNSHGoAndEvaluateCell" owner:nil options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

@end
