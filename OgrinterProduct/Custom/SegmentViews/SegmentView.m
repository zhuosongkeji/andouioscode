//
//  SegmentView.m
//
//

#import "SegmentView.h"
//#import "UIImage+Fit.h"

@interface MyButton: UIButton

@end

@implementation MyButton

- (void)setHighlighted:(BOOL)highlighted{}

@end

@interface SegmentView() {
    UIButton *fristbtn;
    
}

@property (nonatomic,strong)NSDictionary *dict;

@end

@implementation SegmentView

- (id)initWithTitles:(NSArray *)titles {
    
    CGRect frame= CGRectMake(0, 0, KSCREEN_WIDTH, kStatuTabBarH);
    if (self = [super initWithFrame:frame]) {
        
        self.dict = @{@"Normal":@[@"图层 44 拷贝",@"搜索类目 拷贝",@"cart 拷贝",@"图层 45"],@"select":@[@"图层 44",@"搜索类目",@"cart",@"图层 45 拷贝"]};
        self.titles = titles;
        self.tag = 100;
        self.layer.borderWidth = 0.4;
        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.backgroundColor = KSRGBA(255, 255, 255, 1);
    }
    return self;
}

- (void)btnDown:(UIButton *)btn {
    
    if (btn == fristbtn) return;
    fristbtn.selected = NO;
    btn.selected = YES;
    fristbtn = btn;

    // 通知代理
    if ([self.delegate respondsToSelector:@selector(segmentView:didSelectedSegmentAtIndex:)]) {
        [self.delegate segmentView:self didSelectedSegmentAtIndex:btn.tag];
    }
}


-(void)segemtBtnChange:(int)index {
    UIButton *btn=(UIButton *)[self viewWithTag:index];
    if (btn == fristbtn) return;
    fristbtn.selected = NO;
    btn.selected = YES;
    fristbtn = btn;
    
}



- (void)setTitles:(NSArray *)titles {
    // 数组内容一致，直接返回
    if ([titles isEqualToArray:_titles]) return;
    _titles = titles;
    // 1.移除所有的按钮
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    // 2.添加新的按钮
    NSInteger count = titles.count;
    
    for (int i = 0; i<count; i++) {
        MyButton *btn = [MyButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        CGFloat btnW = (KSCREEN_WIDTH-4*(44))/5;
        // 设置按钮的frame
        btn.frame = CGRectMake(btnW+i * (44+btnW), 5, 44, 44);
        // 设置文字
        // btn.adjustsImageWhenHighlighted = NO;
        btn.titleLabel.font = [UIFont systemFontOfSize:10];
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        [btn setTitleColor:KSDUAULTCOLORE forState:UIControlStateSelected];
        [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:[self.dict[@"Normal"]objectAtIndex:i]] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:[self.dict[@"select"]objectAtIndex:i]] forState:UIControlStateSelected];
        [self buttonEdgeInsets:btn];
        
        
        // 设置监听器
        [btn addTarget:self action:@selector(btnDown:) forControlEvents:UIControlEventTouchDown];
        // 设置选中
        if (i == 0) {
            [self btnDown:btn];
        }
        // 添加按钮
        [self addSubview:btn];
    }
    
    self.bounds = CGRectMake(0, 0, KSCREEN_WIDTH, kStatuTabBarH);
    
}

-(void)buttonEdgeInsets:(UIButton *)button{
    
    CGFloat imageWidth = button.imageView.frame.size.width;
    CGFloat imageHeight = button.imageView.frame.size.height;
    //    self.imageView.backgroundColor = [UIColor blackColor];
    //    self.titleLabel.backgroundColor = [UIColor redColor];
    CGFloat labelWidth = 0.0;
    CGFloat labelHeight = 0.0;
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        // 由于iOS8中titleLabel的size为0，用下面的这种设置
        labelWidth = button.titleLabel.intrinsicContentSize.width;
        labelHeight = button.titleLabel.intrinsicContentSize.height;
    } else {
        labelWidth = button.titleLabel.frame.size.width;
        labelHeight = button.titleLabel.frame.size.height;
    }
    
    [button setTitleEdgeInsets:UIEdgeInsetsMake(8.0, -imageWidth, -imageHeight-12/2.0, 0)];
    [button setImageEdgeInsets:UIEdgeInsetsMake(-labelHeight-12/2.0, 0, 0, -labelWidth)];
    
}


@end
