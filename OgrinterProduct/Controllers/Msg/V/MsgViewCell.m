//
//  MsgViewCell.m
//  OgrinterProduct
//
//  Created by wongshine on 2019/12/5.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "MsgViewCell.h"
#import "MsgModel.h"

@interface MsgViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *shopImgView;

@property (weak, nonatomic) IBOutlet UILabel *shoptitleLabel;

@property (weak, nonatomic) IBOutlet UIView *shopScoreBjView;

@property (weak, nonatomic) IBOutlet UILabel *shopAddressLabel;

@property (weak, nonatomic) IBOutlet UILabel *shopPhoneLabel;

@property (weak, nonatomic) IBOutlet UIButton *thumbsBrn;//点赞个数

@end

@implementation MsgViewCell

//MARK:-
-(void)setListmodel:(MsgModel *)listmodel {
    _listmodel = listmodel;
}

//MARK:-点击查看商家
- (IBAction)clicktoLoock:(UIButton *)sender {
    KPreventRepeatClickTime(1)
    _selectBlock(sender);
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
