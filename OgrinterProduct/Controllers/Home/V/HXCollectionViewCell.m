//
//  HXCollectionViewCell.m
//  HXCollectionView
//
//  Created by hubery on 2018/1/13.
//  Copyright © 2018年 hubery. All rights reserved.
//

#import "HXCollectionViewCell.h"
#import "HomeModel.h"
#import "OnlineOrderListModel.h"

@interface HXCollectionViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *imgView1;
@property (weak, nonatomic) IBOutlet UILabel *lable1;

@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@property (weak, nonatomic) IBOutlet UILabel *name;

@end

@implementation HXCollectionViewCell


-(void)setModelist0:(HomeModel *)modelist0{
    _modelist0 = modelist0;
    
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:modelist0.logo_img] completed:nil];
    self.name.text = modelist0.name;
    
    [self.imgView setHidden:NO];
    [self.name setHidden:NO];
    [self.imgView1 setHidden:YES];
    [self.lable1 setHidden:YES];
}


-(void)setModelist1:(HomeModel *)modelist1{
    _modelist1 = modelist1;
    
    [self.imgView setHidden:YES];
    [self.name setHidden:YES];
    [self.imgView1 setHidden:NO];
    [self.lable1 setHidden:NO];
}


-(void)setLmodelist1:(OnlineOrderListModel *)lmodelist1{
    
    self.layer.cornerRadius = 4;
    [self.imgView1 sd_setImageWithURL:[NSURL URLWithString:lmodelist1.image] completed:nil];
    
    [self.imgView1 setHidden:NO];
    [self.name setHidden:YES];
    [self.imgView setHidden:YES];
    [self.lable1 setHidden:YES];
    
}


@end
