//
//  OnlineTableViewCell.m
//  OgrinterProduct
//
//  Created by wongshine on 2019/12/9.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "OnlineTableViewCell.h"
#import "OrderlModel.h"
#import "OrderListModel.h"
#import "PaywayModel.h"


@interface OnlineTableViewCell ()


@property (weak, nonatomic) IBOutlet UIImageView *shopIcon;
@property (weak, nonatomic) IBOutlet UILabel *shoptitle;
@property (weak, nonatomic) IBOutlet UILabel *shopcontnt;
@property (weak, nonatomic) IBOutlet UILabel *shoprice;
@property (weak, nonatomic) IBOutlet UILabel *number;



@property (weak, nonatomic) IBOutlet UILabel *rzdateLabel;
@property (weak, nonatomic) IBOutlet UILabel *livedateLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;



@property (weak, nonatomic) IBOutlet UILabel *OrderAddress;
@property (weak, nonatomic) IBOutlet UILabel *OrderName;
@property (weak, nonatomic) IBOutlet UILabel *OrderPhone;


@property (weak, nonatomic) IBOutlet UILabel *rzNumber;


@property (weak, nonatomic) IBOutlet UITextField *lxrName;

@property (weak, nonatomic) IBOutlet UITextField *lxrPhone;


@property (weak, nonatomic) IBOutlet UILabel *yqjxzlabel;


@property (weak, nonatomic) IBOutlet UILabel *jflabel;


@property (weak, nonatomic) IBOutlet UILabel *sectionTwotitle;
@property (weak, nonatomic) IBOutlet UIImageView *ImgView;


@end


@implementation OnlineTableViewCell


-(void)setModellist1:(OrderListModel *)modellist1{
    _modellist1 = modellist1;
    
    [self.shopIcon sd_setImageWithURL:[NSURL URLWithString:modellist1.detailsimg] placeholderImage:nil];
    
    self.shoptitle.text = [NSString stringWithFormat:@"%@",modellist1.detailsname];
    self.shopcontnt.text = [NSString stringWithFormat:@"规格：%@",modellist1.detailsggStr];
    
    self.shoprice.text = [NSString stringWithFormat:@"￥%@",modellist1.detailsprice];
    self.number.text = [NSString stringWithFormat:@"x%@",modellist1.detailsnum];
}


-(void)setModellist3:(OrderlModel *)modellist3{
    self.OrderName.text = modellist3.name;
    self.OrderPhone.text = modellist3.mobile;
    self.OrderAddress.text = [NSString stringWithFormat:@"%@%@%@%@",modellist3.province,modellist3.city,modellist3.area,modellist3.address];
}


-(void)setModellist2:(PaywayModel *)modellist2 {
    
    _modellist2 = modellist2;
    self.sectionTwotitle.text = modellist2.pay_way;
    [self.ImgView sd_setImageWithURL:[NSURL URLWithString:modellist2.logo] placeholderImage:nil];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


+ (instancetype)tempTableViewCellWith:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath withTpye:(NSInteger)type{
    
    NSString *identifier = @"";
    NSInteger index = 0;
    
    if (indexPath.section == 0) {
        identifier = @"OnlineTableViewCellOne";
        index = 0;
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            if (type == 0) {
                identifier = @"OnlineTableViewCellTwo";
                index = 1;
            }else if (type == 1){
                identifier = @"OnlineTableViewCellThrid";
                index = 2;
            }else if (type == 2){
                
            }
        }else if (indexPath.row == 1){
            if (type == 0) {
                identifier = @"OnlineTableViewCellFouth";
                index = 3;
            }else if (type == 1){
                identifier = @"OnlineTableViewCellSeven";
                index = 6;
            }else if (type == 2){
                
            }
            
        }else if (indexPath.row == 2){
            if (type == 0) {
                identifier = @"OnlineTableViewCellFive";
                index = 4;
            }else if (type == 1){
                identifier = @"OnlineTableViewCellEight";
                index = 7;
            }else if (type == 2){
                
            }
            
        }else if (indexPath.row == 3){
            identifier = @"OnlineTableViewCellSix";
            index = 5;
        }else if (indexPath.row == 4){
            identifier = @"OnlineTableViewCellSeven";
            index = 6;
        }else if (indexPath.row == 5){
            identifier = @"OnlineTableViewCellEight";
            index = 7;
        }else{}
        
    }else{
        
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
