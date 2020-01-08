//
//  BeserveView.m
//  OgrinterProduct
//
//  Created by wongshine on 2019/12/17.
//  Copyright © 2019 RXF. All rights reserved.
//


#import "BeserveView.h"
#import "BeseListViewCell.h"
#import "BeseModel.h"
#import "BeseListListModel.h"

@interface BeserveView()<UITableViewDelegate,UITableViewDataSource,BeseListViewCellDelegate>

@property (weak, nonatomic) IBOutlet UIView *bjView;
@property (weak, nonatomic) IBOutlet UIButton *plashbtn;
@property (weak, nonatomic) IBOutlet UIButton *addbtn;
@property (weak, nonatomic) IBOutlet UILabel *numberlable;

@property (nonatomic) NSInteger num;

@property (weak, nonatomic) IBOutlet UITableView *listView;
@property (nonatomic,strong)NSArray *dataArr;
@property (weak, nonatomic) IBOutlet UILabel *numBerLable;

@property(nonatomic,strong)NSMutableArray *keyArr;

@property(nonatomic,strong)NSString *ggIdStr;

@property(nonatomic,strong)NSString *ketStr;

@end


@implementation BeserveView


-(NSMutableArray *)keyArr{
    if (!_keyArr) {
        _keyArr = [NSMutableArray array];
    }
    return _keyArr;
}


-(void)awakeFromNib{
    [super awakeFromNib];
    [self setup];
}



-(void)setup{
    
    self.listView.tableFooterView = [UILabel new];
    self.listView.delegate = self;
    self.listView.dataSource = self;
    
    self.plashbtn.layer.cornerRadius = 2;
    self.plashbtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.plashbtn.layer.borderWidth = 0.8;
    
    self.addbtn.layer.cornerRadius = 2;
    self.addbtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.addbtn.layer.borderWidth = 0.8;
    
    [self.listView registerNib:[UINib nibWithNibName:@"BeseListViewCell" bundle:nil] forCellReuseIdentifier:@"BeseListViewCell"];
    
}


-(void)setDataDic:(NSDictionary *)dataDic{
    _dataDic = dataDic;
}


-(void)setListModel:(BeseModel *)listModel{
    
    _listModel = listModel;

    self.num = 1;
    self.dataArr = listModel.resArr;
    self.ketStr = nil;
    
    NSMutableString *sKeyStr = [[NSMutableString alloc]init];
    
    if ([self.keyArr count])
        [self.keyArr removeAllObjects];
    for (int i = 0; i < [listModel.resArr count]; i ++) {
        BeseListListModel *mode = listModel.resArr[i];
        [self.keyArr addObject:mode.value[0]];
    }
    for (int i = 0; i < [self.keyArr count]; i ++) {
        if (i == 0) {
            [sKeyStr appendString:[NSString stringWithFormat:@"%@",self.keyArr[i]]];
        }else{
            [sKeyStr appendString:[NSString stringWithFormat:@"-%@",self.keyArr[i]]];
        }
    }
    self.ketStr = [NSString stringWithString:sKeyStr];
    NSDictionary *dic = [listModel.pDict objectForKey:[NSString stringWithFormat:@"%@",self.ketStr]];
    
    self.numBerLable.text = [NSString stringWithFormat:@"数量：%@   价格：￥%.2f   购买数量",dic[@"num"],[dic[@"price"] floatValue]];
    self.ggIdStr = [NSString stringWithFormat:@"%@",dic[@"id"]];
    
    self.numberlable.text = [NSString stringWithFormat:@"%ld",self.num];
    
    [self.listView reloadData];
    
}


- (IBAction)btnclick:(UIButton *)sender {
    KPreventRepeatClickTime(1)
    _payBlock(sender,self.num,self.ggIdStr);
}


- (IBAction)btnclicks:(UIButton *)sender {
    if (sender.tag == 300) {
        self.num -= 1;
        if (self.num <= 1) {
            self.num = 1;
        }
    }else if (sender.tag == 301){
        self.num +=1;
    }else{}
    
    NSDictionary *dic = [_listModel.pDict objectForKey:[NSString stringWithFormat:@"%@",self.ketStr]];
    
    self.numBerLable.text = [NSString stringWithFormat:@"数量：%@   价格：￥%.2f   购买数量",dic[@"num"],[[dic objectForKey:@"price"] floatValue]*self.num] ;
    self.ggIdStr = [NSString stringWithFormat:@"%@",dic[@"id"]];
    
    self.numberlable.text = [NSString stringWithFormat:@"%ld",self.num];
}


//MARK:-
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.dataArr)
        return [self.dataArr count];
    return 0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BeseListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BeseListViewCell"];
    
    if (!cell) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"BeseListViewCell" owner:self options:nil].lastObject;
    }
    
    
    if ([self.dataArr count] > 0) {
        BeseListListModel *model = self.dataArr[indexPath.section];
        cell.listlistModel = model;
        
    }
    
    cell.delegate = self;
    
    return cell;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    BeseListListModel *model = self.dataArr[section];
    
    UIView * v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 20)];
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(16, 0, KSCREEN_WIDTH-32, 20)];
    title.textColor = [UIColor blackColor];
    title.font = [UIFont systemFontOfSize:13];
    title.text = model.name;
    [v addSubview:title];
    
    return v;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}


-(void)didSelect:(UIButton *)btn{
    
    BeseListViewCell *mycell = (BeseListViewCell *)[btn superview].superview;
    self.num = 1;
    
    NSIndexPath *path = [self.listView indexPathForCell:mycell];
    BeseListListModel *mode = _listModel.resArr[path.section];
    
    [self.keyArr removeObjectAtIndex:path.section];
    [self.keyArr insertObject:mode.value[btn.tag] atIndex:path.section];
    
    NSMutableString *sKeyStr = [[NSMutableString alloc]init];
    
    for (int i = 0; i < [self.keyArr count]; i ++) {
        if (i == 0) {
            [sKeyStr appendString:[NSString stringWithFormat:@"%@",self.keyArr[i]]];
        }else{
            [sKeyStr appendString:[NSString stringWithFormat:@"-%@",self.keyArr[i]]];
        }
    }
    
    self.ketStr = [NSString stringWithString:sKeyStr];
    NSDictionary *dic = [_listModel.pDict objectForKey:[NSString stringWithFormat:@"%@",self.ketStr]];
    self.numBerLable.text = [NSString stringWithFormat:@"数量：%@   价格：￥%.2f   购买数量",dic[@"num"],[dic[@"price"] floatValue]];
    self.ggIdStr = [NSString stringWithFormat:@"%@",dic[@"id"]];
    self.numberlable.text = [NSString stringWithFormat:@"%ld",self.num];
    
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
