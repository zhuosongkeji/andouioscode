//
//  ADCommonStaticCell.h
//  AnDouBusiness
//
//  Created by 周芳圆 on 2019/12/6.
//  Copyright © 2019 ZhouBunian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ADCellRowItemModel;
@interface ADCommonStaticCell : UITableViewCell
/**
 传入tableView 和 样式创建一个cell

 @param tableView tableView
 @param style 样式
 @return cell
 */
+ (instancetype)ad_initWithTableView:(UITableView *)tableView cellStyle:(UITableViewCellStyle)style;

/**
 根据模型决定cell显示什么内容
 */
@property (nonatomic, strong) ADCellRowItemModel *rowItemModel;

@end

NS_ASSUME_NONNULL_END
