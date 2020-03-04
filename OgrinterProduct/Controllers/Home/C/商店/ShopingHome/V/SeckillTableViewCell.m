//
//  SeckillTableViewCell.m
//  OgrinterProduct
//
//  Created by wongshine on 2019/12/12.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "SeckillTableViewCell.h"
#import "ShopDetalisModel.h"
#import "KillModelt.h"
#import "PtTableViewCell.h"
#import "KillerbListModel.h"
#import "NSObject+Timecutdow.h"


@interface SeckillTableViewCell()<UITableViewDelegate,UITableViewDataSource>{
    
    BOOL select;
}

@property (weak, nonatomic) IBOutlet UITableView *table;

//一般的产品
@property (weak, nonatomic) IBOutlet UILabel *cpName;
@property (weak, nonatomic) IBOutlet UILabel *cPrice;
@property (weak, nonatomic) IBOutlet UIButton *scBtn;


//秒杀的产品


//公共的参数
@property (weak, nonatomic) IBOutlet UILabel *kdLabel;//货运方式
@property (weak, nonatomic) IBOutlet UILabel *xLabel;//销量
@property (weak, nonatomic) IBOutlet UILabel *kcLabel;//库存

@property (weak, nonatomic) IBOutlet UIImageView *shopIcon;
@property (weak, nonatomic) IBOutlet UILabel *shopName;
@property (weak, nonatomic) IBOutlet UILabel *shopcontent;



@end

@implementation SeckillTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.table.delegate = self;
    self.table.dataSource = self;
    
    
    [self.table registerNib:[UINib nibWithNibName:@"PtTableViewCell" bundle:nil] forCellReuseIdentifier:@"PtTableViewCell"];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setKmodelist:(KillModelt *)kmodelist{
    _kmodelist = kmodelist;
    
//    self.cpName.text = kmodelist.name;
    self.cPrice.text = [NSString stringWithFormat:@"团购价格:￥%@",kmodelist.price];
    
    self.kdLabel.text = [NSString stringWithFormat:@"运费：%@",kmodelist.storage];
    self.xLabel.text = [NSString stringWithFormat:@"销量：%@",kmodelist.sale_total];
    self.kcLabel.text = [NSString stringWithFormat:@"库存：%@",kmodelist.storage];
    
    [self.table reloadData];
    
}


//设置一般的产品详情
-(void)setDmodelist:(ShopDetalisModel *)dmodelist{
    _dmodelist = dmodelist;
    
    self.cpName.text = _dmodelist.name;
    self.cPrice.text = [NSString stringWithFormat:@"￥%@",_dmodelist.price];
    
    self.kdLabel.text = [NSString stringWithFormat:@"运费：%@",_dmodelist.dilivery];
    self.xLabel.text = [NSString stringWithFormat:@"销量：%@",_dmodelist.volume];
    self.kcLabel.text = [NSString stringWithFormat:@"库存：%@",_dmodelist.store_num];
    
    [self.shopIcon sd_setImageWithURL:[NSURL URLWithString:_dmodelist.logoimg]];
    self.shopName.text = [NSString stringWithFormat:@"%@",_dmodelist.logoName];
//    self.shopcontent.text = [NSString stringWithFormat:@"%@",_dmodelist.logo];
    
    if ([_dmodelist.is_collection integerValue] == 0) {
        self.scBtn.selected = NO;
    }else if ([_dmodelist.is_collection integerValue] == 1) {
        self.scBtn.selected = YES;
    }
}


+ (instancetype)tempTableViewCellWith:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath type:(ShopSeckillDetailsType)type{
    
    NSString *identifier = @"";
    NSInteger index = 0;
    
    if (type == ShopSeckillDetailsTypeKill) {
        
        if (indexPath.row == 0) {
            identifier = @"SeckillTableViewCellOne";
            index = 0;
        } else if (indexPath.row == 1) {
            identifier = @"SeckillTableViewCellTwo";
            index = 1;
        }else if (indexPath.row == 2) {
            identifier = @"SeckillTableViewCellFouth";
            index = 3;
        }else if (indexPath.row == 3) {
            identifier = @"SeckillTableViewCellSix";
            index = 5;
        }else{}
        
    }else if (type == ShopSeckillDetailsTypeOrder){
        if (indexPath.row == 0) {
            identifier = @"SeckillTableViewCellThrid";
            index = 2;
        }else if (indexPath.row == 1) {
            identifier = @"SeckillTableViewCellFouth";
            index = 3;
        }else if (indexPath.row == 2) {
            identifier = @"SeckillTableViewCellFive";
            index = 4;
        }else if (indexPath.row == 3) {
            identifier = @"SeckillTableViewCellSix";
            index = 5;
        }
    }else if (type == ShopSeckillDetailsTypeOther){
        if (indexPath.row == 0) {
            identifier = @"SeckillTableViewCellThrid";
            index = 2;
        }else if (indexPath.row == 1) {
            identifier = @"SeckillTableViewCellFouth";
            index = 3;
        }else if (indexPath.row == 2) {
            identifier = @"SeckillTableViewCellSix";
            index = 5;
        }else if (indexPath.row == 3) {
            identifier = @"SeckillTableViewCellSenver";
            index = 6;
        }
        
    }else {
        
    }
    
    
    SeckillTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SeckillTableViewCell" owner:self options:nil] objectAtIndex:index];
        NSLog(@"创建");
    }
    
    return cell;
}


- (void)configTempCellWith:(NSIndexPath *)indexPath {
    if (indexPath.row != 3) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }else {
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
    }
}


//普通的= 收藏
- (IBAction)sclick:(UIButton *)sender {
    KPreventRepeatClickTime(1)
    _selectBlock(sender);
}


//秒杀的 收藏
- (IBAction)msclick:(UIButton *)sender {
    KPreventRepeatClickTime(1)
    _selectBlock(sender);
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_kmodelist.team_list count];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PtTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PtTableViewCell"];
    if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"PtTableViewCell" owner:self options:nil] objectAtIndex:0];
        
        NSLog(@"创建");
    }
    
    if ([_kmodelist.team_list count]) {
        KillerbListModel *mode = _kmodelist.team_list[indexPath.row];
        [cell setTStr:[NSObject intervalFromLastDate:_kmodelist.finish_time with:_kmodelist.now]];
        cell.llmodel = mode;
    }
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 64;
}


-(void)dealloc{
    NSLog(@"释放---");
}


@end
