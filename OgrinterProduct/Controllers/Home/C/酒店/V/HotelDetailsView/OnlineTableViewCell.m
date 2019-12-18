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
@property (weak, nonatomic) IBOutlet UIImageView *ImgView;


@end

@implementation OnlineTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


+ (instancetype)tempTableViewCellWith:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath withTpye:(NSInteger)type{
    
    NSString *identifier = @"";
    NSInteger index = 0;
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            identifier = @"OnlineTableViewCellOne";
            index = indexPath.row;
        }else if (indexPath.row == 1){
            if (type == 0) {
                identifier = @"OnlineTableViewCellTwo";
                index = indexPath.row;
            }else if (type == 1){
                identifier = @"OnlineTableViewCellThrid";
                index = 2;
            }else if (type == 2){
                
            }
            
        }else if (indexPath.row == 2){
            if (type == 0) {
                identifier = @"OnlineTableViewCellFouth";
                index = 3;
            }else if (type == 1){
                identifier = @"OnlineTableViewCellSeven";
                index = 6;
            }else if (type == 2){
                
            }
            
        }else if (indexPath.row == 3){
            if (type == 0) {
                identifier = @"OnlineTableViewCellFive";
                index = 4;
            }else if (type == 1){
                identifier = @"OnlineTableViewCellEight";
                index = 7;
            }else if (type == 2){
                
            }
        }else if (indexPath.row == 4){
            identifier = @"OnlineTableViewCellSix";
            index = 5;
        }else if (indexPath.row == 5){
            identifier = @"OnlineTableViewCellSeven";
            index = 6;
        }else if(indexPath.row == 6){
            identifier = @"OnlineTableViewCellEight";
            index = 7;
        }else{}
        
    }else {
        
        identifier = @"OnlineTableViewCellNine";
        index = 8;
    }
    
    OnlineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"OnlineTableViewCell" owner:self options:nil] objectAtIndex:index];
        NSLog(@"创建");
    }
    
    if (indexPath.section == 1) {
        cell.sectionTwotitle.text = OnlineTitle[indexPath.row];
        cell.ImgView.image = [UIImage imageNamed:OnlineImg[indexPath.row]];
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


- (IBAction)btnClick:(UIButton *)sender {
    KPreventRepeatClickTime(1);
    [self.xlDelegate handleSelectedButtonActionWithSelectedIndexPath:self.selectedIndexPath];
}



@end
