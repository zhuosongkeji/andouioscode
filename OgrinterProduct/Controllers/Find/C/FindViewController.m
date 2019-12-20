//
//  FindViewController.m
//  OgrinterProduct
//
//  Created by wongshine on 2019/11/28.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "FindViewController.h"
#import "iCarousel.h"

@interface FindViewController ()<iCarouselDelegate,iCarouselDataSource>

@property (nonatomic, strong) iCarousel *filmCarousel;
@property (nonatomic, strong) NSMutableArray *filmImageNameArr;
@property (nonatomic, strong) NSMutableArray *filmNameArr;
@property (nonatomic, strong) UIView *selectView;
@property (nonatomic, strong) UILabel *filmNameLab;

@end

@implementation FindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.filmCarousel];
    
    self.filmNameLab = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.filmCarousel.frame), self.view.frame.size.width, 44)];
    self.filmNameLab.font = [UIFont systemFontOfSize:20];
    self.filmNameLab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.filmNameLab];
    // Do any additional setup after loading the view from its nib.
}


#pragma mark - iCarouselDataSource
-(NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel{
    return self.filmImageNameArr.count;
}

-(UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view{
    
    UIImage *image = [UIImage imageNamed:[self.filmImageNameArr objectAtIndex:index]];
    if (view == nil) {
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 120, 140)];
        view.backgroundColor = [UIColor clearColor];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(2, 2, 116, 136)];
        imageView.tag = 1000+index;
        [view addSubview:imageView];
    }
    UIImageView *imageView = [view viewWithTag:1000+index];
    imageView.image = image;
    
    return view;
}


#pragma mark - iCarouselDelegate
- (void)carouselDidEndScrollingAnimation:(iCarousel *)carousel{
    NSLog(@"___1 %lu",carousel.currentItemIndex);
    UIView *view = carousel.currentItemView;
    view.backgroundColor = [UIColor whiteColor];
    self.selectView = view;
    self.filmNameLab.text = self.filmNameArr[carousel.currentItemIndex];
}

- (void)carouselDidScroll:(iCarousel *)carousel{
    NSLog(@"___2 %lu",carousel.currentItemIndex);
    if (self.selectView != carousel.currentItemView) {
        self.selectView.backgroundColor = [UIColor clearColor];
        UIView *view = carousel.currentItemView;
        view.backgroundColor = [UIColor whiteColor];
        
        self.filmNameLab.text = self.filmNameArr[carousel.currentItemIndex];
    }
}


- (void)carouselCurrentItemIndexDidChange:(iCarousel *)carousel{
    NSLog(@"___3 %lu",carousel.currentItemIndex);
    self.selectView = carousel.currentItemView;
}

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index{
    NSLog(@"点击了第%ld个",index);
}


-(CATransform3D)carousel:(iCarousel *)carousel itemTransformForOffset:(CGFloat)offset baseTransform:(CATransform3D)transform{
    
    static CGFloat max_sacle = 1.0f;
    static CGFloat min_scale = 0.6f;
    
    if (offset <= 1 && offset >= -1) {
        float tempScale = offset < 0 ? 1+offset : 1-offset;
        float slope = (max_sacle - min_scale) / 1;
        CGFloat scale = min_scale + slope * tempScale;
        transform = CATransform3DScale(transform, scale, scale, 1);
    }else{
        transform = CATransform3DScale(transform, min_scale, min_scale,1);
    }
    return CATransform3DTranslate(transform, offset *self.filmCarousel.itemWidth * 1.2, 0.0, 0.0);
    
}

#pragma mark - LazyLoad
-(iCarousel *)filmCarousel{
    if (_filmCarousel == nil) {
        _filmCarousel = [[iCarousel alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height / 2 - 100, KSCREEN_WIDTH, 150)];
        _filmCarousel.delegate = self;
        _filmCarousel.dataSource = self;
        _filmCarousel.backgroundColor = [UIColor lightGrayColor];
        _filmCarousel.bounces = YES;
        _filmCarousel.pagingEnabled = NO;
        _filmCarousel.type = iCarouselTypeRotary;
    }
    return _filmCarousel;
}

- (NSMutableArray *)filmImageNameArr{
    if (!_filmImageNameArr) {
        _filmImageNameArr = [NSMutableArray array];
        for (int i = 1; i< 15; i++) {
            [_filmImageNameArr addObject:[NSString stringWithFormat:@"1"]];
        }
    }
    return _filmImageNameArr;
}

- (NSMutableArray *)filmNameArr{
    if (!_filmNameArr) {
        _filmNameArr = [NSMutableArray array];
        for (int i = 1; i< 15; i++) {
            [_filmNameArr addObject:[NSString stringWithFormat:@"film %d",i]];
        }
    }
    return _filmNameArr;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
