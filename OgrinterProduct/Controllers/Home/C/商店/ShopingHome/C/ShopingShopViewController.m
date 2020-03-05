//
//  ShopingShopViewController.m
//  OgrinterProduct
//
//  Created by wongshine on 2019/12/6.
//  Copyright © 2019 RXF. All rights reserved.
//


#import "ShopingShopViewController.h"
#import "CategoryShopDetailsViewController.h"
#import "SearchResrultViewController.h"
#import "ShopHomeViewCell.h"
#import "MDBannerModel.h"
#import "iCarousel.h"


@interface ShopingShopViewController ()<UITableViewDelegate,UITableViewDataSource,iCarouselDelegate,iCarouselDataSource>

//@property (weak, nonatomic) IBOutlet UITableView *leftTbleView;

@property (weak, nonatomic) IBOutlet UITableView *rigthTableView;
@property (nonatomic, strong) UIView *selectView;
@property (weak, nonatomic) IBOutlet UIView *sView;

//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lefttoTop;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *righttoTop;


@property(nonatomic,strong)NSArray *leftArr;
@property(nonatomic,strong)NSArray *rightArr;
@property (nonatomic,strong)UIButton *searchBtn;

@property (weak, nonatomic) IBOutlet UIView *iCarouselBJView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftTotop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightTotop;

@property (nonatomic,strong) iCarousel *icarousel;


@end


@implementation ShopingShopViewController


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}


//MARK:- iCarousel
-(iCarousel *)icarousel{
    if (_icarousel == nil) {
        _icarousel = [[iCarousel alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_HEIGHT-kStatusBarAndNavigationBarH-kStatuTabBarH-50, 128)];
        _icarousel.delegate = self;
        _icarousel.dataSource = self;
        _icarousel.bounces = YES;
        _icarousel.pagingEnabled = YES;
        _icarousel.clipsToBounds =YES;
        _icarousel.type = iCarouselTypeRotary;
    }
    return _icarousel;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.leftArr = @[@"玩具",@"娱乐",@"商品",@"电影",@"其他",@"玩具",@"娱乐",@"商品",@"电影",@"其他",@"玩具",@"娱乐",@"商品",@"电影"];
    
    [self setup];
    // Do any additional setup after loading the view from its nib.
}


-(void)setup{
    
    
    self.leftTotop.constant = kStatusBarAndNavigationBarH;
    self.rightTotop.constant = kStatusBarAndNavigationBarH;
    
//    self.leftTbleView.tableFooterView = [UILabel new];
    self.rigthTableView.tableFooterView = [UILabel new];
    
    [self.rigthTableView registerNib:[UINib nibWithNibName:@"ShopHomeViewCell" bundle:nil] forCellReuseIdentifier:@"ShopHomeViewCell"];

    [self.iCarouselBJView addSubview:self.icarousel];
    self.icarousel.transform = CGAffineTransformMakeRotation(M_PI_2);
    self.icarousel.centerY = self.iCarouselBJView.centerY/2+100;
    self.icarousel.centerX = self.iCarouselBJView.centerX/4-10;
    
}


#pragma mark - tableView 数据源代理方法 -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.leftArr count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
        
   ShopHomeViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShopHomeViewCell"];
    if (!cell) {
        NSLog(@"xhuangjian");
    }
    
    [cell setEnumtype:MyEnumValueB];
    cell.itemBlock = ^(NSInteger idex, NSIndexPath * _Nullable indexpath) {
        CategoryShopDetailsViewController *category = [[CategoryShopDetailsViewController alloc]init];
        [self.navigationController pushViewController:category animated:YES];
    };
    return cell;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (tableView == self.rigthTableView)
        return [NSString stringWithFormat:@"第 %ld 组", section];
    return nil;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 460;
}


//MARK: - 一个方法就能搞定 右边滑动时跟左边的联动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
//    if (scrollView == self.leftTbleView)
//        return;
//    NSIndexPath *topHeaderViewIndexpath = [[self.rigthTableView indexPathsForVisibleRows] firstObject];
//    NSIndexPath *moveToIndexpath = [NSIndexPath indexPathForRow:topHeaderViewIndexpath.section inSection:0];
//    [self.leftTbleView selectRowAtIndexPath:moveToIndexpath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
    
}


//MARK: - 点击 cell 的代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    if (tableView == self.leftTbleView) {
//        NSIndexPath *moveToIndexPath = [NSIndexPath indexPathForRow:0 inSection:indexPath.row];
//        [self.rigthTableView selectRowAtIndexPath:moveToIndexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
//        [self.rigthTableView deselectRowAtIndexPath:moveToIndexPath animated:YES];
//    }
}


//MARK:- iCarouselDataSource
-(NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel{
    return self.leftArr.count;
}

-(UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view{
    
    if ([self.leftArr count] > 0) {
//        HomeModel *model = self.imgOArr[index];
        
        if (view == nil) {
            
            view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 120, 140)];
            view.backgroundColor = [UIColor clearColor];
            
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(2, 2, 116, 136)];
            imageView.tag = 1000+index;
            [view addSubview:imageView];
        }
        UIImageView *imageView = [view viewWithTag:1000+index];
        [imageView setBackgroundColor:UIColor.redColor];
        
//        [imageView sd_setImageWithURL:[NSURL URLWithString:model.img] completed:nil];
        
        return view;
    }
    return nil;
}


#pragma mark - iCarouselDelegate
- (void)carouselDidEndScrollingAnimation:(iCarousel *)carousel{
    UIView *view = carousel.currentItemView;
    view.backgroundColor = [UIColor whiteColor];
    self.selectView = view;
    
    NSIndexPath *moveToIndexPath = [NSIndexPath indexPathForRow:0 inSection:carousel.currentItemIndex];
    
    [self.rigthTableView selectRowAtIndexPath:moveToIndexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
    [self.rigthTableView deselectRowAtIndexPath:moveToIndexPath animated:YES];
    //    self.filmNameLab.text = self.filmNameArr[carousel.currentItemIndex];
}


- (void)carouselDidScroll:(iCarousel *)carousel{
    //    NSLog(@"___2 %lu",carousel.currentItemIndex);
    if (self.selectView != carousel.currentItemView) {
        self.selectView.backgroundColor = [UIColor clearColor];
        UIView *view = carousel.currentItemView;
        view.backgroundColor = [UIColor whiteColor];
    }
}

- (void)carouselCurrentItemIndexDidChange:(iCarousel *)carousel{
    NSLog(@"___3 %lu",carousel.currentItemIndex);
    self.selectView = carousel.currentItemView;
}

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index{
    NSLog(@"点击了第%ld个",index);
    
    NSIndexPath *moveToIndexPath = [NSIndexPath indexPathForRow:0 inSection:index];
    [self.rigthTableView selectRowAtIndexPath:moveToIndexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
    [self.rigthTableView deselectRowAtIndexPath:moveToIndexPath animated:YES];
    
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
    return CATransform3DTranslate(transform, offset *self.icarousel.itemWidth * 1.2, 0.0, 0.0);
    
}



////MARK:- searchaction
//-(void)searchaction {
//    SearchResrultViewController *result = [[SearchResrultViewController alloc]init];
//    result.type = SearchCollectionViewtypeTwo;
//    [self.navigationController pushViewController:result animated:YES];
//}


//-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    if (tableView == self.rigthTableView) {
//        return [self.leftArr objectAtIndex:section];
//    }
//    return nil;
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
