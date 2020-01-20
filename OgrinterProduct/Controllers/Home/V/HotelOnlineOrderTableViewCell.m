//
//  HotelOnlineOrderTableViewCell.m
//  OgrinterProduct
//
//  Created by wongshine on 2020/1/18.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "HotelOnlineOrderTableViewCell.h"
#import "HotelOnlinesListModel.h"
#import "PaywayModel.h"

@interface HotelOnlineOrderTableViewCell()


@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *titleName;
@property (weak, nonatomic) IBOutlet UILabel *desc;
@property (weak, nonatomic) IBOutlet UILabel *cprice;


@property (weak, nonatomic) IBOutlet UIImageView *pIcon;
@property (weak, nonatomic) IBOutlet UILabel *pName;

@end


@implementation HotelOnlineOrderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


-(void)setTaday:(NSString *)taday{
    _taday = taday;
    for (UIButton *btn in self.contentView.subviews){
        if ([btn isKindOfClass:[UIButton class]]){
            UIButton *b = (UIButton *)btn;
            if ([b.titleLabel.text isEqualToString:taday]){
                b.selected = YES;
            }
        }
    }
}


- (IBAction)btnclictc:(UIButton *)sender {
    KPreventRepeatClickTime(0.4);
    HotelOnlineOrderTableViewCell *cell = (HotelOnlineOrderTableViewCell *)sender.superview.superview;
    for (UIButton *btn in cell.contentView.subviews){
        if ([btn isKindOfClass:[UIButton class]]){
            UIButton *b = (UIButton *)btn;
            if (b == sender) {
                b.selected = YES;
            }else{
                b.selected = NO;
            }
        }
    }
}


- (IBAction)selecttime:(UIButton *)sender {
    KPreventRepeatClickTime(0.4);
    [self.delegate selectDataker:sender];
}


- (IBAction)addclcik:(UIButton *)sender {
    [self.delegate selectDataker:sender];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setListmodel:(HotelOnlinesListModel *)listmodel{
    _listmodel = listmodel;
    
    [self.icon sd_setImageWithURL:[NSURL URLWithString:listmodel.image] placeholderImage:nil];
    self.titleName.text = listmodel.hname;
    self.desc.text = [NSString stringWithFormat:@"x%@",listmodel.munbert];
    CGFloat f = [listmodel.price floatValue]*[listmodel.munbert integerValue];
    
    
    self.cprice.text = [NSString stringWithFormat:@"￥%.2f",f];
}


-(void)setModellist:(PaywayModel *)modellist{
    _modellist = modellist;
    [self.pIcon sd_setImageWithURL:[NSURL URLWithString:modellist.logo] placeholderImage:nil];
    self.pName.text = modellist.pay_way;
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


- (IBAction)btnclick:(UIButton *)sender {
    KPreventRepeatClickTime(1);
    [self.delegate handleSelectedSelectedIndexPath:self.selectedIndexPath];
}




@end
