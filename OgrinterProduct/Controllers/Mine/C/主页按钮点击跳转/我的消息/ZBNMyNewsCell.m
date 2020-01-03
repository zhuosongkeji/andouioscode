//
//  ZBNMyNewsCell.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/11.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ZBNMyNewsCell.h"

#import "ZBNMyNewsModel.h"

@interface ZBNMyNewsCell ()

/*! 消息状态的红色背景 */
@property (weak, nonatomic) IBOutlet UIView *redView;
/*! 消息状态的按钮 */
@property (weak, nonatomic) IBOutlet UILabel *readBtn;
/*! 创建时间 */
@property (weak, nonatomic) IBOutlet UILabel *create_timeL;
/*! 通知信息的标题 */
@property (weak, nonatomic) IBOutlet UILabel *newsTitleL;
@end

@implementation ZBNMyNewsCell

/*! 设置模型数据 */
- (void)setNews:(ZBNMyNewsModel *)news
{
    _news = news;
    
    self.create_timeL.text = news.created_at;
    self.newsTitleL.text = news.title;
    if ([news.messageStatus  integerValue] == 1) { // 已读
        self.readBtn.text = @"已读";
        self.redView.backgroundColor = [UIColor grayColor];
    } else {
        self.readBtn.text = @"未读";
        self.redView.backgroundColor = [UIColor redColor];
    }
    
}


- (void)awakeFromNib {
    [super awakeFromNib];
    
    // 设置按钮的圆角背景
    self.redView.layer.cornerRadius = 10;
    
}

/*! 注册cell */
+ (instancetype)registerCellForTable:(UITableView *)tableView
{
    static NSString  * const ZBNMyNewsCellID = @"ZBNMyNewsCellID";
    ZBNMyNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:ZBNMyNewsCellID];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ZBNMyNewsCell" owner:nil options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)setFrame:(CGRect)frame
{
    frame.size.height -= 1;
    [super setFrame:frame];
}

@end
