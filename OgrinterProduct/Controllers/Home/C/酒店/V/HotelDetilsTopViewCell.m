//
//  HotelDetilsTopViewCell.m
//  OgrinterProduct
//
//  Created by wongshine on 2019/12/9.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "HotelDetilsTopViewCell.h"


@implementation HotelDetilsTopViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


+ (instancetype)tempTableViewCellWith:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath{
    NSString *identifier = @"";
    NSInteger index = 0;
    switch (indexPath.row) {
        case 0:
            
            identifier = @"HotelDetilsTopViewCellOne";
            index = 0;
            break;
            
        case 1:
            
            identifier = @"HotelDetilsTopViewCellTwo";
            index = 1;
            break;
            
        default:
            break;
    }
    
    HotelDetilsTopViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HotelDetilsTopViewCell" owner:self options:nil] objectAtIndex:index];
        NSLog(@"创建");
    }
    
    return cell;
    
}


- (void)configTempCellWith:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:{
            
            break;
        }
            
        case 1: {
            
            break;
        }
            
        default:
            break;
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
