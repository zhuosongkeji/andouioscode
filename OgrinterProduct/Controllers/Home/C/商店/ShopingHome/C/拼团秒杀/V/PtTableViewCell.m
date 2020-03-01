//
//  PtTableViewCell.m
//  OgrinterProduct
//
//  Created by wongshine on 2020/2/28.
//  Copyright © 2020 RXF. All rights reserved.
//


#import "PtTableViewCell.h"
#import "KillerbListModel.h"
#import "OYCountDownManager.h"

@interface PtTableViewCell ()


@property (weak, nonatomic) IBOutlet UIButton *icon;

@property (weak, nonatomic) IBOutlet UIButton *icon1;

@property (weak, nonatomic) IBOutlet UILabel *title;

@property (weak, nonatomic) IBOutlet UILabel *desc;



@end


@implementation PtTableViewCell


-(void)setLlmodel:(KillerbListModel *)llmodel{
    _llmodel = llmodel;
    [self.icon sd_setBackgroundImageWithURL:[NSURL URLWithString:llmodel.captain_avatar] forState:0];
    self.title.text = [NSString stringWithFormat:@"还差%@成团",llmodel.left_member];
    
}


- (void)awakeFromNib {
    [super awakeFromNib];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(countDownNotification) name:OYCountDownNotification object:nil];
//    [kCountDownManager start];
    // Initialization code
}


-(void)setTStr:(NSString *)tStr{
    _tStr = tStr;
}


- (void)countDownNotification {
    /// 计算倒计时
    NSInteger countDown = [_tStr integerValue] - kCountDownManager.timeInterval;
    if (countDown <= 0) {
        // 倒计时结束时回调
        self.desc.text = @"活动已结束";
        return;
    }
    
    self.desc.text = [NSString stringWithFormat:@"倒计时:%02zd:%02zd:%02zd", countDown/3600,       (countDown/60)%60, countDown%60];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)dealloc{
    [kCountDownManager invalidate];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
