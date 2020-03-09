//
//  ZBNPostComReplyCell.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/3/7.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNPostComReplyCell.h"
#import "ZBNPostComReplyM.h"
#import "ZBNPostComReplyFrame.h"
#import "PPBadgeView.h"


@interface ZBNPostComReplyCell ()


@property (nonatomic, weak) UIImageView *header;
@property (nonatomic, weak) YYLabel *text;
@property (nonatomic, weak) YYLabel *_time;

@end


@implementation ZBNPostComReplyCell


+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"ZBNPostComReplyCell";
    ZBNPostComReplyCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        NSLog(@"....cell嵌套tableView.....创建话题cell...");
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return cell;
}

- (instancetype)initWithFrame:(CGRect)frame
{
  self =  [super initWithFrame:frame];
    if (self) {
        [self setSubViews];
    }
    return self;
    
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self  = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        // 创建子控件
        [self setSubViews];
        [self setupBadge];
    }
    return self;
}


- (void)setSubViews
{
    // 头像
    UIImageView *header = [[UIImageView alloc] init];
    [self.contentView addSubview:header];
    self.header = header;
    // 详细
    YYLabel *text = [[YYLabel alloc] init];
    text.numberOfLines = 0;
    text.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:text];
    self.text = text;
    // 时间
    YYLabel *_time = [[YYLabel alloc] init];
    _time.text = @"";
    _time.font = [UIFont systemFontOfSize:13];
    _time.textAlignment = NSTextAlignmentLeft;
    _time.textColor = KSRGBA(100, 100, 100, 1);
    [self.contentView addSubview:_time];
    self._time = _time;
}

- (void)setCommentFrame:(ZBNPostComReplyFrame *)commentFrame
{
    _commentFrame = commentFrame;
    ZBNPostComReplyM *reM = commentFrame.reM;
    self.header.frame = commentFrame.avatarFrame;
    [self.header setHeader:reM.avator];
    self._time.frame = commentFrame.createTimeFrame;
    self._time.text = reM.created_at;
    self.text.frame = commentFrame.titleFrame;
    self.text.attributedText = reM.attributedText;
    
    if (reM.read.intValue == 0) {
        [self.header pp_showBadge];
    } else {
        [self.header pp_hiddenBadge];
    }
}

- (void)setFrame:(CGRect)frame
{
    frame.size.height -= .5f;
    [super setFrame:frame];
}

- (void)setupBadge
{
    // 1. 给headeView添加小圆点
    [self.header pp_addDotWithColor:[UIColor redColor]];
    [self.header pp_setBadgeFlexMode:PPBadgeViewFlexModeHead];
    [self.header pp_moveBadgeWithX:-1 Y:1];
}



@end
