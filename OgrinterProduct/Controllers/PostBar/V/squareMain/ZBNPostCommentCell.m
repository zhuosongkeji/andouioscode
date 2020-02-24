//
//  ZBNPostCommentCell.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/2/17.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNPostCommentCell.h"
#import "ZBNPostComModel.h"
#import "ZBNCommentFrame.h"

@interface ZBNPostCommentCell ()
/*! 头像 */
@property (weak, nonatomic) IBOutlet UIImageView *userIcon;
/*! 评论或回复 */
@property (weak, nonatomic)  YYLabel *text;

@end

@implementation ZBNPostCommentCell


- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setupSubViews];
}

- (void)setupSubViews
{
    // label
    YYLabel *text = [[YYLabel alloc] init];
    text.numberOfLines = 0;
    text.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:text];
    self.text = text;
}


- (void)setCommentFrame:(ZBNCommentFrame *)commentFrame
{
    _commentFrame = commentFrame;
    
    ZBNPostComModel *model = commentFrame.comment;
    
    // 赋值
    self.text.frame = commentFrame.textFrame;
    self.text.attributedText = model.attributedText;
    
    [self.userIcon setHeader:model.fromUser.avatarUrl];
}






@end
