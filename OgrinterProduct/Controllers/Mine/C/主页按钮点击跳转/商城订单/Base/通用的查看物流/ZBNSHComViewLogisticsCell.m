//
//  ZBNSHComViewLogisticsCell.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/10.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNSHComViewLogisticsCell.h"
#import "ZBNSHDetailLogisticsModel.h"


@interface ZBNSHComViewLogisticsCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageV;

@property (weak, nonatomic) IBOutlet UILabel *contentL;

@property (weak, nonatomic) IBOutlet UILabel *timeL;

@end


@implementation ZBNSHComViewLogisticsCell

- (void)setDetailM:(ZBNSHDetailLogisticsModel *)detailM
{
    _detailM = detailM;
    
    self.contentL.text = detailM.context;
    self.timeL.text = detailM.time;
    if (detailM.firstOne == YES) {
        [self.contentL setTextColor:[UIColor colorWithRed:97/255.0 green:194/255.0  blue:156/255.0  alpha:1]];
        [self.timeL setTextColor:[UIColor colorWithRed:97/255.0 green:194/255.0  blue:156/255.0  alpha:1]];
        self.imageV.image = [UIImage imageNamed:@"物流点点"];
    } else {
        [self.contentL setTextColor:[UIColor grayColor]];
         [self.timeL setTextColor:[UIColor grayColor]];
        self.imageV.image = [UIImage imageNamed:@"物流点点1"];
    }
    
}




+ (instancetype)regiserCellForTable:(UITableView *)tableView
{
    static NSString * const ZBNSHComViewLogisticsCellID = @"ZBNSHComViewLogisticsCellID";
    ZBNSHComViewLogisticsCell *cell = [tableView dequeueReusableCellWithIdentifier:ZBNSHComViewLogisticsCellID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ZBNSHComViewLogisticsCell" owner:nil options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

@end
