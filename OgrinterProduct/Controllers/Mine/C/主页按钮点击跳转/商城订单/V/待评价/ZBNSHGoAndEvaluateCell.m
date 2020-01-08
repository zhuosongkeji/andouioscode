//
//  ZBNSHGoAndEvaluateCell.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/6.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNSHGoAndEvaluateCell.h"
#import "TggStarEvaluationView.h"

@interface ZBNSHGoAndEvaluateCell () <UITextViewDelegate>
/*! 星星view */
@property (weak, nonatomic) IBOutlet UIView *starView;

@property (nonatomic, weak) TggStarEvaluationView *starCommentV;
/*! 评论内容 */
@property (weak, nonatomic) IBOutlet UITextView *textV;

@property (nonatomic, copy) NSString *comText;
@property (nonatomic, copy) NSString *starCount;

@end


@implementation ZBNSHGoAndEvaluateCell



- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.textV.delegate = self;
    
    ADWeakSelf;
    self.starCommentV = [TggStarEvaluationView evaluationViewWithChooseStarBlock:^(NSUInteger count) {
        weakSelf.starCount = [NSString stringWithFormat:@"%zd",count];
    }];
    [self.starView addSubview:self.starCommentV];
    
    if (self.dataHandel) {
        self.dataHandel(self.starCount, self.comText);
    }
    
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
    self.comText = textView.text;
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
