//
//  HotelOnlineOrderTableViewCell.m
//  OgrinterProduct
//
//  Created by wongshine on 2020/1/18.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "HotelOnlineOrderTableViewCell.h"

@implementation HotelOnlineOrderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



+ (instancetype)tempTableViewCellWith:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath{
    NSString *identifier = @"";
    NSInteger index = 0;
    switch (indexPath.section) {
        case 0:
            
            identifier = @"HotelOnlineOrderTableViewCell0";
            index = 0;
            break;
            
        case 1:
            
            identifier = @"HotelOnlineOrderTableViewCell1";
            index = 1;
            break;
            
        case 2:
            if (indexPath.row == 0) {
                identifier = @"HotelOnlineOrderTableViewCell2";
                index = 2;
            }else if (indexPath.row == 1){
                identifier = @"HotelOnlineOrderTableViewCell3";
                index = 3;
            }else if (indexPath.row == 2){
                identifier = @"HotelOnlineOrderTableViewCell4";
                index = 4;
            }else if (indexPath.row == 3){
                identifier = @"HotelOnlineOrderTableViewCell5";
                index = 5;
            }else{}
            
            break;
        
        case 3:
            
            identifier = @"HotelOnlineOrderTableViewCell6";
            index = 6;
            break;
        
        case 4:
            
            identifier = @"HotelOnlineOrderTableViewCell7";
            index = 7;
            break;
            
        default:
            break;
    }
    
    HotelOnlineOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HotelOnlineOrderTableViewCell" owner:self options:nil] objectAtIndex:index];
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


@end
