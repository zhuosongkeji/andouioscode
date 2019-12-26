//
//  BeserveView.m
//  OgrinterProduct
//
//  Created by wongshine on 2019/12/17.
//  Copyright © 2019 RXF. All rights reserved.
//


#import "BeserveView.h"

@interface BeserveView()

@property (weak, nonatomic) IBOutlet UIView *bjView;
@property (weak, nonatomic) IBOutlet UIButton *plashbtn;
@property (weak, nonatomic) IBOutlet UIButton *addbtn;
@property (weak, nonatomic) IBOutlet UILabel *numberlable;

@property (nonatomic) NSInteger num;


@end


@implementation BeserveView


-(void)awakeFromNib{
    [super awakeFromNib];
    [self setup];
}



-(void)setup{
    
    for (UILabel *lable in self.bjView.subviews) {
        if ([lable isKindOfClass:[UILabel class]]) {
            UILabel *label = (UILabel *)lable;
            if (label.tag != 0) {
                label.layer.cornerRadius = 12;
                label.layer.borderColor = label.textColor.CGColor;
                label.layer.borderWidth = 0.8;
            }
        }
    }
    
    self.plashbtn.layer.cornerRadius = 2;
    self.plashbtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.plashbtn.layer.borderWidth = 0.8;
    
    self.addbtn.layer.cornerRadius = 2;
    self.addbtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.addbtn.layer.borderWidth = 0.8;
    
    self.num = 1;
    self.numberlable.text = [NSString stringWithFormat:@"%ld",self.num];
    
}


- (IBAction)btnclick:(UIButton *)sender {
    KPreventRepeatClickTime(1)
    _payBlock(sender);
}


- (IBAction)btnclicks:(UIButton *)sender {
    if (sender.tag == 300) {
        self.num -= 1;
        if (self.num <= 0) {
            self.num = 0;
        }
    }else if (sender.tag == 301){
        self.num +=1;
    }else{}
    
    self.numberlable.text = [NSString stringWithFormat:@"%ld",self.num];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
