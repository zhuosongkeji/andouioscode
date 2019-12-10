//
//  CustomAlterView.m
//  OgrinterProduct
//
//  Created by wongshine on 2019/12/10.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "CustomAlterView.h"

@interface CustomAlterView ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;

@property (weak, nonatomic) IBOutlet UIButton *agreeBtn;

@property (nonatomic,strong)UILabel *title;

@property(nonatomic,strong)UILabel *point;

@end

@implementation CustomAlterView


-(void)awakeFromNib{
    [super awakeFromNib];
    [self setup];
}


-(void)setup{
    self.cancelBtn.layer.cornerRadius = 4;
    self.agreeBtn.layer.cornerRadius = 4;
    self.tableView.tableFooterView = [UILabel new];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
}


#pragma mark -
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"identifier";
    
    UITableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell==nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        cell.textLabel.textColor = [UIColor lightGrayColor];
        cell.textLabel.numberOfLines = 2;
        cell.textLabel.font = [UIFont systemFontOfSize:13];
        cell.textLabel.text = @"入住前一天12:00之前，入申请退款订单金额全退,入申请退款订单";
        
    }
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}


- (IBAction)click:(UIButton *)sender {
    KPreventRepeatClickTime(1)
    _btnBlcok();
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
