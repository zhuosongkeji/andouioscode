//
//  ZBNPayWayCell.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/2/22.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNPayWayCell.h"
#import "ZBNPostPayWayModel.h"
@interface ZBNPayWayCell ()

@property (weak, nonatomic) IBOutlet UIImageView *image;

@property (weak, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet UIButton *selectedBtn;

@end

@implementation ZBNPayWayCell

- (void)setPayWayM:(ZBNPostPayWayModel *)payWayM
{
    _payWayM = payWayM;
    
    self.image.image = [UIImage imageNamed:payWayM.image];
    self.name.text = payWayM.name;
    self.selectedBtn.selected = payWayM.selected;
}



@end
