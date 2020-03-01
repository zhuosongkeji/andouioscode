//
//  ZBNRTCommentCell.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/2/28.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNRTCommentCell.h"
#import "TggStarEvaluationView.h"
#import "YNImageUploadView.h"
#import "Masonry.h"
#import "ZBNRTCommentM.h"

@interface ZBNRTCommentCell () <UITextViewDelegate>

/*! 星星评论的背景 */
@property (weak, nonatomic) IBOutlet UIView *starBackView;
/*! 内容 */
@property (weak, nonatomic) IBOutlet UITextView *content;
/*! 上传图片你的背景view */
@property (weak, nonatomic) IBOutlet UIView *upImageView;
/*! 上传图 */
@property (nonatomic, weak) YNImageUploadView *upImg;
/*! 星星评论 */
@property (nonatomic, weak) TggStarEvaluationView *starCommentV;
@property (weak, nonatomic) IBOutlet UIButton *likeBtn;

@property (nonatomic, copy) NSString *count;

@property (nonatomic, strong) ZBNRTCommentM *comM;

@end


@implementation ZBNRTCommentCell


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


/*! 发表评论点击 */
- (IBAction)commentBtnClick:(UIButton *)sender {
    [self commentRequest];
}

/*! 喜欢点击 */
- (IBAction)likeBtnClick:(UIButton *)sender {
    sender.selected = !sender.selected;
}


- (void)awakeFromNib
{
    [super awakeFromNib];
    // 获取单例
    self.comM = [ZBNRTCommentM sharedInstance];
    self.content.delegate = self;
    ADWeakSelf;
       self.starCommentV = [TggStarEvaluationView evaluationViewWithChooseStarBlock:^(NSUInteger count) {
           weakSelf.count = [NSString stringWithFormat:@"%zd",count];
       }];
       [weakSelf.starBackView addSubview:weakSelf.starCommentV];
    // 设置图片上传
    [self setupUpLoadImgView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
    self.starCommentV.frame = CGRectMake(0, 0, self.starBackView.width, self.starBackView.height);
}


- (void)textViewDidBeginEditing:(UITextView *)textView
{
    self.content.text = nil;
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    
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

        [weakSelf.upImageView addSubview:imageView];
        self.upImg = imageView;
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf.upImageView);
        make.height.equalTo(@(80));
           }];
}

// 发表评论
- (void)commentRequest
{
    [FKHRequestManager cancleRequestWork];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSData * data1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"infoData"];
    userInfo * unmodel = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
    params[@"uid"] = unmodel.uid;
    params[@"token"] = unmodel.token;
    params[@"order_id"] = self.comM.order_id;
    params[@"merchants_id"] = self.comM.merchants_id;
    params[@"content"] = self.content.text;
    params[@"stars"] = self.count;
    params[@"image"] = self.upImg.returnURL;
    if (self.likeBtn.selected) {
        params[@"dianzhan"] = @"1";
    } else {
        params[@"dianzhan"] = @"0";
    }
    ADWeakSelf;
    [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:@"http://andou.zhuosongkj.com/index.php/api/gourmet/addcomment" params:params complement:^(ServerResponseInfo * _Nullable serverInfo) {
           if ([[serverInfo.response objectForKey:@"code"] intValue] == 200) {
               [HUDManager showTextHud:@"评论成功"];
               [[self viewController].navigationController popViewControllerAnimated:YES];
           } else {
               [HUDManager showTextHud:@"评论失败"];
           }
       }];
}


@end
