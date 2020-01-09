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

@end


@implementation ZBNSHGoAndEvaluateCell

- (void)setModel:(ZBNSHGoAndEvaluateModel *)model
{
    _model = model;
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",imgServer,model.imageName]]];
    
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.textV.delegate = self;
    
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
