//
//  AssemTableViewCell.m
//  OgrinterProduct
//
//  Created by wongshine on 2020/2/20.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "AssemTableViewCell.h"
#import "AsseBlModel.h"

@interface AssemTableViewCell( )

@property (weak, nonatomic) IBOutlet UIImageView *icon;

@property (weak, nonatomic) IBOutlet UISlider *title;
@property (weak, nonatomic) IBOutlet UILabel *old;

@property (weak, nonatomic) IBOutlet UILabel *newlable;
@property (weak, nonatomic) IBOutlet UILabel *tlt;

@end

@implementation AssemTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


-(void)setModelist:(AsseBlModel *)modelist{
    _modelist = modelist;
    
    [self.icon sd_setImageWithURL:[NSURL URLWithString:modelist.img] placeholderImage:nil];
    
    self.tlt.text = modelist.name;
    
    self.old.text = modelist.old_price;
    self.newlable.text = modelist.price;
    self.yplable.text = [NSString stringWithFormat:@"%@已拼购",modelist.buy_total];
    self.title.value = [modelist.sale_percent floatValue];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
