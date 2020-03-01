//
//  AsseCollectionViewCell1.m
//  OgrinterProduct
//
//  Created by wongshine on 2020/2/20.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "AsseCollectionViewCell1.h"
#import "KillerListAessbModel.h"

@interface AsseCollectionViewCell1()

@property (weak, nonatomic) IBOutlet UIImageView *icon;


@end


@implementation AsseCollectionViewCell1


-(void)setListmodel:(KillerListAessbModel *)listmodel{
    _listmodel = listmodel;
    [self.icon sd_setImageWithURL:[NSURL URLWithString:listmodel.img] placeholderImage:nil];
    self.titblabel.text = listmodel.name;
    self.tlable.text = [NSString stringWithFormat:@"%@人团",listmodel.ktop_member];
    self.plabel.text = [NSString stringWithFormat:@"￥%@",listmodel.price];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
