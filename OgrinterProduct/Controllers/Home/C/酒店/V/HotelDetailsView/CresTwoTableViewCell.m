//
//  CresTwoTableViewCell.m
//  OgrinterProduct
//
//  Created by wongshine on 2019/12/9.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "CresTwoTableViewCell.h"
#import "CommentModel.h"

@interface CresTwoTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *time;


@property (weak, nonatomic) IBOutlet UILabel *content;

@property (weak, nonatomic) IBOutlet UIImageView *bjimg;


@end


@implementation CresTwoTableViewCell


-(void)setListmodel:(CommentModel *)listmodel{
    _listmodel = listmodel;
    
    [self.icon sd_setImageWithURL:[NSURL URLWithString:listmodel.avator] placeholderImage:nil];
    
    self.name.text = listmodel.name;
    self.time.text = listmodel.created_at;
    self.content.text = listmodel.content;
    
}


-(void)setClistmodel:(CommentModel *)clistmodel{
    [self.icon sd_setImageWithURL:[NSURL URLWithString:clistmodel.avator] placeholderImage:nil];
    
    self.name.text = clistmodel.name;
    self.time.text = clistmodel.created_at;
    self.content.text = clistmodel.content;

}


- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.icon.layer.cornerRadius = 22;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
