//
//  HotelDetailsBottomView.m
//  OgrinterProduct
//
//  Created by wongshine on 2019/12/9.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "HotelDetailsBottomView.h"

@interface HotelDetailsBottomView()

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *Price;
@property (weak, nonatomic) IBOutlet UIView *bannerbjView;
@property (weak, nonatomic) IBOutlet UILabel *measure;//面积
@property (weak, nonatomic) IBOutlet UILabel *Wifilable;
@property (weak, nonatomic) IBOutlet UILabel *breakfast;
@property (weak, nonatomic) IBOutlet UILabel *windowlable;
@property (weak, nonatomic) IBOutlet UILabel *capacity;
@property (weak, nonatomic) IBOutlet UILabel *bedsize;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UILabel *otherPrice;
@property (weak, nonatomic) IBOutlet UILabel *tatolPrice;


@end


@implementation HotelDetailsBottomView


-(void)awakeFromNib{
    [super awakeFromNib];
    
}


- (IBAction)btnclick:(UIButton *)sender {
    _reserveBlock(sender);
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
