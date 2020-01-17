//
//  HomeTableViewCell.m
//  OgrinterProduct
//
//  Created by wongshine on 2019/11/28.
//  Copyright © 2019 RXF. All rights reserved.
//


#import "HomeTableViewCell.h"
#import "HomeCellModel.h"
#import "HXCollectionViewCell.h"
#import "WSLWaterFlowLayout.h"
#import "OnlineOrderModel.h"
#import "OnlineOrderListModel.h"


@interface HomeTableViewCell ()<UICollectionViewDelegate,UICollectionViewDataSource,WSLWaterFlowLayoutDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *mCollectionView1;
@property (weak, nonatomic) IBOutlet UICollectionView *mCollectionView2;

@property (weak, nonatomic) IBOutlet UIView *startbjView;

@property (weak, nonatomic) IBOutlet UILabel *title;

@property (weak, nonatomic) IBOutlet UIButton *dzbtn;



@end


@implementation HomeTableViewCell



- (void)awakeFromNib {
    [super awakeFromNib];
    
    // Initialization code
}


-(void)setup {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 10;
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    layout.itemSize = CGSizeMake(88,108);
    
    self.mCollectionView1.delegate = self;
    self.mCollectionView1.dataSource = self;
    [self.mCollectionView1 setCollectionViewLayout:layout];
    [self.mCollectionView1 registerNib:[UINib nibWithNibName:@"HXCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"HXCollectionViewCell"];
    
}


-(void)setupWith:(UICollectionView *)collectionView type:(CustomCellStyle)type{
    
    WSLWaterFlowLayout *mylayout = [[WSLWaterFlowLayout alloc]init];
    mylayout.delegate = self;
    
    [collectionView setCollectionViewLayout:mylayout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    
    [collectionView registerNib:[UINib nibWithNibName:@"HXCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"HXCollectionViewCell"];
    
}


-(void)setListmodel:(HomeCellModel *)listmodel {
    _listmodel = listmodel;
}


-(void)setModelist:(OnlineOrderModel *)modelist{
    _modelist = modelist;
    
    self.title.text = modelist.name;
    
    [self.dzbtn setTitle:[NSString stringWithFormat:@"  %@",modelist.praise_num] forState:0];
    [self setupStar:modelist.stars_all];
    [self.mCollectionView2 reloadData];
}


-(void)setListArr:(NSArray *)listArr{
    _listArr = listArr;
    [self.mCollectionView1 reloadData];
}


+ (instancetype)tempTableViewCellWith:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath{
    
    NSString *identifier = @"";
    NSInteger index = 0;
    switch (indexPath.section ) {
        case 0:
        case 1:
            
            identifier = @"HomeTableViewCellOne";
            index = 0;
            break;
            
        case 2:
        case 3:
            
            identifier = @"HomeTableViewCellTwo";
            index = 1;
            break;
            
        default:
            break;
    }
    
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        @try {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"HomeTableViewCell" owner:self options:nil] objectAtIndex:index];
        } @catch (NSException *exception) {
            NSLog(@"cell == exception %@",exception);
        } @finally {
            
        }
//        cell = [[[NSBundle mainBundle] loadNibNamed:@"HomeTableViewCell" owner:self options:nil] objectAtIndex:index];
        NSLog(@"创建");
    }
    
    return cell;
}


- (void)configTempCellWith:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:{
            _style = CustomCellStyleOne;
            [self setup];
            break;
        }
            
        case 1: {
            _style = CustomCellStyleTwo;
            [self setup];
            break;
        }
            
        case 2: {
            _style = CustomCellStyleThird;
            [self setupWith:self.mCollectionView2 type:_style];
            break;
        }
            
        case 3: {
            _style = CustomCellStyleFouth;
            [self setupWith:self.mCollectionView2 type:_style];
            break;
        }
            
        default:
            break;
    }
}


//MARK: - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (_style == CustomCellStyleOne) {
        return [_listArr count];
    }else if (_style == CustomCellStyleTwo){
        return 6;
    }else {
        return [_modelist.cai count];
    }
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
        
    HXCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HXCollectionViewCell" forIndexPath:indexPath];
    if (_style == CustomCellStyleOne) {
        cell.modelist0 = _listArr[indexPath.item];
    }else if (_style == CustomCellStyleTwo){
        cell.modelist1 = _listArr[indexPath.item];
        
    }else if (_style == CustomCellStyleThird || _style == CustomCellStyleFouth){
        if ([_modelist.cai count]) {
            cell.lmodelist1 = _modelist.cai[indexPath.item];
        }
        
    }else{}
    
    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    HomeTableViewCell *cell = nil;
    if (_style == CustomCellStyleThird || _style == CustomCellStyleFouth) {
        cell = (HomeTableViewCell *)self.mCollectionView2.superview.superview;
    }
    if (cell) {
        _mblock(cell.tag);
    }
}

//MARK:-
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

//MARK:-WSLWaterFlowLayout
- (CGSize)waterFlowLayout:(WSLWaterFlowLayout *)waterFlowLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (_style == CustomCellStyleOne || _style == CustomCellStyleTwo) {
        return CGSizeMake(88, 138);
        
    }else if (_style == CustomCellStyleThird || _style == CustomCellStyleFouth){
        
        if (_modelist) {
            if ([_modelist.cai count]%3 == 0)
                if (indexPath.item == 0)
                    return CGSizeMake(0, 148);
                else
                    return CGSizeMake(0, 69);
            else if([_modelist.cai count]%3 != 0)
                return CGSizeMake(KSCREEN_WIDTH-20, 148);
            else
                return CGSizeMake(0, 0);
        }else{return CGSizeMake(0, 0);}
    }
    return CGSizeMake(0, 0);
}

-(CGFloat)columnCountInWaterFlowLayout:(WSLWaterFlowLayout *)waterFlowLayout{
    if (_style == CustomCellStyleOne || _style == CustomCellStyleTwo){
        return 3;
        
    }else if (_style == CustomCellStyleThird || _style == CustomCellStyleFouth){
        if (_modelist)
            if ([_modelist.cai count]%3 == 0)
                return 2;
            else
                return 1;
        else
            return 0;
    }else {
        return 0;
    }
}

/** 行数*/
-(CGFloat)rowCountInWaterFlowLayout:(WSLWaterFlowLayout *)waterFlowLayout{
    if (_style == CustomCellStyleOne || _style == CustomCellStyleTwo){
        return 1;
    }else if (_style == CustomCellStyleThird || _style == CustomCellStyleFouth){
        return [_modelist.cai count];
    }else {
        return 0;
    
    }
}

/** 列间距*/
-(CGFloat)columnMarginInWaterFlowLayout:(WSLWaterFlowLayout *)waterFlowLayout{
    return 10;
}
/** 行间距*/
-(CGFloat)rowMarginInWaterFlowLayout:(WSLWaterFlowLayout *)waterFlowLayout{
    return 10;
}
/** 边缘之间的间距*/
-(UIEdgeInsets)edgeInsetInWaterFlowLayout:(WSLWaterFlowLayout *)waterFlowLayout{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

-(void)setupStar:(NSString *)num {
    for (int i = 0; i < [num integerValue]; i ++) {
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(8+i*17,3,12,12)];
        imgView.image = [UIImage imageNamed:@"start"];
        [self.startbjView addSubview:imgView];
    }
}


@end
