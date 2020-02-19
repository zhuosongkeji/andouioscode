//
//  ShoperHeadView.h
//  OgrinterProduct
//
//  Created by wongshine on 2020/1/9.
//  Copyright © 2020 RXF. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^PtmsBtnBlock)(NSInteger idx);

@interface ShoperHeadView : UIView

@property (nonatomic,strong)NSArray *banArr;

@property(nonatomic,copy)PtmsBtnBlock ptmsBlock;

@end

NS_ASSUME_NONNULL_END
