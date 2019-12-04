//
//  CustomBarViewController.h
//  OgrinterProduct
//
//  Created by wongshine on 2019/11/28.
//  Copyright © 2019 RXF. All rights reserved.
//

typedef NS_ENUM(NSInteger,CustomBarType) {
    CustomBarTypeOne,
    CustomBarTypeTwo,
};


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomBarViewController : UITabBarController

-(instancetype)initFrame:(CustomBarType)type;

@end

NS_ASSUME_NONNULL_END
