//
//  ZBNRTComDetailHeader.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/16.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNRTComDetailHeader.h"
#import "ZBNRTComDetailModel.h"
#import <CoreLocation/CoreLocation.h>

@interface ZBNRTComDetailHeader ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImage;

@property (weak, nonatomic) IBOutlet UILabel *shopName;

/*! 店家的电话 */
@property (nonatomic, copy) NSString *shopPhone;
@property (nonatomic, copy) NSString *address;
@end

@implementation ZBNRTComDetailHeader

- (void)setComDetailM:(ZBNRTComDetailModel *)comDetailM
{
    _comDetailM = comDetailM;
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",imgServer,comDetailM.logo_img]]];
    self.shopName.text = comDetailM.name;
    self.shopPhone = comDetailM.tel;
    self.address = comDetailM.address;
}


- (void)awakeFromNib
{
    [super awakeFromNib];
    
}

- (IBAction)phoneBtnClick:(id)sender {

    if (self.shopPhone) {
        NSString *telephoneNumber = self.shopPhone;
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",telephoneNumber];
        [[UIApplication   sharedApplication] openURL:[NSURL URLWithString:str]];
    } else {
        NSString *telephoneNumber = @"10086";
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",telephoneNumber];
        [[UIApplication   sharedApplication] openURL:[NSURL URLWithString:str]];
    }
    
}


- (IBAction)addressBtnClick:(UIButton *)sender {
    ADWeakSelf;
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"iosamap://"]]) {
        CLGeocoder *geocoder = [[CLGeocoder alloc] init];
        [geocoder geocodeAddressString:weakSelf.comDetailM.address completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            for (CLPlacemark *mark in placemarks) {
                CLLocationCoordinate2D coordinate = mark.location.coordinate;
                NSString *urlString = [[NSString stringWithFormat:@"iosamap://navi?sourceApplication=%@&backScheme=%@&lat=%f&lon=%f&dev=0&style=2",@"导航",@"@AmapScheme",coordinate.latitude,coordinate.longitude] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
                if (@available(iOS 10.0, *)) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString] options:@{UIApplicationOpenURLOptionUniversalLinksOnly:@NO} completionHandler:nil];
                } else {
                }
            }
        }];
    } else {
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://"]]) {
        CLGeocoder *geocoder = [[CLGeocoder alloc] init];
        [geocoder geocodeAddressString:weakSelf.comDetailM.address completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            for (CLPlacemark *mark in placemarks) {
                CLLocationCoordinate2D coordinate = mark.location.coordinate;
                NSString *urlString = [[NSString stringWithFormat:@"baidumap://map/direction?origin={{我的位置}}&destination=latLng:%f,%f|name=目的地&mode=driving&coord_type=gcj02",coordinate.latitude,coordinate.longitude] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
                if (@available(iOS 10.0, *)) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString] options:@{UIApplicationOpenURLOptionUniversalLinksOnly:@NO} completionHandler:nil];
                } else {
                }
            }
        }];
            
        }
    }
}


@end
