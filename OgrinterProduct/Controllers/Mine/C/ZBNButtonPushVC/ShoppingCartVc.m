//
//  ShoppingCartVc.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/6.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ShoppingCartVc.h"
#import "ShoppingCartCell.h"
#import "ShoppingCartBottomView.h"

@interface ShoppingCartVc () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) ShoppingCartBottomView *bottomView;

@property (nonatomic, weak) UITableView *tableView;

@end

@implementation ShoppingCartVc

static NSString * const ShoppingCellID = @"shoppingCart";

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    UITableView *tableV = [[UITableView alloc] init];
    tableV.delegate = self;
    tableV.dataSource = self;
    tableV.frame = self.view.bounds;
    [self.view addSubview:tableV];
    self.tableView = tableV;
    
    
    ShoppingCartBottomView *bottomV = [ShoppingCartBottomView viewFromXib];
    bottomV.x = 0;
    bottomV.height = 44;
    bottomV.width = self.view.width;
    bottomV.y = self.view.height - bottomV.height * 2;
    self.bottomView = bottomV;
    [self.view addSubview:bottomV];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ShoppingCartCell class]) bundle:nil] forCellReuseIdentifier:ShoppingCellID];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShoppingCartCell *cell = [tableView dequeueReusableCellWithIdentifier:ShoppingCellID];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}


@end
