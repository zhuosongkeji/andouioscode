//
//  HotelOnlineTableViewCell.m
//  OgrinterProduct
//
//  Created by wongshine on 2020/1/17.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "HotelOnlineTableViewCell.h"
#import "OnlineOrderModel.h"
#import "UIButton+Ex.h"


@interface HotelOnlineTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *title;

@property (weak, nonatomic) IBOutlet UIView *starbjView;

@property (weak, nonatomic) IBOutlet UIButton *status;


@property (weak, nonatomic) IBOutlet UILabel *desct;

@property (weak, nonatomic) IBOutlet UILabel *time;



@end

@implementation HotelOnlineTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


-(void)setListmodel:(OnlineOrderModel *)listmodel{
    self.title.text = listmodel.name;
    
    if ([listmodel.status integerValue] == 0) {
        [self.status setSelected:NO];
    }else{
        [self.status setSelected:YES];
    }
    
    self.desct.text = [NSString stringWithFormat:@"商家地址：%@",listmodel.address];
    self.time.text = [NSString stringWithFormat:@"营业时间: %@-%@",listmodel.business_start,listmodel.business_end];
    
    [self setupStar:listmodel.stars_all];
}


+ (instancetype)tempTableViewCellWith:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath{
    
    
    NSString *identifier = @"";
    NSInteger index = 0;
    switch (indexPath.row ) {
        case 0:
            identifier = @"HotelOnlineTableViewCellOne";
            index = 0;
            break;
        case 1:
            identifier = @"HotelOnlineTableViewCellTwo";
            index = 1;
            break;
        case 2:
            identifier = @"HotelOnlineTableViewCellThird";
            index = 2;
            break;
        default:
            break;
    }
    
    HotelOnlineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HotelOnlineTableViewCell" owner:self options:nil] objectAtIndex:index];
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


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setupStar:(NSString *)num {
    for (int i = 0; i < [num integerValue]; i ++) {
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(16+i*17,3,12,12)];
        imgView.image = [UIImage imageNamed:@"start"];
        [self.starbjView addSubview:imgView];
    }
}


- (IBAction)guanzClick:(UIButton *)sender {
    _btnclickBlock(sender.tag);
}


- (IBAction)secondcellbtn:(UIButton *)sender {
    
    _btnclickBlock(sender.tag);
}



@end
