//
//  ZBNPostImageCell.h
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/2/20.
//  Copyright © 2020 RXF. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class ZBNSquareModel,ZBNPostPhotoItem;
@interface ZBNPostImageCell : UICollectionViewCell
@property (nonatomic, weak) UIImageView *imageView;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) ZBNPostPhotoItem *photoItem;

@end

NS_ASSUME_NONNULL_END
