//
//  CategoryCollectionViewCell.m
//  OgrinterProduct
//
//  Created by wongshine on 2020/1/9.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "CategoryCollectionViewCell.h"
#import "ShoperListModel.h"

@interface CategoryCollectionViewCell()
@property (weak, nonatomic) IBOutlet UILabel *title;

@property(nonatomic)UIColor *nabolcolor;
@property(nonatomic)UIColor *selectcolor;

@end

@implementation CategoryCollectionViewCell


- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.layer.borderColor = UIColor.lightGrayColor.CGColor;
    self.layer.borderWidth = 0.4;
    self.layer.cornerRadius = 4;
    self.nabolcolor = UIColor.lightGrayColor;
    self.selectcolor = UIColor.redColor;
    // Initialization code
}


-(void)setMlistm:(ShoperListModel *)mlistm{
    
    self.title.text = mlistm.type_Name;
    if (mlistm.iselect){
        self.layer.borderColor = self.selectcolor.CGColor;
        self.contentView.backgroundColor = self.selectcolor;
    }else{
        self.layer.borderColor =self.nabolcolor.CGColor;
        self.contentView.backgroundColor = UIColor.whiteColor;
    }
}

@end
