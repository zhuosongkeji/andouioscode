//
//  ZBNRTComDetailHeader.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/16.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNRTComDetailHeader.h"
#import "ZBNRTComDetailModel.h"

@interface ZBNRTComDetailHeader ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImage;

@property (weak, nonatomic) IBOutlet UILabel *shopName;

/*! 店家的电话 */
@property (nonatomic, copy) NSString *shopPhone;

@end

@implementation ZBNRTComDetailHeader

- (void)setComDetailM:(ZBNRTComDetailModel *)comDetailM
{
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",imgServer,comDetailM.logo_img]]];
    self.shopName.text = comDetailM.name;
    self.shopPhone = comDetailM.tel;
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



@end
