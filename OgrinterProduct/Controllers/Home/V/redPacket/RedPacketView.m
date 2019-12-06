//
//  RedPacketView.m
//  OgrinterProduct
//
//  Created by wongshine on 2019/12/4.
//  Copyright © 2019 RXF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "RedPacketView.h"

#define ViewScaleIphone5Value    ([UIScreen mainScreen].bounds.size.width/320.0f)

#if __IPHONE_OS_VERSION_MAX_ALLOWED < 100000
@interface RedPacketView ()<UIGestureRecognizerDelegate>
#else
@interface RedPacketView ()<CAAnimationDelegate,UIGestureRecognizerDelegate>
#endif

@property (nonatomic,strong) UIWindow    *alertWindow;
@property (nonatomic,strong) UIImageView *backgroundImageView;
@property (nonatomic,strong) PacketModel *data;
//@property (nonatomic,strong) UIImageView *avatarImageView;

@property (nonatomic,strong) UILabel *userNameLabel;
@property (nonatomic,strong) UILabel *tipsLabel;
@property (nonatomic,strong) UILabel *messageLabel;
@property (nonatomic,strong) UILabel *otherLabel;
@property (nonatomic,strong) UIButton *openButton;
@property (nonatomic,strong) UIButton *closeButton;

@property (nonatomic,copy) cancelBlock    cancelBlock;
@property (nonatomic,copy) finishBlock    finishBlock;

@end

@implementation RedPacketView


+(instancetype)ShowRedpacketWithData:(PacketModel *)data cancelBlock:(cancelBlock)cancelBlock finishBlock:(finishBlock)finishBlock {
    RedPacketView *packet = [[self alloc] initRedPackerWithData:data cancelBlock:cancelBlock finishBlock:finishBlock];
    return packet;
}


-(instancetype)initRedPackerWithData:(PacketModel *)data
                         cancelBlock:(cancelBlock)cancelBlock
                         finishBlock:(finishBlock)finishBlock{
    if (self = [super init]) {
        
        _data = data;
        [self.alertWindow addSubview:self.view];
        [self.alertWindow addSubview:self.backgroundImageView];
        self.cancelBlock = cancelBlock;
        self.finishBlock = finishBlock;
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeViewAction)];
        tapGesture.delegate = self;
        [self.view addGestureRecognizer:tapGesture];
    }
    
    return self;
}

//MARK:-alertWindow
- (UIWindow *)alertWindow
{
    if (!_alertWindow) {
        _alertWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _alertWindow.windowLevel = UIWindowLevelAlert;
        _alertWindow.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];
        [_alertWindow makeKeyAndVisible];
        _alertWindow.rootViewController = self;
    }
    return _alertWindow;
}


- (UIImageView *)backgroundImageView
{
    if (!_backgroundImageView) {
        
        UIImage *image =  [UIImage imageNamed:@"redpacket_bg"];
        
        CGFloat width = KSCREEN_WIDTH - 50 * ViewScaleIphone5Value;
        CGFloat height = width * (image.size.height / image.size.width);
        _backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(25 * ViewScaleIphone5Value, KSCREEN_HEIGHT / 2 - height / 2, width, height)];
        _backgroundImageView.image = image;
        
        [_backgroundImageView addSubview:self.openButton];
        [_backgroundImageView addSubview:self.closeButton];
        [_backgroundImageView addSubview:self.userNameLabel];
        [_backgroundImageView addSubview:self.tipsLabel];
        [_backgroundImageView addSubview:self.messageLabel];
        [_backgroundImageView addSubview:self.otherLabel];
        
        self.backgroundImageView.transform = CGAffineTransformMakeScale(0.05, 0.05);
        
        [UIView animateWithDuration:.15
                         animations:^{
                             self.backgroundImageView.transform = CGAffineTransformMakeScale(1.05, 1.05);
                         }completion:^(BOOL finish){
                             [UIView animateWithDuration:.15
                                              animations:^{
                                                  self.backgroundImageView.transform = CGAffineTransformMakeScale(0.95, 0.95);
                                              }completion:^(BOOL finish){
                                                  [UIView animateWithDuration:.15
                                                                   animations:^{
                                                                       self.backgroundImageView.transform = CGAffineTransformMakeScale(1, 1);
                                                                   }];
                                              }];
                         }];
    }
    return _backgroundImageView;
}

- (UIButton *)openButton
{
    if (!_openButton) {
        
        CGFloat widthOrHeight = 100 * ViewScaleIphone5Value;
        
        _openButton = [[UIButton alloc]initWithFrame:CGRectMake(_backgroundImageView.frame.size.width/2 - widthOrHeight/2, _backgroundImageView.frame.size.height/2 , widthOrHeight,widthOrHeight)];
        [_openButton setImage:[UIImage imageNamed:@"redpacket_open_btn"] forState:UIControlStateNormal];
        
    }
    return _openButton;
}

- (UIButton *)closeButton
{
    if (!_closeButton) {
        _closeButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
        [_closeButton setImage:[UIImage imageNamed:@"close_btn"] forState:UIControlStateNormal];
    }
    return _closeButton;
}

//- (UIImageView *)avatarImageView
//{
//    if (!_avatarImageView) {
//        _avatarImageView = [[UIImageView alloc]initWithFrame:CGRectMake(_backgroundImageView.frame.size.width/2 - 24, 35, 48, 48)];
//        _avatarImageView.clipsToBounds = YES;
//        _avatarImageView.layer.cornerRadius = 3;
//        _avatarImageView.layer.borderWidth = 1;
//        _avatarImageView.layer.borderColor = [UIColor whiteColor].CGColor;
//        [_avatarImageView setImage:_data.avatarImage];
//    }
//    return _avatarImageView;
//}

- (UILabel *)userNameLabel
{
    if (!_userNameLabel) {
        _userNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 44, _backgroundImageView.frame.size.width - 40, 20)];
        _userNameLabel.textColor = KSRGBA(255, 255, 255, 1);
        _userNameLabel.font = [UIFont systemFontOfSize:14];
        _userNameLabel.text = redPacketMsg;
        _userNameLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _userNameLabel;
}

- (UILabel *)tipsLabel
{
    if (!_tipsLabel) {
        _tipsLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, _userNameLabel.frame.size.height + _userNameLabel.frame.origin.y + 20, _backgroundImageView.frame.size.width - 40, 15)];
        _tipsLabel.textColor = KSRGBA(255, 255, 255, 2);;
        _tipsLabel.font = [UIFont systemFontOfSize:26];
        _tipsLabel.text = openPacket;
        _tipsLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _tipsLabel;
}


- (UILabel *)messageLabel {
    
    if (!_messageLabel) {
        _messageLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, _tipsLabel.frame.size.height + _tipsLabel.frame.origin.y + 30 * ViewScaleIphone5Value, _backgroundImageView.frame.size.width - 40, 27 * ViewScaleIphone5Value)];
        _messageLabel.textColor = KSRGBA(255, 255, 255, 2);
        _messageLabel.font = [UIFont systemFontOfSize:36];
        _messageLabel.text = _data.content;
        _messageLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _messageLabel;
}


-(UILabel *)otherLabel{
    if (!_otherLabel) {
        _otherLabel = [[UILabel alloc]initWithFrame:CGRectMake(20,CGRectGetMaxY(_openButton.frame)+44 , _backgroundImageView.frame.size.width - 40, 20)];
        _otherLabel.textColor = KSRGBA(255, 255, 255, 2);
        _otherLabel.font = [UIFont systemFontOfSize:14];
        _otherLabel.text = Explain;
        _otherLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _otherLabel;
}


- (void)closeViewAction {
    
    [UIView animateWithDuration:.2 animations:^{
        self.backgroundImageView.transform = CGAffineTransformMakeScale(0.2, 0.2);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:.08
                         animations:^{
                             self.backgroundImageView.transform = CGAffineTransformMakeScale(0.25, 0.25);
                         }completion:^(BOOL finish){
                             [self.alertWindow removeFromSuperview];
                             self.alertWindow.rootViewController = nil;
                             self.alertWindow = nil;
                             
                             if (self.cancelBlock) {
                                 self.cancelBlock();
                             }
                             
                         }];
    }];
    
}


- (void)openRedPacketAction
{
    [_openButton.layer addAnimation:[self confirmViewRotateInfo] forKey:@"transform"];
}

- (CAKeyframeAnimation *)confirmViewRotateInfo
{
    CAKeyframeAnimation *theAnimation = [CAKeyframeAnimation animation];
    
    theAnimation.values = [NSArray arrayWithObjects:
                           [NSValue valueWithCATransform3D:CATransform3DMakeRotation(0, 0, 0.5, 0)],
                           [NSValue valueWithCATransform3D:CATransform3DMakeRotation(3.13, 0, 0.5, 0)],
                           [NSValue valueWithCATransform3D:CATransform3DMakeRotation(6.28, 0, 0.5, 0)],
                           nil];
    
    
    theAnimation.cumulative = YES;
    theAnimation.duration = .6;
    theAnimation.repeatCount = 3;
    theAnimation.removedOnCompletion = YES;
    theAnimation.fillMode = kCAFillModeForwards;
    theAnimation.delegate = self;
    
    return theAnimation;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
       shouldReceiveTouch:(UITouch *)touch {
    
    if ([_openButton pointInside:[touch locationInView:_openButton] withEvent:nil]) {
        
        [self openRedPacketAction];
        
        return NO;
    }
    
    if ([_closeButton pointInside:[touch locationInView:_closeButton] withEvent:nil]) {
        
        [self closeViewAction];
        
        return NO;
    }
    
    return (![_backgroundImageView pointInside:[touch locationInView:_backgroundImageView] withEvent:nil]);
}


- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (self.finishBlock) {
        self.finishBlock(_data.money);
    }
    _messageLabel.text = [NSString stringWithFormat:@"中奖金额%.2f",_data.money];
}

- (void)dealloc
{
    NSLog(@"dealloc");
}

//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view.
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
