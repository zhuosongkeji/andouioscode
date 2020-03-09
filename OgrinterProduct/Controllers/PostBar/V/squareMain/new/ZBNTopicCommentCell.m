//
//  ZBNTopicCommentCell.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/3/5.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNTopicCommentCell.h"
#import "ZBNCommentFrame.h"
#import "ZBNPostComModel.h"
#import "ZBNTopicComFrame.h"

@interface ZBNTopicCommentCell ()
/*! 头像 */
@property (nonatomic, weak) UIImageView *userIcon;
/*! 评论或回复 */
@property (nonatomic, weak) YYLabel *text;

@end


@implementation ZBNTopicCommentCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"CommentCell";
    ZBNTopicCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        NSLog(@"....cell嵌套tableView.....创建评论cell...");
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self setupSubViews];
        self.contentView.backgroundColor = KSRGBA(241, 241, 241, 1);
    }
    return self;
}

- (void)setCommentFrame:(ZBNTopicComFrame *)commentFrame
{
    _commentFrame = commentFrame;
    
    ZBNPostComModel *comM = commentFrame.comment;
    self.userIcon.frame  = commentFrame.userIconFrame;
    [self.userIcon setHeader:comM.avator];
    self.text.frame  =commentFrame.textFrame;
    self.text.attributedText = comM.attributedText;
    
}

- (void)setupSubViews
{
    // 头像
    UIImageView *userIcon = [[UIImageView alloc] init];
    [self.contentView addSubview:userIcon];
    self.userIcon = userIcon;
    // 文字
    YYLabel *text = [[YYLabel alloc] init];
    text.numberOfLines = 0;
    text.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:text];
    self.text = text;
}


@end
