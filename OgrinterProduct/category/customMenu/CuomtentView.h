//
//  CuomtentView.h
//  OgrinterProduct
//
//  Created by wongshine on 2020/1/9.
//  Copyright © 2020 RXF. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol CuomtentViewDelegate <NSObject>

-(void)didselectSure:(NSString *)uid;

@end

@interface CuomtentView : UIView

@property(nonatomic,strong)NSArray *typArr;

@property(nonatomic,weak)id<CuomtentViewDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
