//
//  CresTableViewCell.m
//  OgrinterProduct
//
//  Created by wongshine on 2019/12/8.
//  Copyright © 2019 RXF. All rights reserved.
//


#import "CresTableViewCell.h"
#import "MsgModel.h"


@interface CresTableViewCell()

@end

@implementation CresTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (instancetype)tempTableViewCellWith:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath{
    
    
    NSString *identifier = @"";
    NSInteger index = 0;
    switch (indexPath.section ) {
        case 0:
            
            identifier = @"CresTableViewCell";
            index = 0;
            break;
            
        default:
            break;
    }
    
    CresTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CresTableViewCell" owner:self options:nil] objectAtIndex:index];
        NSLog(@"创建");
    }
    
    return cell;
}


- (void)configTempCellWith:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:{
           
            break;
        }
            
        default:
            break;
    }
}


- (IBAction)click:(UIButton *)sender {
    KPreventRepeatClickTime(1)
    _selectbtnBlock(sender);
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
