//
//  ShopHomeViewCell.h
//  OgrinterProduct
//
//  Created by wongshine on 2019/12/4.
//  Copyright © 2019 RXF. All rights reserved.
//

typedef enum : NSUInteger {
    
    MyEnumValueA,
    MyEnumValueB,
    MyEnumValueC,
    MyEnumValueD,
    
} MyEnum;

typedef void(^didselectItemBlock)(NSInteger idex,NSIndexPath * _Nullable indexpath);

#import <UIKit/UIKit.h>

@class ShoperModel;
NS_ASSUME_NONNULL_BEGIN

@interface ShopHomeViewCell : UITableViewCell

@property (nonatomic,copy) didselectItemBlock itemBlock;

@property (nonatomic) MyEnum enumtype;

@property (nonatomic,strong)ShoperModel *listModel;

@property (nonatomic,strong)NSArray *modellist;


@end

NS_ASSUME_NONNULL_END
