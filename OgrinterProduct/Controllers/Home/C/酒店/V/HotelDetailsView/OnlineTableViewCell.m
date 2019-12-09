//
//  OnlineTableViewCell.m
//  OgrinterProduct
//
//  Created by wongshine on 2019/12/9.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "OnlineTableViewCell.h"


@interface OnlineTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *sectionTwotitle;


@end

@implementation OnlineTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


+ (instancetype)tempTableViewCellWith:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath{
    
    NSString *identifier = @"";
    NSInteger index = 0;
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            identifier = @"OnlineTableViewCellOne";
        }else if (indexPath.row == 1){
            identifier = @"OnlineTableViewCellTwo";
        }else if (indexPath.row == 2){
            identifier = @"OnlineTableViewCellThrid";
        }else if (indexPath.row == 3){
            identifier = @"OnlineTableViewCellFouth";
        }else if (indexPath.row == 4){
            identifier = @"OnlineTableViewCellFive";
        }else if (indexPath.row == 5){
            identifier = @"OnlineTableViewCellSix";
        }else {
            identifier = @"OnlineTableViewCellSeven";
        }
        
        index = indexPath.row;
        
    }else {
        
        identifier = @"OnlineTableViewCellEnit";
        index = 7;
    }
    
    OnlineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"OnlineTableViewCell" owner:self options:nil] objectAtIndex:index];
        NSLog(@"创建");
    }
    
    if (indexPath.section == 1) {
        cell.sectionTwotitle.text = OnlineTitle[indexPath.row];
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


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
