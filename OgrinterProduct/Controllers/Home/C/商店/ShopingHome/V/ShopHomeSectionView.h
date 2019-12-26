//
//  ShopHomeSectionView.h
//  OgrinterProduct
//
//  Created by wongshine on 2019/12/4.
//  Copyright © 2019 RXF. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^sectionBlcok)(UIButton *btn);

NS_ASSUME_NONNULL_BEGIN

@interface ShopHomeSectionView : UIView

@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UILabel *contntLable;

@property (nonatomic,copy)sectionBlcok btnclickBlcok;

@end

NS_ASSUME_NONNULL_END
