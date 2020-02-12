//
//  MsgViewCell.m
//  OgrinterProduct
//
//  Created by wongshine on 2019/12/5.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "MsgViewCell.h"
#import "MsgModel.h"
#import "ZBNBrowseModel.h"
#import "ZBNShopFollowModel.h"

@interface MsgViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *shopImgView;

@property (weak, nonatomic) IBOutlet UILabel *shoptitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *shopAddressLabel;

@property (weak, nonatomic) IBOutlet UILabel *shopPhoneLabel;

@property (weak, nonatomic) IBOutlet UIButton *thumbsBrn;//点赞个数

@property (weak, nonatomic) IBOutlet UIView *sharbjView;

@property (weak, nonatomic) IBOutlet UIButton *lockbtn;


@end

@implementation MsgViewCell

//MARK:-
-(void)setListmodel:(MsgModel *)listmodel {
    _listmodel = listmodel;
    
    [self.lockbtn setHidden:YES];
    [self.shopImgView sd_setImageWithURL:[NSURL URLWithString:listmodel.logo_img] placeholderImage:nil];
    self.shoptitleLabel.text = listmodel.name;
    self.shopAddressLabel.text = listmodel.address;
    self.shopPhoneLabel.text = listmodel.tel;
    [self.thumbsBrn setTitle:[NSString stringWithFormat:@"   %@",listmodel.praise_num] forState:0];
    
    [self setupStar:listmodel.stars_all];
    
}

- (void)setBrowseM:(ZBNBrowseModel *)browseM
{
    _browseM = browseM;
    
    [self.lockbtn setHidden:YES];
    [self.shopImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",imgServer,browseM.logo_img]]];
       self.shoptitleLabel.text = browseM.name;
       self.shopAddressLabel.text = browseM.address;
       self.shopPhoneLabel.text = browseM.tel;
       [self.thumbsBrn setTitle:[NSString stringWithFormat:@"   %@",browseM.praise_num] forState:0];
       
       [self setupStar:browseM.stars_all];
}

- (void)setShopM:(ZBNShopFollowModel *)shopM
{
    _shopM = shopM;
    [self.lockbtn setHidden:YES];
       [self.shopImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",imgServer,shopM.logo_img]]];
          self.shoptitleLabel.text = shopM.name;
          self.shopAddressLabel.text = shopM.address;
          self.shopPhoneLabel.text = shopM.tel;
          [self.thumbsBrn setTitle:[NSString stringWithFormat:@"   %@",shopM.praise_num] forState:0];
          
          [self setupStar:shopM.stars_all];
}

//MARK:-点击查看商家
- (IBAction)clicktoLoock:(UIButton *)sender {
    KPreventRepeatClickTime(1)
    _selectBlock(sender);
}



- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.lockbtn.layer.cornerRadius = 4;
//    [self setupStar];
    // Initialization code
}


-(void)setupStar:(NSString *)stars_all {
    
    for (UIImageView *imgV in self.sharbjView.subviews) {
        if ([imgV isKindOfClass:[UIImageView class]]) {
            [imgV removeFromSuperview];
        }
    }
    
    for (int i = 0; i < [stars_all integerValue]; i ++) {
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(8+i*17,3,12,12)];
        imgView.image = [UIImage imageNamed:@"start"];
        [self.sharbjView addSubview:imgView];
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
