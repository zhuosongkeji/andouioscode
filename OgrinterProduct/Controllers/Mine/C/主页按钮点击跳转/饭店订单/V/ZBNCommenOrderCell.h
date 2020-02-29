//
//  ZBNCommenOrderCell.h
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/12.
//  Copyright © 2019 RXF. All rights reserved.
//

#import <AVKit/AVKit.h>


NS_ASSUME_NONNULL_BEGIN
@class ZBNRTComModel;
@interface ZBNCommenOrderCell : UITableViewCell

+ (instancetype)regiserCellForTable:(UITableView *)tableView;

/*! 模型数据 */
@property (nonatomic, strong) ZBNRTComModel *comM;


@end

NS_ASSUME_NONNULL_END
