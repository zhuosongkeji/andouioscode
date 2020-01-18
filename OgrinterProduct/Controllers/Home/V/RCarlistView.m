//
//  RCarlistView.m
//  OgrinterProduct
//
//  Created by wongshine on 2020/1/18.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "RCarlistView.h"
#import "RCarTableViewCell.h"


@interface RCarlistView()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *smtableView;

@property(nonatomic,strong)NSArray *datArr;


@end

@implementation RCarlistView


-(void)awakeFromNib{
    [super awakeFromNib];
    
    [self setup];
}


-(void)setup{
    
    self.smtableView.delegate = self;
    self.smtableView.dataSource = self;
    self.smtableView.tableFooterView = [UILabel new];
    
    [self.smtableView registerNib:[UINib nibWithNibName:@"RCarTableViewCell" bundle:nil] forCellReuseIdentifier:@"RCarTableViewCell"];
    
}


-(void)setDArr:(NSArray *)dArr{
    _dArr = dArr;
    self.datArr =[NSArray arrayWithArray:dArr];
    [self.smtableView reloadData];
}


//MARK:- tableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.datArr count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RCarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RCarTableViewCell"];
    
    if (!cell) {
        
        cell = [[NSBundle mainBundle] loadNibNamed:@"RCarTableViewCell" owner:self options:nil].lastObject;
        
        NSLog(@"创建");
    }
    
    if ([self.datArr count]) {
        cell.molist = self.datArr[indexPath.row];
    }
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // 取消Cell的选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
