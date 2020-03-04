//
//  AsseCollectionViewCell2.m
//  OgrinterProduct
//
//  Created by wongshine on 2020/2/20.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "AsseCollectionViewCell2.h"
#import "KillerListAessbModel.h"

@interface AsseCollectionViewCell2 ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *number;

@end

@implementation AsseCollectionViewCell2

-(void)setLmodele:(KillerListAessbModel *)lmodele{
    _lmodele = lmodele;
    
    [self.icon sd_setImageWithURL:[NSURL URLWithString:lmodele.limg] placeholderImage:nil];
    self.title.text = lmodele.lname;
    self.price.text = [NSString stringWithFormat:@"￥%@",lmodele.lprice];
    self.number.text = [NSString stringWithFormat:@"%@已拼",lmodele.total_member];
    
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
