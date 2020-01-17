//
//  HolteOnlineSubViewTableViewCell.m
//  OgrinterProduct
//
//  Created by wongshine on 2020/1/17.
//  Copyright © 2020 RXF. All rights reserved.
//


#import "HolteOnlineSubViewTableViewCell.h"
#import "HotelOnlinesListModel.h"


@interface HolteOnlineSubViewTableViewCell(){
    
    NSInteger number;
}
@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *desc;
@property (weak, nonatomic) IBOutlet UILabel *price;


@end


@implementation HolteOnlineSubViewTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    number = 0;
    // Initialization code
}


-(void)setListmodel:(HotelOnlinesListModel *)listmodel{
    _listmodel = listmodel;
    
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:listmodel.image] placeholderImage:nil];
    
    self.title.text = listmodel.hname;
    self.desc.text = listmodel.remark;
    self.price.text = [NSString stringWithFormat:@"￥：%@",listmodel.price];
    
    if (!listmodel.munbert)
        self.numberlabel.text = @"0";
    else
        self.numberlabel.text = listmodel.munbert;
    
}


+ (instancetype)tempTableViewCellWith:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath{
    
    
    NSString *identifier = @"HolteOnlineSubViewTableViewCell";
    NSInteger index = 0;
    
    HolteOnlineSubViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HolteOnlineSubViewTableViewCell" owner:self options:nil] objectAtIndex:index];
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
    
}


- (IBAction)addclick:(UIButton *)sender {
    KPreventRepeatClickTime(.3)
   _clickBlock(sender.tag,sender);
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}


@end
