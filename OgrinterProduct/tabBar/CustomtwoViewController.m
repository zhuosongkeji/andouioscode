//
//  CustomtwoViewController.m
//  OgrinterProduct
//
//  Created by wongshine on 2019/11/29.
//  Copyright © 2019 RXF. All rights reserved.
//

#define TabBarVC              @"vc"                //--tabbar对应的视图控制器
#define TabBarTitle           @"title"             //--tabbar标题
#define TabBarImage           @"image"             //--未选中时tabbar的图片
#define TabBarSelectedImage   @"selectedImage"     //--选中时tabbar的图片
#define TabBarItemBadgeValue  @"badgeValue"        //--未读个数
#define TabBarCount 4

typedef NS_ENUM(NSInteger,CustomBarType) {
    CustomBarTypeHome,//首页
    CustomBarTypeLife,//生活
    CustomBarTypeShop,//商城
    CustomBarTypeMine//个人中心
};

typedef NS_ENUM(NSInteger,CustomBarType1) {
    CustomBarType1Home,//首页
    CustomBarType1Life,//生活
    CustomBarType1Shop,//商城
    CustomBarType1Work,//工作
    CustomBarType1Mine//个人中心
};

#import "CustomtwoViewController.h"

@interface CustomtwoViewController ()

@end

@implementation CustomtwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setSubVc];
    // Do any additional setup after loading the view.
}


-(NSArray *)taBbars {
    NSMutableArray *item = [[NSMutableArray alloc]init];
    for (NSInteger i = 0; i < TabBarCount; i ++) {
        [item addObject:@(i)];
    }
    return item;
}

-(void)setSubVc {
    
    NSMutableArray *vcArr = [[NSMutableArray alloc]init];
    [self.taBbars enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary *item = nil;
        
        item = [self vcInfoForTabType:[obj intValue]];;
        
        NSString *vcName = item[TabBarVC];
        NSString *imgeName = item[TabBarImage];
        NSString *imgeSelect = item[TabBarSelectedImage];
        Class class = NSClassFromString(vcName);
        UIViewController *vc = [[class alloc]initWithNibName:nil bundle:nil];
        vc.hidesBottomBarWhenPushed = NO;
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
        [nav.navigationBar setBackgroundImage:[self convertViewToImage] forBarMetrics:UIBarMetricsDefault];
        nav.tabBarItem = [[UITabBarItem alloc] initWithTitle:item[TabBarTitle]
                                                       image:[UIImage imageNamed:imgeName]
                                               selectedImage:[[UIImage imageNamed:imgeSelect] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        nav.tabBarItem.tag = idx;
        NSInteger badge = [item[TabBarItemBadgeValue] integerValue];
        
        if (badge) {
            nav.tabBarItem.badgeValue = [NSString stringWithFormat:@"%zd",badge];
        }
        
        [[UITabBar appearance] setTintColor:KSDUAULTCOLORE]; // 设置TabBar上 字体颜色
        
        
    }];
    
    self.viewControllers = [NSArray arrayWithArray:vcArr];
}


#pragma mark - VC
- (NSDictionary *)vcInfoForTabType:(CustomBarType) type{
    
    NSDictionary *configs = @{
                              @(CustomBarTypeHome)     : @{
                                      TabBarVC           : @"ShopingHomeViewController",
                                      TabBarTitle        : @"首页",
                                      TabBarImage        : @"shouye",
                                      TabBarSelectedImage: @"shouyexz",
                                      TabBarItemBadgeValue: @(0)
                                      },
                              @(CustomBarTypeLife)     : @{
                                      TabBarVC           : @"ShopingCategoryViewController",
                                      TabBarTitle        : @"发现",
                                      TabBarImage        : @"shenghuo",
                                      TabBarSelectedImage: @"shenghuoxz",
                                      TabBarItemBadgeValue: @(0)
                                      },
                              @(CustomBarTypeShop)     : @{
                                      TabBarVC           : @"ShoingMsgViewController",
                                      TabBarTitle        : @"数据",
                                      TabBarImage        : @"shangcheng",
                                      TabBarSelectedImage: @"shangchengxz",
                                      TabBarItemBadgeValue: @(0)
                                      },
                              @(CustomBarTypeMine)     : @{
                                      TabBarVC           : @"ShoingMineViewController",
                                      TabBarTitle        : @"我的",
                                      TabBarImage        : @"wode",
                                      TabBarSelectedImage: @"wodexz",
                                      TabBarItemBadgeValue: @(0)
                                      }
                              };
    return configs[@(type)];
}


-(UIImage*)convertViewToImage {
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0,0, KSCREEN_WIDTH,64)];
    backView.backgroundColor = KSRGBA(98, 205, 173, 1);
    
    CGSize s = backView.bounds.size;
    UIGraphicsBeginImageContextWithOptions(s,YES, [UIScreen mainScreen].scale); [backView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage*image =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
    
}


//MARK:-imageWithColor
- (UIImage *)imageWithColor:(UIColor *)color{
    // 一个像素
    CGRect rect = CGRectMake(0, 0, 1, 1);
    // 开启上下文
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    [color setFill];
    UIRectFill(rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
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
