//
//  CustomSectionView.m
//  OgrinterProduct
//
//  Created by wongshine on 2019/11/28.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "CustomSectionView.h"

@implementation CustomSectionView


-(void)awakeFromNib{
    [super awakeFromNib];
}


- (IBAction)btnclick:(UIButton *)sender {
    KPreventRepeatClickTime(1)
    _btnclickBlock(sender);
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
