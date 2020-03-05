//
//  AsseCollectionViewCell1.h
//  OgrinterProduct
//
//  Created by wongshine on 2020/2/20.
//  Copyright © 2020 RXF. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class KillerListAessbModel;

@interface AsseCollectionViewCell1 : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *titblabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconimg;

@property (weak, nonatomic) IBOutlet UILabel *tlable;
@property (weak, nonatomic) IBOutlet UILabel *plabel;

@property(nonatomic,strong)KillerListAessbModel *modellists;

@property(nonatomic,strong)KillerListAessbModel *listmodel;

@end

NS_ASSUME_NONNULL_END
