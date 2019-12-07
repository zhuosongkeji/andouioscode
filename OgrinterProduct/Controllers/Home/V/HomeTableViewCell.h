//
//  HomeTableViewCell.h
//  OgrinterProduct
//
//  Created by wongshine on 2019/11/28.
//  Copyright © 2019 RXF. All rights reserved.
//

typedef enum : NSUInteger {
    
    CustomCellStyleOne,
    CustomCellStyleTwo,
    CustomCellStyleThird,
    CustomCellStyleFouth,
    
}CustomCellStyle;

#import <UIKit/UIKit.h>
@class HomeCellModel;

NS_ASSUME_NONNULL_BEGIN

@interface HomeTableViewCell : UITableViewCell

@property (nonatomic,strong)HomeCellModel *listmodel;

@property(nonatomic)CustomCellStyle style;


+ (instancetype)tempTableViewCellWith:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;


- (void)configTempCellWith:(NSIndexPath *)indexPath;



@end

NS_ASSUME_NONNULL_END
