//
//  HotelDetilsTopViewCell.m
//  OgrinterProduct
//
//  Created by wongshine on 2019/12/9.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "HotelDetilsTopViewCell.h"
#import "HolelModel.h"


@interface HotelDetilsTopViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIButton *dznum;
@property (weak, nonatomic) IBOutlet UILabel *phone;
@property (weak, nonatomic) IBOutlet UILabel *shoper;
@property (weak, nonatomic) IBOutlet UIView *starbjView;

@property (weak, nonatomic) IBOutlet UILabel *address;

@end

@implementation HotelDetilsTopViewCell


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


-(void)setListModel:(HolelModel *)listModel{
    _listModel = listModel;
    
    self.address.text = listModel.address;
    self.title.text = listModel.name;
    
    self.phone.text = listModel.tel;
    
    [self setupStar:[listModel.praise_num integerValue]];
    
}


-(void)setupStar:(NSInteger)num {
    
    for (UIImageView *img in self.starbjView.subviews ) {
        if ([img isKindOfClass:[UIImageView class]]) {
            [img removeFromSuperview];
        }
    }
    
    for (int i = 0; i < num; i ++) {
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(KSCREEN_WIDTH-114+i*17,16,12,12)];
        imgView.image = [UIImage imageNamed:@"start"];
        
        [self.starbjView addSubview:imgView];
    }
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
