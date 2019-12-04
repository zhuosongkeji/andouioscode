//
//  HotCollectionViewCell.m
//  OgrinterProduct
//
//  Created by wongshine on 2019/11/29.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "HotCollectionViewCell.h"

@implementation HotCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initViews];
    }
    return self;
}


-(void)initViews{
    self.backgroundColor = [UIColor whiteColor];
    self.nameLb = [[UILabel alloc]initWithFrame:self.bounds];
    _nameLb.textColor = [UIColor darkGrayColor];
    _nameLb.font = [UIFont systemFontOfSize:15.0f];
    _nameLb.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_nameLb];
    self.layer.cornerRadius = 3.0f;
    self.layer.borderColor = KSRGBA(243, 243, 243, 1).CGColor;
    self.layer.borderWidth = 1.0f;
    self.layer.masksToBounds = YES;
}


-(void)setName:(NSString *)name{
    _name = name;
    _nameLb.text = name;
}

@end
