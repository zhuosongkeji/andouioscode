//
//  ZBNSHComViewLogisticsHeader.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/10.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNSHComViewLogisticsHeader.h"

@interface ZBNSHComViewLogisticsHeader ()
/*! 承运公司 */
@property (weak, nonatomic) IBOutlet UILabel *companyL;
/*! 快递单号 */
@property (weak, nonatomic) IBOutlet UILabel *order_id;


@end

@implementation ZBNSHComViewLogisticsHeader


- (void)setVcM:(ZBNSHComViewLogisticsModel *)vcM
{
    _vcM = vcM;
    self.companyL.text = vcM.name;
    self.order_id.text = vcM.courier_num;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    
    
}




@end
