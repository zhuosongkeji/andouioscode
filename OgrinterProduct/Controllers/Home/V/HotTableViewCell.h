//
//  HotTableViewCell.h
//  OgrinterProduct
//
//  Created by wongshine on 2019/11/29.
//  Copyright © 2019 RXF. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HotTableViewCell : UITableViewCell

//datas
@property (nonatomic, strong) NSArray* hotCityArr;
@property (nonatomic, copy) void(^HotCityClickBlock)(NSString* name);
//views
@property (nonatomic, strong) UILabel* titleLb;
@property (nonatomic, strong) UICollectionView* collectionView;

+(instancetype)createKKLocalHotCityTableViewCellWithTableView:(UITableView*)tableView indexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
