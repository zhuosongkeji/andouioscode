//
//  ZBNHTGoCommentCell.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/14.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNHTGoCommentCell.h"
#import "TggStarEvaluationView.h"
#import "YNImageUploadView.h"
#import "Masonry.h"

@interface ZBNHTGoCommentCell () <UITextViewDelegate>
/*! 星星背景view */
@property (weak, nonatomic) IBOutlet UIView *starView;
/*! 星星view */
@property (nonatomic, weak) TggStarEvaluationView *starCommentV;

@property (weak, nonatomic) IBOutlet UILabel *starLabel;
/*! 满意程度的label */
@property (weak, nonatomic) IBOutlet UITextView *comContentT;

@property (weak, nonatomic) IBOutlet UIButton *likeBtn;

/*! 图片上传的view */
@property (nonatomic, weak) YNImageUploadView *upLoadView;
/*! 图片上传的view */
@property (weak, nonatomic) IBOutlet UIView *upLoadImageV;

@end

@implementation ZBNHTGoCommentCell


- (void)textViewDidBeginEditing:(UITextView *)textView
{
    self.comContentT.text = nil;
}

/*! 点赞按钮 */
- (IBAction)likeBtnClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (self.likeBtn.selected) {
        self.likeBtn.enabled = NO;
        [self.likeBtn setImage:[UIImage imageNamed:@"Like"] forState:UIControlStateNormal];
    }
}


/*! 评论按钮 */
- (IBAction)comBtnClick:(id)sender {
    
    if (self.comBtnClickTask) {
        self.comBtnClickTask();
    }
}



- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self setstarView];
    
    self.comContentT.delegate = self;
}


- (void)setstarView
{
    ADWeakSelf;
    self.starCommentV = [TggStarEvaluationView evaluationViewWithChooseStarBlock:^(NSUInteger count) {
        if (count == 1) {
            [weakSelf.starLabel setText:@"很垃圾"];
        } else if (count == 2) {
            [weakSelf.starLabel setText:@"有点垃圾"];
        } else if (count == 3) {
            [weakSelf.starLabel setText:@"还好"];
        } else if (count == 4) {
            [weakSelf.starLabel setText:@"满意"];
        } else {
            [weakSelf.starLabel setText:@"大满足"];
        }
    }];
    
    [weakSelf.starView addSubview:weakSelf.starCommentV];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.starCommentV.frame = CGRectMake(0, 0, self.starView.width, self.starView.height);
    
    [self upLoadImgView];
}

- (void)upLoadImgView
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

           [weakSelf.upLoadImageV addSubview:imageView];
             weakSelf.upLoadView = imageView;
           [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
           make.left.right.equalTo(weakSelf.upLoadImageV);
           make.height.equalTo(@(80));
           
           }];
}

@end
