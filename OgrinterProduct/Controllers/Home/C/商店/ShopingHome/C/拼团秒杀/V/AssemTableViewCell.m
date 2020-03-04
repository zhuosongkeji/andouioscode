//
//  AssemTableViewCell.m
//  OgrinterProduct
//
//  Created by wongshine on 2020/2/20.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "AssemTableViewCell.h"
#import "AsseBlModel.h"
#import "KillerListAessbModel.h"

@interface AssemTableViewCell(){
    CGFloat widths;
}

@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lablewidth;

@property (weak, nonatomic) IBOutlet UILabel *old;

@property (weak, nonatomic) IBOutlet UILabel *newlable;
@property (weak, nonatomic) IBOutlet UILabel *tlt;
@property (weak, nonatomic) IBOutlet UILabel *sllderb;

@property (weak, nonatomic) IBOutlet UILabel *sllderf;

@property (weak, nonatomic) IBOutlet UILabel *killlable;
@property (weak, nonatomic) IBOutlet UILabel *killlinelable;
@property (weak, nonatomic) IBOutlet UILabel *qiang;

@end

@implementation AssemTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.sllderb.layer.borderColor = UIColor.redColor.CGColor;
    self.sllderb.layer.borderWidth = .7;
    
    self.sllderb.layer.cornerRadius = 6;
    self.sllderf.layer.cornerRadius = 8;
    self.sllderf.backgroundColor = UIColor.redColor;
    self.sbtn.layer.cornerRadius = 8;
    
    widths = CGRectGetWidth(self.sllderb.frame);

    // Initialization code
}


-(void)setModelist:(AsseBlModel *)modelist{
    _modelist = modelist;
    
    [self.icon sd_setImageWithURL:[NSURL URLWithString:modelist.img] placeholderImage:nil];
    
    self.tlt.text = modelist.name;
    
    self.old.text = modelist.old_price;
    self.newlable.text = modelist.price;
    self.yplable.text = [NSString stringWithFormat:@"%@已拼购",modelist.buy_total];
//    self.title.value = [modelist.sale_percent floatValue];

}


-(void)setModelis1:(KillerListAessbModel *)modelis1{
    _modelis1 = modelis1;
    [self.icon sd_setImageWithURL:[NSURL URLWithString:modelis1.limg] placeholderImage:nil];
    
    [self.killlable setHidden:NO];
    
    [self.killlinelable setHidden:NO];
    [self.yplable setHidden:YES];
    
    self.tlt.text = modelis1.lname;
    
    self.killlable.text = [NSString stringWithFormat:@"￥%@",modelis1.lprice];
    self.newlable.text = [NSString stringWithFormat:@"￥%@",modelis1.lkill_price];
    
    CGFloat f = [modelis1.lkill_num  floatValue]/[modelis1.lnum floatValue];
    if (modelis1.lnum == nil || modelis1.lkill_num == nil) {
        self.qiang.text = @"";
    }else {
        self.qiang.text = [NSString stringWithFormat:@"已抢%.2f%@",f,@"%"];
    }
    
    [self.sllderf setFrame:CGRectMake(0, 0, 200, 16)];
//    self.title.value = f;
    self.lablewidth.constant = widths*f;
    
}


//-(void)layoutIfNeeded

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
