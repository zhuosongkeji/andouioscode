//
//  BeseListViewCell.m
//  OgrinterProduct
//
//  Created by wongshine on 2020/1/2.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "BeseListViewCell.h"
#import "BeseListListModel.h"


@interface BeseListViewCell()


@end


@implementation BeseListViewCell

-(void)setListlistModel:(BeseListListModel *)listlistModel{
    _listlistModel = listlistModel;
    [self setSubViews:listlistModel.value];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


-(void)setSubViews:(NSArray *)nums{
    
    for (int i = 0; i < [nums count]; i ++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake(16 + i*84, 12, 64, 20)];
        
        btn.layer.cornerRadius = 6;
        [btn setTitle:[NSString stringWithFormat:@"%@",nums[i]] forState:0];
        [btn setTag:i];
        btn.titleLabel.font = [UIFont systemFontOfSize:10];
        
        UIColor *color = nil;
        
        if (i == 0){
            color = [UIColor redColor];
            btn.selected = YES;
        }else{
            color = [UIColor lightGrayColor];
            btn.selected = NO;
        }
        btn.layer.borderWidth = 0.5;
        [btn setTitleColor:color forState:0];
        btn.layer.borderColor = color.CGColor;
        
        [btn addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:btn];
    }
}


-(void)action:(UIButton *)btns{

    for (UIButton *b in self.contentView.subviews) {
        if ([b isKindOfClass:[UIButton class]]) {
            if ((UIButton *)b == btns) {
                [b setTitleColor:[UIColor redColor] forState:0];
                b.layer.borderColor = [UIColor redColor].CGColor;
            }else{
                [b setTitleColor:[UIColor lightGrayColor] forState:0];
                b.layer.borderColor = [UIColor lightGrayColor].CGColor;
            }
        }
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(didSelect:)]) {
        [_delegate didSelect:btns];
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
