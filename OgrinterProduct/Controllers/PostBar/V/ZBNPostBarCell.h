//
//  ZBNPostBarCell.h
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/2/17.
//  Copyright © 2020 RXF. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class ZBNSquareModel;
@interface ZBNPostBarCell : UITableViewCell
@property (nonatomic, strong) ZBNSquareModel *squareM;

@property (nonatomic, copy) void(^shareBtnClickTask)(ZBNSquareModel *model);

@end

NS_ASSUME_NONNULL_END
