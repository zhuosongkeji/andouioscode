//
//  MenuScreeningView.h
//  OgrinterProduct
//
//  Created by wongshine on 2019/11/28.
//  Copyright © 2019 RXF. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^selectBtnBlock)(NSString *str);

@interface MenuScreeningView : UIView

@property (nonatomic,copy) selectBtnBlock selcctblock;

-(void)menuScreeningViewDismiss;

@end
