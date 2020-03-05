//
//  AssemTableViewCell.h
//  OgrinterProduct
//
//  Created by wongshine on 2020/2/20.
//  Copyright © 2020 RXF. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class AsseBlModel,KillerListAessbModel;

@interface AssemTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *sbtn;

@property (weak, nonatomic) IBOutlet UILabel *yplable;
@property(nonatomic,strong)AsseBlModel *modelist;

@property(nonatomic,strong)KillerListAessbModel *modelis1;



@end

NS_ASSUME_NONNULL_END
