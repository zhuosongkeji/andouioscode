//
//  ZBNTopicCommentCell.h
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/3/5.
//  Copyright © 2020 RXF. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class ZBNTopicComFrame,ZBNTopicCommentCell,ZBNPostUserModel;
@interface ZBNTopicCommentCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;
/** 评论Frame */
@property (nonatomic , strong) ZBNTopicComFrame *commentFrame;

@end

NS_ASSUME_NONNULL_END
