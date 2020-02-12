//
//  ZBNMyCollectionCommenCell.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/10.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ZBNMyCollectionCommenCell.h"
#import "ZBNMyCollectionM.h"

@interface ZBNMyCollectionCommenCell ()
/*! 图片 */
@property (weak, nonatomic) IBOutlet UIImageView *img;
/*! 名字 */
@property (weak, nonatomic) IBOutlet UILabel *name;
/*! 创建时间 */
@property (weak, nonatomic) IBOutlet UILabel *createTime;
/*! 价格 */
@property (weak, nonatomic) IBOutlet UILabel *price;
@end

@implementation ZBNMyCollectionCommenCell


- (void)setCollectionM:(ZBNMyCollectionM *)collectionM
{
    _collectionM = collectionM;
    
    [self.img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",imgServer,collectionM.img]]];
    self.name.text = collectionM.name;
    self.createTime.text = collectionM.created_at;
    self.price.text = [NSString stringWithFormat:@"¥%@",collectionM.price];
}


/*! 注册cell */
+ (instancetype)regiserCellForTable:(UITableView *)tableView
{
    static NSString * const ZBNMyCollectionCommenCellID = @"ZBNMyCollectionCommenCell";
    ZBNMyCollectionCommenCell *cell = [tableView dequeueReusableCellWithIdentifier:ZBNMyCollectionCommenCellID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ZBNMyCollectionCommenCell" owner:nil options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)setFrame:(CGRect)frame
{
    frame.size.height -= 0.5;
    [super setFrame:frame];
}

@end
