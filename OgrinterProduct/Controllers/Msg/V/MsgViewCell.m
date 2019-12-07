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
}


//MARK:-点击查看商家
- (IBAction)clicktoLoock:(UIButton *)sender {
    KPreventRepeatClickTime(1)
    _selectBlock(sender);
}



- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.lockbtn.layer.cornerRadius = 4;
    [self setupStar];
    // Initialization code
}


-(void)setupStar {
    
    for (int i = 0; i < 5; i ++) {
        
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(8+i*17,3,12,12)];
        imgView.image = [UIImage imageNamed:@"形状 3 拷贝 4"];
        
        [self.sharbjView addSubview:imgView];
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
