//
//  DropMenuView.h
//  OgrinterProduct
//
//  Created by wongshine on 2019/11/28.
//  Copyright © 2019 RXF. All rights reserved.
//


#import <UIKit/UIKit.h>

@class DropMenuView;
@protocol DropMenuViewDelegate <NSObject>

-(void)dropMenuView:(DropMenuView *)view didSelectName:(NSString *)str;

@end



@interface DropMenuView : UIView

@property (nonatomic, weak) id<DropMenuViewDelegate> delegate;

/** 箭头变化 */
@property (nonatomic, strong) UIView *arrowView;


/**
  控件设置

 @param view 提供控件 位置信息
 @param tableNum 显示TableView数量
 @param arr 使用数据
 */
-(void)creatDropView:(UIView *)view withShowTableNum:(NSInteger)tableNum withData:(NSArray *)arr;

/** 视图消失 */
- (void)dismiss;


@end
