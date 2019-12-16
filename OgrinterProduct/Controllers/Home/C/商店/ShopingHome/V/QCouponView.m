//
//  QCouponView.m
//  OgrinterProduct
//
//  Created by wongshine on 2019/12/16.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "QCouponView.h"
#import "QCouponTableViewCell.h"


@interface QCouponView()<UITableViewDataSource,UITableViewDelegate>


@property (weak, nonatomic) IBOutlet UITableView *QTableView;

@end


@implementation QCouponView


-(void)awakeFromNib {
    [super awakeFromNib];
    [self setup];
}


-(void)setup{
    self.QTableView.tableFooterView = [UILabel new];
    self.QTableView.delegate = self;
    self.QTableView.dataSource = self;
    
    self.QTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.QTableView registerNib:[UINib nibWithNibName:@"QCouponTableViewCell" bundle:nil] forCellReuseIdentifier:@"QCouponTableViewCell"];
}


//MARK:- tableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    QCouponTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QCouponTableViewCell"];
    
    if (!cell) {
        NSLog(@"创建cell");
    }
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



@end
