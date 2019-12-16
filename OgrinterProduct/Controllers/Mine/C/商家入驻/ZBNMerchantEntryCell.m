//
//  ZBNMerchantEntryCell.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/10.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ZBNMerchantEntryCell.h"


@implementation ZBNMerchantEntryCell



+ (instancetype)tempTableViewCellWith:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath{
    
    NSString *identifier = @"";
    NSInteger index = 0;
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            identifier = @"Merchant Entry CellOne";
        }else if (indexPath.row == 1){
            identifier = @"Merchant Entry CellTwo";
        }else if (indexPath.row == 2){
            identifier = @"Merchant Entry CellThree";
        }else if (indexPath.row == 3){
            identifier = @"Merchant Entry CellFour";
        }else if (indexPath.row == 4){
            identifier = @"Merchant Entry CellFive";
        }else if (indexPath.row == 5){
            identifier = @"Merchant Entry CellSix";
        }else {
            identifier = @"Merchant Entry CellOne";
        }
        
        index = indexPath.row;
        
    }else {
        
//        identifier = @"nil";
//        index = 6;
    }
    
    ZBNMerchantEntryCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ZBNMerchantEntryCell" owner:self options:nil] objectAtIndex:index];
        NSLog(@"创建");
    }
    return cell;
}


- (void)configTempCellWith:(NSIndexPath *)indexPath {
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


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
