//
//  CitylistViewController.m
//  OgrinterProduct
//
//  Created by wongshine on 2019/11/29.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "CitylistViewController.h"
#import "HotTableViewCell.h"
#import <CoreLocation/CoreLocation.h>


@interface CitylistViewController ()<UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate>

@property (nonatomic,strong) UITableView *mTableView;

@property (nonatomic, strong) NSMutableArray* dataNameArr;

@end


@implementation CitylistViewController

//MARK:-mTableView懒加载
-(UITableView *)mTableView{
    if (!_mTableView) {
        _mTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT-kStatusBarAndNavigationBarH) style:UITableViewStylePlain];
        _mTableView.delegate = self;
        _mTableView.dataSource = self;
        _mTableView.sectionIndexColor = [UIColor darkGrayColor];
    }
    return _mTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"城市";
    self.dataNameArr = [NSMutableArray array];
    for (NSDictionary *dict in cityArr) {
        [self.dataNameArr addObject:dict[@"name"]];
    }
    
    [self.view addSubview:self.mTableView];
    
    // Do any additional setup after loading the view.
}


//MARK:-tableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [cityArr count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }
    return [[cityArr[section] objectForKey:@"array"] count];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        HotTableViewCell *cell = [HotTableViewCell createKKLocalHotCityTableViewCellWithTableView:tableView indexPath:indexPath];
        
        cell.hotCityArr = cityArr[indexPath.section][@"array"];
        cell.HotCityClickBlock = ^(NSString* name) {
            //点击了热门城市
            [self acquireLocationWithCityName:name];
        };
        
        return cell;
        
    }else{
        UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuseIdentifier"];
            cell.textLabel.textColor = [UIColor darkGrayColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        NSArray* array = cityArr[indexPath.section][@"array"];
        cell.textLabel.text = array[indexPath.row];
        
        return cell;
    }
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        //地理编码-根据城市名获取经纬度
        [self acquireLocationWithCityName:cityArr[indexPath.section][@"array"][indexPath.row]];
    }
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return nil;

    }else{
        
        UIView* headV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 40)];
        headV.backgroundColor = [UIColor whiteColor];
        
        UILabel* titleLb = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, KSCREEN_WIDTH-10, 30)];
        titleLb.text = cityArr[section][@"name"];
        titleLb.textColor = [UIColor lightGrayColor];
        titleLb.font = [UIFont systemFontOfSize:14.0f];
        [headV addSubview:titleLb];
        
        return headV;
    }
}


- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return self.dataNameArr;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }
    return 40;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0)
            return 84;
        return 130;
    }else{
        return 40;
    }
}


//MARK:- 地理反编码
-(void)acquireLocationWithCityName:(NSString*)cityName{
    CLGeocoder *myGeocoder = [[CLGeocoder alloc] init];
    [myGeocoder geocodeAddressString:cityName completionHandler:^(NSArray *placemarks, NSError *error) {
        if ([placemarks count] > 0 && error == nil) {
            CLPlacemark *firstPlacemark = [placemarks objectAtIndex:0];
            NSLog(@"%@",firstPlacemark.name);
            //点击了列表的城市
            
        } else if ([placemarks count] == 0 && error == nil) {
            NSLog(@"Found no placemarks.");
        } else if (error != nil) {
            NSLog(@"An error occurred = %@", error);
        }
    }];
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
