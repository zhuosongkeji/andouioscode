//
//  SeckillTableViewCell.m
//  OgrinterProduct
//
//  Created by wongshine on 2019/12/12.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "SeckillTableViewCell.h"

@implementation SeckillTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



+ (instancetype)tempTableViewCellWith:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath type:(ShopSeckillDetailsType)type{
    
    NSString *identifier = @"";
    NSInteger index = 0;
    
    if (type == ShopSeckillDetailsTypeKill) {
        
        if (indexPath.row == 0) {
            identifier = @"SeckillTableViewCellOne";
            index = 0;
        } else if (indexPath.row == 1) {
            identifier = @"SeckillTableViewCellTwo";
            index = 1;
        }else if (indexPath.row == 2) {
            identifier = @"SeckillTableViewCellFouth";
            index = 3;
        }else if (indexPath.row == 3) {
            identifier = @"SeckillTableViewCellSix";
            index = 5;
        }else{}
        
    }else if (type == ShopSeckillDetailsTypeOrder){
        if (indexPath.row == 0) {
            identifier = @"SeckillTableViewCellThrid";
            index = 2;
        }else if (indexPath.row == 1) {
            identifier = @"SeckillTableViewCellFouth";
            index = 3;
        }else if (indexPath.row == 2) {
            identifier = @"SeckillTableViewCellFive";
            index = 4;
        }else if (indexPath.row == 3) {
            identifier = @"SeckillTableViewCellSix";
            index = 5;
        }
    }else if (type == ShopSeckillDetailsTypeOther){
        
        
    }else {
        
    }
    
    
    SeckillTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SeckillTableViewCell" owner:self options:nil] objectAtIndex:index];
        NSLog(@"创建");
    }
    
    return cell;
}


- (void)configTempCellWith:(NSIndexPath *)indexPath {
    if (indexPath.row != 3) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }else {
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
    }
    
}


@end
