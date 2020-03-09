//
//  ZBNPostBarNewsCell.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/3/7.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNPostBarNewsCell.h"
#import "ZBNMyAllNewsModel.h"
#import "EVRElasticViewReference.h"

@interface ZBNPostBarNewsCell () <EVRElasticViewReferenceDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageIcon;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (nonatomic, strong) EVRElasticViewReference *reference;
@property (nonatomic, strong) UILabel *contentLabel;
@end

@implementation ZBNPostBarNewsCell

- (void)setModel:(ZBNMyAllNewsModel *)model
{
    _model = model;
    // 收到赞 3
    // 收到评论 4
    // 收到回复 5
    if (model.ID.intValue == 3) {
           self.imageIcon.image = [UIImage imageNamed:@"赞 18"];
       }
    if (model.ID.intValue == 4) {
           self.imageIcon.image = [UIImage imageNamed:@"评论 19"];
       }
    if (model.ID.intValue == 5) {
              self.imageIcon.image = [UIImage imageNamed:@"回复 (1)"];
          }
    self.name.text = model.type_name;
    self.contentLabel.text = model.unread;
    if ([model.unread isEqualToString:@"0"]) {
        self.contentLabel.hidden = YES;
    } else {
        self.contentLabel.hidden = NO;
    }
}


- (void)awakeFromNib
{
    [super awakeFromNib];
    // 设置界面
    [self setupUI];
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.contentLabel.frame = CGRectMake(0, 0, 20, 20);
    self.contentLabel.centerX = self.contentView.width - 50;
    self.contentLabel.centerY = self.contentView.height * 0.5;
}


/*! 注册cell */
+ (instancetype)regiserCellForTable:(UITableView *)tableView
{
    static NSString * const ZBNPostBarNewsCellID = @"ZBNPostBarNewsCellID";
    ZBNPostBarNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:ZBNPostBarNewsCellID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ZBNPostBarNewsCell" owner:nil options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}


- (void)setupUI
{
    self.contentLabel = [UILabel new];
    self.contentLabel.font = [UIFont systemFontOfSize:14];
    self.contentLabel.textColor = [UIColor whiteColor];
    self.contentLabel.backgroundColor = [UIColor redColor];
    self.contentLabel.textAlignment = NSTextAlignmentCenter;
    self.contentLabel.layer.cornerRadius = 10.f;
    self.contentLabel.layer.masksToBounds = YES;
    [self.contentView addSubview:self.contentLabel];
    
    self.reference = [EVRElasticViewReference referenceWithReferencedView:self.contentLabel delegate:self];
    self.reference.allowTapping = YES;
    self.reference.allowDragging = YES;
}

- (void)setFrame:(CGRect)frame
{
    frame.size.height -= 0.5;
    [super setFrame:frame];
}

#pragma mark -- delegate

- (BOOL)elasticViewReference:(EVRElasticViewReference *)reference allowDampingWithLocation:(CGPoint)location translation:(CGPoint)translation velocity:(CGPoint)velocity;{
    return sqrt((pow(translation.x, 2) + pow(translation.y, 2))) < 100;
}

- (BOOL)elasticViewReference:(EVRElasticViewReference *)reference allowCompleteWithLocation:(CGPoint)location translation:(CGPoint)translation velocity:(CGPoint)velocity;{
    return sqrt((pow(translation.x, 2) + pow(translation.y, 2))) > 200;
}

- (CGFloat)elasticViewReference:(EVRElasticViewReference *)reference completedAnimationDurationWithLocation:(CGPoint)location translation:(CGPoint)translation velocity:(CGPoint)velocity;{
    return .2f;
}

- (CALayer *)elasticViewReference:(EVRElasticViewReference *)reference completedAnimationLayerWithLocation:(CGPoint)location translation:(CGPoint)translation velocity:(CGPoint)velocity;{
    UIImage *image = [UIImage imageNamed:@"bomb"];
    CGSize size = self.contentLabel.bounds.size;
    
    CAEmitterCell *emitterCell = [CAEmitterCell new];
    emitterCell.scale = .5f;
    emitterCell.lifetime = 5.f;
    emitterCell.velocity = 10;
    emitterCell.birthRate = 10;
    emitterCell.alphaSpeed = -0.4;
    emitterCell.emissionRange = M_PI * 2.0;
    emitterCell.color = [[reference tintColor] CGColor];
    emitterCell.contents = (__bridge id)[image CGImage];

    CAEmitterLayer *emitterLayer = [CAEmitterLayer layer];
    emitterLayer.frame = (CGRect){0, 0, size};
    emitterLayer.renderMode = kCAEmitterLayerAdditive;
    
    emitterLayer.emitterPosition = location;
    emitterLayer.emitterSize = CGSizeMake(size.width / 2., size.height / 2.);
    
    emitterLayer.emitterCells = @[emitterCell];
    
    return emitterLayer;
}

- (void)elasticViewReference:(EVRElasticViewReference *)reference didUpdateState:(EVRElasticViewReferenceState)state;{
    switch (state) {
        case EVRElasticViewReferenceStateBegin: NSLog(@"state update: begin"); break;
        case EVRElasticViewReferenceStateMoving: NSLog(@"state update: moving"); break;
        case EVRElasticViewReferenceStateCompleted: NSLog(@"state update: complete"); break;
        case EVRElasticViewReferenceStateCancel: NSLog(@"state update: cancel"); break;
        case EVRElasticViewReferenceStateNone: NSLog(@"state update: none"); break;
        default: break;
    }
    
    if (state == EVRElasticViewReferenceStateCompleted) {
        self.contentLabel.hidden = YES;
        NSLog(@"ahhahahaha341");
    }
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag;{
    NSLog(@"hahahahah");
}



@end
