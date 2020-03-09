//
//  ZBNPostComReplyCell.h
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/3/7.
//  Copyright © 2020 RXF. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class ZBNPostComReplyFrame;
@interface ZBNPostComReplyCell : UITableViewCell

@property (nonatomic, strong) ZBNPostComReplyFrame *commentFrame;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end

NS_ASSUME_NONNULL_END
