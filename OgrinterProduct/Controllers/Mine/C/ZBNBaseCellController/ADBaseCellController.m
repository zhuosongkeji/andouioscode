//
//  ADBaseCellController.m
//  AnDouBusiness
//
//  Created by 周芳圆 on 2019/12/4.
//  Copyright © 2019 ZhouBunian. All rights reserved.
//

#import "ADBaseCellController.h"
#import "ADCellGroupItemModel.h"
#import "ADCommonStaticCell.h"
#import "ADCellRowItemModel.h"


@interface ADBaseCellController ()

@end

@implementation ADBaseCellController

#pragma mark - lazy

/**
 存放组模型的数组

 @return _groupArray
 */
- (NSMutableArray *)groupArray
{
    if (!_groupArray) {
        _groupArray = [NSMutableArray array];
    }
    return _groupArray;
}

/**
 初始化一个样式

 @return Vc
 */
- (instancetype)init
{
    return [super initWithStyle:UITableViewStyleGrouped];
}


/**
 有多少组
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.groupArray.count;
}

/**
 每组多少行

 @param tableView tableView
 @param section section
 @return 行数
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    ADCellGroupItemModel *groupModel = self.groupArray[section];
    return groupModel.rowArray.count;
}
/**
 每行的样子
 @return cell
 */

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 创建cell
    ADCommonStaticCell *cell = [ADCommonStaticCell ad_initWithTableView:tableView cellStyle:UITableViewCellStyleDefault];
    // 取出组模型
    ADCellGroupItemModel *groupModel = self.groupArray[indexPath.section];
    // 取出行模型
    ADCellRowItemModel *rowModel = groupModel.rowArray[indexPath.row];
    // 设置数据
    cell.rowItemModel = rowModel;
    
    return cell;
}

/**
 点击事件处理

 @param tableView 哪个tableView
 @param indexPath 哪行
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 取出组模型
    ADCellGroupItemModel *groupModel = self.groupArray[indexPath.section];
    // 取出行模型
    ADCellRowItemModel *rowModel = groupModel.rowArray[indexPath.row];
    // 如果需要执行block
    if (rowModel.myTask) {
        rowModel.myTask(indexPath);
        return;
    }
    // 如果有需要跳转的控制器
    if (rowModel.desClass) {
        UIViewController *vc = [[rowModel.desClass alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
/**
 * 头标题
 */
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    ADCellGroupItemModel *groupModel = self.groupArray[section];
    return groupModel.headerTitle;
}
/**
 * 尾部标题
 */
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    ADCellGroupItemModel *groupModel = self.groupArray[section];
    return groupModel.footerTitle;
}
/**
 * 头标题高
 */
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }
    return 1;
}
/**
 * 尾部高
 */
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}




@end
