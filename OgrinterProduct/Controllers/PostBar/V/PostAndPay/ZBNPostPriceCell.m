//
//  ZBNPostPriceCell.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/2/22.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNPostPriceCell.h"
#import "ZBNPostDingWayModel.h"

@interface ZBNPostPriceCell ()

@property (weak, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet UILabel *price;

@property (weak, nonatomic) IBOutlet UIButton *selctedBTn;
@end

@implementation ZBNPostPriceCell

- (void)setDingM:(ZBNPostDingWayModel *)dingM
{
    _dingM = dingM;
    
    self.name.text = dingM.name;
    self.price.text = [NSString stringWithFormat:@"¥%@",dingM.price];
    self.selctedBTn.selected = dingM.selected;
    
}


@end
