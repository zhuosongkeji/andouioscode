//
//  MenuScreeningView.h
//  OgrinterProduct
//
//  Created by wongshine on 2019/11/28.
//  Copyright © 2019 RXF. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSInteger {
    
    MenuScreeningViewTypeOne = 0,
    
    MenuScreeningViewTypeTwo,
    
    MenuScreeningViewTypeThird,
    
} MenuScreeningViewType;


typedef void(^selectBtnBlock)(NSString *str);

@interface MenuScreeningView : UIView

@property (nonatomic,copy) selectBtnBlock selcctblock;



- (instancetype)initWithFrame:(CGRect)frame title:(NSArray *)titls withtype:(NSInteger)type;

-(void)menuScreeningViewDismiss;


@end
