//
//  CustomBar.m
//  OgrinterProduct
//
//  Created by wongshine on 2019/11/28.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "CustomBar.h"

@implementation CustomBar

-(instancetype)init {
    self = [super init];
    
    if (self) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:imgStr(@"plus_Last") forState:UIControlStateNormal];
        [btn setImage:imgStr(@"plus_Last") forState:UIControlStateHighlighted];
        btn.bounds = CGRectMake(0, 0, 64, 64);
        self.midbtn = btn;
        [self addSubview:self.midbtn];
    }
    return self;
}


-(void)layoutSubviews {
    [super layoutSubviews];
    
    if (IPHONE_X)
        self.midbtn.center = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.1);
    else
        self.midbtn.center = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.3);
    
    int index = 0;
    
    CGFloat wigth = self.bounds.size.width / 5;
    
    for (UIView* sub in self.subviews) {
        
        if ([sub isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            
            if (IPHONE_X)
                sub.frame = CGRectMake(index * wigth, self.bounds.origin.y, wigth, self.bounds.size.height/1.8);
            else
                sub.frame = CGRectMake(index * wigth, self.bounds.origin.y, wigth, self.bounds.size.height - 2);
            
            index++;
            
            if (index == 2) {
                index++;
            }
        }
        
    }

}

//MARK:- 中间按钮的点击范围

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    if (self.isHidden == NO) {
        
        CGPoint newPoint = [self convertPoint:point toView:self.midbtn];
        
        if ( [self.midbtn pointInside:newPoint withEvent:event]) {
            return self.midbtn;
        }else{
            
            return [super hitTest:point withEvent:event];
        }
    }
    
    else {
        return [super hitTest:point withEvent:event];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
