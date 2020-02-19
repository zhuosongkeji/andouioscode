//
//  ShoperHeadView.m
//  OgrinterProduct
//
//  Created by wongshine on 2020/1/9.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ShoperHeadView.h"
#import "MDShockBannerView.h"

@interface ShoperHeadView()

@property (weak, nonatomic) IBOutlet UIView *headbjView;

@property (nonatomic,strong) MDShockBannerView *bannerView;


@end

@implementation ShoperHeadView


//MARK:- MDShockBannerView
-(MDShockBannerView *)bannerView {
    if (!_bannerView) {
        _bannerView = [[MDShockBannerView alloc]initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, bannerH)];
        _bannerView.pageSelectImage = [UIImage imageNamed:@"dati2"];
        _bannerView.pageUnselectImage = [UIImage imageNamed:@"dati1"];
        _bannerView.banners = _banArr;
    }
    return _bannerView;
}

-(void)awakeFromNib{
    [super awakeFromNib];
}


-(void)setBanArr:(NSArray *)banArr{
    _banArr = banArr;
    
    [self.headbjView addSubview:self.bannerView];
}

-(void)setup{
    
}

- (IBAction)btnclick:(UIButton *)sender {
    _ptmsBlock(sender.tag);
//    [HUDManager showTextHud:OtherMsg];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
