//
//  HotelBottomTableViewCell.m
//  OgrinterProduct
//
//  Created by wongshine on 2019/12/9.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "HotelBottomTableViewCell.h"
#import "HotelDetlisSubViewOneController.h"


@implementation HotelBottomTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}


-(void)setViewControllers:(NSMutableArray *)viewControllers{
    _viewControllers = viewControllers;
}


-(void)setCellCanScroll:(BOOL)cellCanScroll{
    _cellCanScroll = cellCanScroll;
    
    for (HotelDetlisSubViewOneController *VC in _viewControllers) {
        VC.vcCanScroll = cellCanScroll;
        if (!cellCanScroll) {
            //如果cell不能滑动，代表到了顶部，修改所有子vc的状态回到顶部
            VC.SubViewOnemTableView.contentOffset = CGPointZero;
        }
    }
}


- (void)setIsRefresh:(BOOL)isRefresh {
    _isRefresh = isRefresh;
    for (HotelDetlisSubViewOneController *ctrl in self.viewControllers) {
        if ([ctrl.title isEqualToString:self.currentTagStr]) {
            ctrl.isRefresh = isRefresh;
        }
    }
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}


@end
