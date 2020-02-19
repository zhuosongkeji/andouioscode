//
//  ZBNPostPayVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/2/19.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNPostPayVC.h"
#import "ZBNPostPayCell.h"
#import "ZBNPostSuccessVC.h"

@interface ZBNPostPayVC () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *myTableV;
@end

@implementation ZBNPostPayVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTable];
}


- (void)setupTable
{
    self.navigationItem.title = @"置顶选择";
    self.myTableV.backgroundColor = KSRGBA(241, 241, 241, 1);
    self.myTableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myTableV.delegate = self;
    self.myTableV.dataSource = self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZBNPostPayCell *cell = [[NSBundle mainBundle] loadNibNamed:@"ZBNPostPayCell" owner:nil options:nil].lastObject;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 450;
}


- (IBAction)payBtnClick:(id)sender {
    ZBNPostSuccessVC *vc = [[ZBNPostSuccessVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
