//
//  ZBNLocationSearchVC.m
//  Gaode
//
//  Created by 周芳圆 on 2020/3/1.
//  Copyright © 2020 ZhouBunian. All rights reserved.
//

#import "ZBNLocationSearchVC.h"
#import "ZBNLocationCell.h"
#import <AMapSearchKit/AMapSearchKit.h>
#import "ZBNSearchAddrM.h"
#import <AMapLocationKit/AMapLocationKit.h>
#import <MAMapKit/MAMapKit.h>
#import "TLCityPickerController.h"



@interface ZBNLocationSearchVC () <UITableViewDelegate, UITableViewDataSource,MAMapViewDelegate, UISearchBarDelegate,AMapSearchDelegate, AMapLocationManagerDelegate,UISearchResultsUpdating,TLCityPickerDelegate>

/*! 右边导航栏 */
@property (nonatomic, strong) UIBarButtonItem *rightItem;
/*! 搜索table */
@property (nonatomic, strong) UITableView *searchTable;
/*! 定位回调 */
@property (nonatomic, copy) AMapLocatingCompletionBlock completionBlock;
/*! 搜索控制器 */
@property (strong, nonatomic) UISearchController *searchController;
/*! 地图的View */
@property (strong, nonatomic) MAMapView *mapView;
/*! 展示数据的table */
@property (weak, nonatomic) IBOutlet UITableView *dataTabel;
/*! 底部展示的数组 */
@property (nonatomic, strong) NSMutableArray *dataArr;
/*! 检索API */
@property (nonatomic, strong) AMapSearchAPI *search;
/*! location */
@property (nonatomic, copy) AMapGeoPoint *location;
/*! 经纬度 */
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
/*! 地图标识 */
@property (nonatomic, strong) MAPointAnnotation *pointAnnotaiton;
/*! 检索的数据 */
@property (nonatomic, strong) NSMutableArray *tips;

@end

@implementation ZBNLocationSearchVC


- (void)configLocationManager
{
    self.locationManager = [[AMapLocationManager alloc] init];
    [self.locationManager setDelegate:self];
    // 设置期望定位的经度
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    // 设置不允许系统暂停定位
    [self.locationManager setPausesLocationUpdatesAutomatically:YES];
    // 设置允许在后台定位
//    [self.locationManager setAllowsBackgroundLocationUpdates:YES];
    // 设置定位超时时间
    [self.locationManager setLocationTimeout:4];
    // 设置逆地理超时时间
    [self.locationManager setReGeocodeTimeout:4];
    // 设置开启虚拟定位风险监测,可以根据需要开启
    [self.locationManager setDetectRiskOfFakeLocation:NO];
    
}

- (void)initCompleteBlock
{
    __weak typeof(self) weakSelf;
    self.completionBlock = ^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        if (error != nil && error.code == AMapLocationErrorLocateFailed) {
            //定位错误：此时location和regeocode没有返回值，不进行annotation的添加
            NSLog(@"定位错误:{%ld - %@};", (long)error.code, error.userInfo);
            return;
        } else if (error != nil
        && (error.code == AMapLocationErrorReGeocodeFailed
            || error.code == AMapLocationErrorTimeOut
            || error.code == AMapLocationErrorCannotFindHost
            || error.code == AMapLocationErrorBadURL
            || error.code == AMapLocationErrorNotConnectedToInternet
            || error.code == AMapLocationErrorCannotConnectToHost))
        {
            //逆地理错误：在带逆地理的单次定位中，逆地理过程可能发生错误，此时location有返回值，regeocode无返回值，进行annotation的添加
            NSLog(@"逆地理错误:{%ld - %@};", (long)error.code, error.userInfo);
        }
         else if (error != nil && error.code == AMapLocationErrorRiskOfFakeLocation) {
            //存在虚拟定位的风险：此时location和regeocode没有返回值，不进行annotation的添加
            NSLog(@"存在虚拟定位的风险:{%ld - %@};", (long)error.code, error.userInfo);
            
            //存在虚拟定位的风险的定位结果
//            __unused CLLocation *riskyLocateResult = [error.userInfo objectForKey:@"AMapLocationRiskyLocateResult"];
//            //存在外接的辅助定位设备
//            __unused NSDictionary *externalAccressory = [error.userInfo objectForKey:@"AMapLocationAccessoryInfo"];
            
            return;
        }
         else
         {
             //没有错误：location有返回值，regeocode是否有返回值取决于是否进行逆地理操作，进行annotation的添加
         }
        
        //根据定位信息，添加annotation
        MAPointAnnotation *annotation = [[MAPointAnnotation alloc] init];
        [annotation setCoordinate:location.coordinate];
        self.coordinate = location.coordinate;
        [annotation setTitle:[NSString stringWithFormat:@"%@", regeocode.formattedAddress]];
//        [self.addBtn setTitle:regeocode.city forState:UIControlStateNormal];
         if (regeocode)
                {
                    NSLog(@"%@-----",regeocode.citycode);
                    NSLog(@"%@=====",regeocode.adcode);
                    NSLog(@"%@",regeocode.formattedAddress);
                    NSLog(@"%@",regeocode.district);
                    NSLog(@"%@",regeocode.province);
                    NSLog(@"%@",regeocode.street);
                    NSLog(@"%@",regeocode.AOIName);
                   
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.rightItem setTitle:regeocode.province];
                    });
                    
                     [annotation setSubtitle:[NSString stringWithFormat:@"%@-%@-%.2fm", regeocode.citycode, regeocode.adcode, location.horizontalAccuracy]];
                    
                }
        [self addAnnotationToMapView:annotation];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"responseOK" object:nil];
    };
    
    
}

- (void)addAnnotationToMapView:(id<MAAnnotation>)annotation
{
    [self.mapView addAnnotation:annotation];
    [self.mapView selectAnnotation:annotation animated:YES];
    [self.mapView setZoomLevel:15.1 animated:NO];
    [self.mapView setCenterCoordinate:annotation.coordinate animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initSearchController];
    [self setupNav];
    // 设置table
    [self setupTable];
    // 设置地图
    [self setupMapView];
    // 设置检索
    [self setupSearch];
    // 设置回调
    [self initCompleteBlock];
    // 配置manager
    [self configLocationManager];
    // 进行单词l逆地理定位
    [self.locationManager requestLocationWithReGeocode:YES completionBlock:self.completionBlock];
    // 监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(searchBegin) name:@"responseOK" object:nil];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    self.searchController.active = NO;
}


- (void)setupNav
{
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"北京" style:UIBarButtonItemStylePlain target:self action:@selector(rightItemClick)];
    self.navigationItem.rightBarButtonItem = rightItem;
    [rightItem setTintColor:[UIColor whiteColor]];
    self.rightItem = rightItem;
}

- (void)rightItemClick
{
    TLCityPickerController *cityPickerVC = [[TLCityPickerController alloc] init];
    [cityPickerVC setDelegate:self];
    cityPickerVC.loactionCityName = self.rightItem.title;
    cityPickerVC.hotCitys = @[@"100010000", @"200010000", @"300210000", @"600010000", @"300110000"];
    [self.navigationController presentViewController:cityPickerVC animated:YES completion:nil];
    [self.navigationController popToRootViewControllerAnimated:YES];
}


- (void)searchBegin
{
    [self searchPoiByCenterCoordinate];
}

#pragma mark - TLCityPickerDelegate
- (void) cityPickerController:(TLCityPickerController *)cityPickerViewController didSelectCity:(TLCity *)city
{
    NSLog(@"%@",city.cityName);
    [self.rightItem setTitle:city.cityName];
    
    [cityPickerViewController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void) cityPickerControllerDidCancel:(TLCityPickerController *)cityPickerViewController
{
    [cityPickerViewController dismissViewControllerAnimated:YES completion:^{
        
    }];
}



#pragma mark -- 地图定位相关

/*! 初始化地图 */
- (void)setupMapView
{
    
    if (self.mapView == nil) {
        self.mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 300)];
        [self.mapView setDelegate:self];
        // 设置比例尺比例
        self.mapView.zoomLevel = 14;
    }
    
}

#pragma mark - MAMapView Delegate

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *pointReuseIndetifier = @"pointReuseIndetifier";
        
        MAPinAnnotationView *annotationView = (MAPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndetifier];
        }
        
        annotationView.canShowCallout   = YES;
        annotationView.animatesDrop     = YES;
        annotationView.draggable        = NO;
        annotationView.image            = [UIImage imageNamed:@"icon_location.png"];
        
        return annotationView;
    }
    
    return nil;
}


#pragma mark - Utility
/* 输入提示 搜索.*/
- (void)searchTipsWithKey:(NSString *)key
{
    if (key.length == 0) {
        return;
    }
    
    AMapInputTipsSearchRequest *tips = [[AMapInputTipsSearchRequest alloc] init];
    tips.keywords = key;
    tips.city = self.rightItem.title;
    
    [self.search AMapInputTipsSearch:tips];
}

/* 输入提示回调. */
- (void)onInputTipsSearchDone:(AMapInputTipsSearchRequest *)request response:(AMapInputTipsSearchResponse *)response
{
    if (response.count == 0)
    {

        return;
    }
    [self.tips setArray:response.tips];
    [self.searchTable reloadData];
}



#pragma mark -- 检索相关
/*! 初始化检索 */
- (void)setupSearch
{
    self.search = [[AMapSearchAPI alloc] init];
    self.search.delegate = self;
}

/* 根据中心点坐标来搜周边的POI. */
- (void)searchPoiByCenterCoordinate
{
    AMapPOIAroundSearchRequest *request = [[AMapPOIAroundSearchRequest alloc] init];
    
    request.location            = [AMapGeoPoint locationWithLatitude:self.coordinate.latitude longitude:self.coordinate.longitude];
    request.keywords            = @"地址 | 街道 | 小区 | 门牌号";
    /* 按照距离排序. */
    request.sortrule            = 0;
    request.requireExtension    = YES;
    request.offset = 50;
    [self.search AMapPOIAroundSearch:request];
    
}

- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error
{
    NSLog(@"%ld",(long)error.code);
}

/* POI 搜索回调. */
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response
{
    if (response.pois.count == 0)
    {
        NSLog(@"respose%zd",response.pois.count);
        return;
    }

    [response.pois enumerateObjectsUsingBlock:^(AMapPOI *obj, NSUInteger idx, BOOL *stop) {
        ZBNSearchAddrM *model = [[ZBNSearchAddrM alloc] init];
        model.province = obj.province;
        model.city = obj.city;
        model.district = obj.district;
        model.name = obj.name;
        model.address = obj.name;
        model.pcode = obj.pcode;
        model.citycode = obj.citycode;
        model.adcode = obj.adcode;
        if (idx == 0) {
            model.isSelected = YES;
        } else {
            model.isSelected = NO;
        }
        [self.dataArr addObject:model];
        [self.dataTabel reloadData];
    }];
    
}


- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:YES animated:YES];
    return YES;
}

#pragma mark - UISearchResultsUpdating

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    self.searchTable.hidden = !searchController.isActive;
    
    [self searchTipsWithKey:searchController.searchBar.text];
    if (searchController.isActive && searchController.searchBar.text.length > 0)
    {
        searchController.searchBar.placeholder = searchController.searchBar.text;
    }
}




#pragma mark -- table

- (void)setupTable
{
    // 展示检索数据的table
    CGFloat tableX = 0;
    CGFloat tableY = self.dataTabel.tableHeaderView.bounds.size.height;
    CGFloat tableW = self.view.frame.size.width;
    CGFloat tableH = self.view.bounds.size.height - tableY;
    self.searchTable = [[UITableView alloc] initWithFrame:CGRectMake(tableX, tableY, tableW, tableH) style:UITableViewStylePlain];
    self.searchTable.contentInset = UIEdgeInsetsMake(tableY, 0, 300, 0);
    self.searchTable.delegate = self;
    self.searchTable.dataSource = self;
    self.searchTable.hidden = YES;
    self.searchTable.bounces = NO;
    [self.view addSubview:self.searchTable];
    
    // 底部的table
    self.dataTabel.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.dataTabel.bounces = NO;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == self.dataTabel) {
        return 1;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.dataTabel)
    {
        return self.dataArr.count;
    }
    else
    {
        return self.tips.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == _dataTabel)
    {
        NSLog(@"cellforrow     datatable  ");
        ZBNLocationCell *cell = [ZBNLocationCell registerCellForTable:tableView];
        cell.model = self.dataArr[indexPath.row];
        return cell;
    }
    else
    {   NSLog(@"searchforrow     search  ");
        ZBNLocationCell *cell = [ZBNLocationCell registerCellForTable:tableView];
        AMapTip *tip = self.tips[indexPath.row];
        NSLog(@"%zd",self.tips.count);
        cell.tip = tip;
        return cell;
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (self.dataTabel == tableView) {
        return self.mapView;
    } else {
        return nil;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
     if (self.dataTabel == tableView) {
           return 300;
       } else {
           return 0;
       }
       
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.dataTabel) {
        ZBNSearchAddrM *addM = self.dataArr[indexPath.row];
        
        if (self.selectedAddressTask) {
            if ([addM.province isEqualToString:addM.city]) {
                self.selectedAddressTask([NSString stringWithFormat:@"%@%@%@",addM.city,addM.district,addM.name], addM.adcode, addM.province);
            } else {
                self.selectedAddressTask([NSString stringWithFormat:@"%@%@%@%@",addM.province,addM.city,addM.district,addM.name], addM.adcode,addM.province);
            }
        }
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        AMapTip *tip = self.tips[indexPath.row];
        if (self.selectedAddressTask) {
            self.selectedAddressTask([NSString stringWithFormat:@"%@%@",tip.district,tip.address], tip.adcode,tip.district);
        }
        [self.navigationController popViewControllerAnimated:YES];
        self.searchTable.hidden = YES;
        self.searchController.searchBar.hidden = YES;
    }
}


#pragma mark -- lazy

- (NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

- (NSMutableArray *)tips
{
    if (!_tips) {
        _tips = [NSMutableArray array];
    }
    return _tips;
}

#pragma mark -- 搜索控制器相关


- (void)initSearchController
{
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater = self;
    self.searchController.dimsBackgroundDuringPresentation = NO;
    self.searchController.searchBar.placeholder = @"请输入";
    self.searchController.hidesNavigationBarDuringPresentation = NO;
    [self.searchController.searchBar sizeToFit];
    self.searchController.searchBar.backgroundImage = [UIImage new];
    self.searchController.searchBar.searchBarStyle = UISearchBarStyleMinimal;
    self.searchController.searchBar.delegate = self;
    self.dataTabel.tableHeaderView = self.searchController.searchBar;
}

//- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
//
//}
//



@end
