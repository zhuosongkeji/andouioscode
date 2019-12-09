//
//  CustomBarViewController.m
//  OgrinterProduct
//
//  Created by wongshine on 2019/11/28.
//  Copyright © 2019 RXF. All rights reserved.
//


#import "CustomBarViewController.h"
#import "HomeViewController.h"
#import "MsgViewController.h"
#import "FindViewController.h"
#import "MineViewController.h"
//#import "ShopingHomeViewController.h"
//#import "ShopingCategoryViewController.h"
//#import "ShoingMsgViewController.h"
//#import "ShoingMineViewController.h"
#import <CoreLocation/CoreLocation.h>


#import "CustomBar.h"


@interface CustomBarViewController ()<CLLocationManagerDelegate>

@property (nonatomic,strong)HomeViewController *hvc;
@property (nonatomic, strong) CLLocationManager* locationManager;

@end

@implementation CustomBarViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}


-(instancetype)initFrame:(CustomBarType)type {
    
    self = [super init];
    
    if (self) {
        
        if (type == CustomBarTypeOne) {
            [self loadsubControlOne];
            [self initloction];
        }else if (type == CustomBarTypeTwo){
            [self loadsubControlTwo];
            
        }else{}
        
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}


-(void)loadsubControlOne {
    
    self.hvc = [[HomeViewController alloc] init];
    [self addChildController:self.hvc title:@"首页" imageName:@"图层 730 拷贝" selectedImageName:@"图层 730" navVc:[UINavigationController class]];
    
    MsgViewController *fvc = [[MsgViewController alloc] init];
    [self addChildController:fvc title:@"商家" imageName:@"Bar chart" selectedImageName:@"Bar chart 拷贝" navVc:[UINavigationController class]];
    
    FindViewController *MoreVc = [[FindViewController alloc] init];
    [self addChildController:MoreVc title:@"贴吧" imageName:@"图层 507" selectedImageName:@"图层 507 拷贝" navVc:[UINavigationController class]];
    
    MineViewController *svc = [[MineViewController alloc] init];
    [self addChildController:svc title:@"我的" imageName:@"图层 510" selectedImageName:@"图层 510 拷贝" navVc:[UINavigationController class]];
    
    [[UITabBar appearance] setBackgroundImage:[NSObject imageWithColor:[UIColor whiteColor]]];
    //  设置tabbar
    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
    
    [self setCustomtabbar];
}


-(void)loadsubControlTwo {
    
//    ShopingHomeViewController *hvc = [[ShopingHomeViewController alloc] init];
//    [self addChildController:hvc title:@"商城" imageName:@"tab1-heartshow" selectedImageName:@"tab1-heart" navVc:[UINavigationController class]];
//
//    ShopingCategoryViewController *fvc = [[ShopingCategoryViewController alloc] init];
//    [self addChildController:fvc title:@"分类" imageName:@"tab2-doctor" selectedImageName:@"tab2-doctorshow" navVc:[UINavigationController class]];
//
//    MsgViewController *MoreVc = [[MsgViewController alloc] init];
//    [self addChildController:MoreVc title:@"收藏" imageName:@"tab4-more" selectedImageName:@"tab4-moreshow" navVc:[UINavigationController class]];
//
//    MineViewController *svc = [[MineViewController alloc] init];
//    [self addChildController:svc title:@"消息" imageName:@"tab5-file" selectedImageName:@"tab5-fileshow" navVc:[UINavigationController class]];
//
//    [[UITabBar appearance] setBackgroundImage:[self imageWithColor:[UIColor whiteColor]]];
//    //  设置tabbar
//    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
    
//    [self setCustomtabbar];
}


//MARK:- setCustomtabbar
- (void)setCustomtabbar {
    
    CustomBar *tabbar = [[CustomBar alloc]init];
    [self setValue:tabbar forKeyPath:@"tabBar"];
    [tabbar.midbtn addTarget:self action:@selector(centerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}

//MARK:- 中间按钮点击事件
- (void)centerBtnClick:(UIButton *)btn{
    KPreventRepeatClickTime(1)
    [HUDManager showTextHud:OtherMsg];
}


//MARK:-addChildController
- (void)addChildController:(UIViewController*)childController title:(NSString*)title imageName:(NSString*)imageName selectedImageName:(NSString*)selectedImageName navVc:(Class)navVc
{
    
    childController.title = title;
    childController.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childController.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    // 设置一下选中tabbar文字颜色
    
    [[UITabBar appearance] setTintColor:KSDUAULTCOLORE];
    
    UINavigationController* nav = [[navVc alloc] initWithRootViewController:childController];
    UIColor* color = [UIColor whiteColor];
    
    NSDictionary* dict = [NSDictionary dictionaryWithObject:color forKey:NSForegroundColorAttributeName];
    nav.navigationBar.titleTextAttributes= dict;
    
    [nav.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav"] forBarMetrics:UIBarMetricsDefault];
    
    [self addChildViewController:nav];
}



//-(UIImage*)convertViewToImage {
//
//    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0,0, KSCREEN_WIDTH,64)];
//    backView.backgroundColor = KSRGBA(98, 205, 173, 1);
////    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
////
////    gradientLayer.colors = @[(__bridge id)KSRGBA(98, 205, 173, 1).CGColor, (__bridge id)KSRGBA(102, 209, 177, 1).CGColor, (__bridge id)KSRGBA(106, 213, 181, 1).CGColor];
////
////    gradientLayer.locations = @[@0.3, @0.5, @0.7];gradientLayer.startPoint =  CGPointMake(0,0);
////
////    gradientLayer.endPoint = CGPointMake(0,1);
////
////    gradientLayer.frame = backView.frame;[backView.layer addSublayer:gradientLayer];
//
//    CGSize s = backView.bounds.size;
//    UIGraphicsBeginImageContextWithOptions(s,YES, [UIScreen mainScreen].scale); [backView.layer renderInContext:UIGraphicsGetCurrentContext()];
//    UIImage*image =UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//
//    return image;
//
//}
//
//
////MARK:-imageWithColor
//- (UIImage *)imageWithColor:(UIColor *)color{
//    // 一个像素
//    CGRect rect = CGRectMake(0, 0, 1, 1);
//    // 开启上下文
//    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
//    [color setFill];
//    UIRectFill(rect);
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//
//    return image;
//}


//MARK:- cloation
-(void)initloction {
    
    self.locationManager = [[CLLocationManager alloc] init];
    //设置代理为自己
    _locationManager.delegate = self;
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    if ([[[UIDevice currentDevice]systemVersion]floatValue] >= 8.0) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    if ([CLLocationManager locationServicesEnabled]) {    // 定位管理器 开始更新位置
        [_locationManager startUpdatingLocation];
    } else {
        [HUDManager showTextHud:loctionError];
    }
}


//MARK:-CLLocation
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:[locations lastObject] completionHandler:^(NSArray *array, NSError *error) {
        if (array.count > 0) {
            CLPlacemark *placemark = [array objectAtIndex:0];
            NSString *city = placemark.locality;
            if (!city) {
                city = placemark.administrativeArea;
            }
            
            [self.hvc setLoctionStr:city];
        } else if (error == nil && [array count] == 0) {
            NSLog(@"No results were returned.");
        } else if (error != nil) {
            NSLog(@"An error occurred = %@", error);
        }
    }];
    [manager stopUpdatingLocation];
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
