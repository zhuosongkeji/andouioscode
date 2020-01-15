//
//  HotelDetailsBottomView.m
//  OgrinterProduct
//
//  Created by wongshine on 2019/12/9.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "HotelDetailsBottomView.h"
#import "HoleggModel.h"


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
@property (weak, nonatomic) IBOutlet UIImageView *icon;


@end


@implementation HotelDetailsBottomView


-(void)awakeFromNib{
    [super awakeFromNib];
    
}



-(void)setGglist:(HoleggModel *)gglist{
    _gglist = gglist;
    
    self.title.text = gglist.house_name;
    self.Price.text = [NSString stringWithFormat:@"￥ %@",gglist.price];
    
    self.otherPrice.text = [NSString stringWithFormat:@"￥ %@",gglist.price];
    
    self.measure.text = [NSString stringWithFormat:@"面积：%@平米",gglist.areas];
    
    if ([gglist.has_window integerValue] == 1) {
        self.windowlable.text = @"窗户：有";
    }else{self.windowlable.text = @"窗户：无";}
    
    if ([gglist.wifi integerValue] == 1) {
        self.Wifilable.text = @"WIFI：有";
    }else{self.Wifilable.text = @"窗户：无";}
    
    if ([gglist.has_breakfast integerValue] == 1) {
        self.breakfast.text = @"早餐：有";
    }else{self.breakfast.text = @"早餐：无";}
    

    self.capacity.text = [NSString stringWithFormat:@"可住：%@ 人",gglist.num];
    
    self.bedsize.text = [NSString stringWithFormat:@"床型：%@",gglist.bed_type];
    
    self.content.text = [NSString stringWithFormat:@"配套设施：%@",gglist.other_sets];
    
    [self.icon sd_setImageWithURL:[NSURL URLWithString:gglist.img] placeholderImage:nil];
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
