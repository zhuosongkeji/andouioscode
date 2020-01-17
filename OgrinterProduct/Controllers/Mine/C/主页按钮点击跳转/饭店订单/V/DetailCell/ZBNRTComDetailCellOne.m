//
//  ZBNRTComDetailCellOne.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/16.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNRTComDetailCellOne.h"
#import "ZBNRTComDetailModel.h"

@interface ZBNRTComDetailCellOne ()
/*! 订单编号 */
@property (weak, nonatomic) IBOutlet UILabel *order_num;
/*! 订单时间 */
@property (weak, nonatomic) IBOutlet UILabel *create_time;
@end

@implementation ZBNRTComDetailCellOne

- (void)setDetailM:(ZBNRTComDetailModel *)detailM
{
    _detailM = detailM;
    self.order_num.text = detailM.order_sn;
    self.create_time.text = detailM.orderingtime;
}

@end
