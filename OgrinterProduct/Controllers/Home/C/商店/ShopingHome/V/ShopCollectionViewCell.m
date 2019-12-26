//
//  ShopCollectionViewCell.m
//  OgrinterProduct
//
//  Created by wongshine on 2019/12/4.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ShopCollectionViewCell.h"
#import "MdBannerListModel.h"


@interface ShopCollectionViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *icon;

@property (weak, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet UILabel *price;

@end

@implementation ShopCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


-(void)setModellists:(MdBannerListModel *)modellists{
    _modellists = modellists;
    
    [self.icon sd_setImageWithURL:[NSURL URLWithString:modellists.img] placeholderImage:[UIImage imageNamed:@""]];
    self.name.text = modellists.name;
    self.price.text = [NSString stringWithFormat:@"￥%@",modellists.price];
    
}

@end
