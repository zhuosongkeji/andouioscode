//
//  RCarTableViewCell.m
//  OgrinterProduct
//
//  Created by wongshine on 2020/1/18.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "RCarTableViewCell.h"
#import "HotelOnlinesListModel.h"

@interface RCarTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *title;

@property (weak, nonatomic) IBOutlet UILabel *price;

@property (weak, nonatomic) IBOutlet UILabel *numberLable;

@end

@implementation RCarTableViewCell


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setMolist:(HotelOnlinesListModel *)molist{
    _molist = molist;
    
    self.title.text = molist.hname;
    self.price.text = molist.price;
    self.numberLable.text = molist.munbert;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
