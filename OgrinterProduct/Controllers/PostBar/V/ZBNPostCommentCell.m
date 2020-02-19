//
//  ZBNPostCommentCell.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/2/17.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNPostCommentCell.h"

@interface ZBNPostCommentCell ()

@property (weak, nonatomic) IBOutlet UIImageView *userIcon;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *commentL;
@property (weak, nonatomic) IBOutlet UILabel *countL;

@end

@implementation ZBNPostCommentCell

- (void)setComM:(ZBNPostComModel *)comM
{
    _comM = comM;
    self.userIcon.image = [UIImage circleImageNamed:comM.userIcon];
    self.userName.text = comM.userName;
    self.commentL.text = comM.comment;
    self.countL.text = [NSString stringWithFormat:@"共%@条回复>",comM.count];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
