//
//  CustomSectionView.h
//  OgrinterProduct
//
//  Created by wongshine on 2019/11/28.
//  Copyright © 2019 RXF. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^MoreBtnClickBlock)(UIButton *btn);

@interface CustomSectionView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *titimgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIButton *morebtn;

@property (nonatomic,copy) MoreBtnClickBlock btnclickBlock;

@end

NS_ASSUME_NONNULL_END
