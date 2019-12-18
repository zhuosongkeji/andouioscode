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


@interface HomeTableViewCell ()<UICollectionViewDelegate,UICollectionViewDataSource,WSLWaterFlowLayoutDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *mCollectionView1;
@property (weak, nonatomic) IBOutlet UICollectionView *mCollectionView2;

@property (weak, nonatomic) IBOutlet UIView *startbjView;



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
    
    [self setupStar];
    
    [collectionView setCollectionViewLayout:mylayout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    
    [collectionView registerNib:[UINib nibWithNibName:@"HXCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"HXCollectionViewCell"];
    
}


-(void)setListmodel:(HomeCellModel *)listmodel {
    _listmodel = listmodel;
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
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HomeTableViewCell" owner:self options:nil] objectAtIndex:index];
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
    if (_style == CustomCellStyleOne || _style == CustomCellStyleTwo) {
        return 6;
    }else {
        return 3;
    }
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
        
    HXCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HXCollectionViewCell" forIndexPath:indexPath];
    if (_style == CustomCellStyleOne) {
        [cell.imgView1 setHidden:YES];
        [cell.lable1 setHidden:YES];
        [cell.imgView setHidden:NO];
        [cell.name setHidden:NO];
        
    }else if (_style == CustomCellStyleTwo){
        [cell.imgView1 setHidden:NO];
        [cell.lable1 setHidden:NO];
        [cell.imgView setHidden:YES];
        [cell.name setHidden:YES];
        cell.imgView1.image = [UIImage imageNamed:@"533"];
        
    }else if (_style == CustomCellStyleThird || _style == CustomCellStyleFouth){
        [cell.imgView1 setHidden:NO];
        [cell.lable1 setHidden:YES];
        [cell.imgView setHidden:YES];
        [cell.name setHidden:YES];
        cell.imgView1.image = [UIImage imageNamed:@"图层 520"];
        
    }else{}
    
    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
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
    }else if (_style == CustomCellStyleThird){
        return CGSizeMake((KSCREEN_WIDTH-40)/3, 108);
    }else if (_style == CustomCellStyleFouth){
        if (indexPath.item == 0) {
            return CGSizeMake(2*(KSCREEN_WIDTH-30)/3, 148);
        }else{
            return CGSizeMake((KSCREEN_WIDTH-30)/3, 69);
        }
    }
    return CGSizeMake(0, 0);
}

-(CGFloat)columnCountInWaterFlowLayout:(WSLWaterFlowLayout *)waterFlowLayout{
    if (_style == CustomCellStyleOne || _style == CustomCellStyleTwo || _style == CustomCellStyleThird){
        return 3;
    }else if (_style == CustomCellStyleFouth){
        return 2;
    }else {
        return 0;
    }
}

/** 行数*/
-(CGFloat)rowCountInWaterFlowLayout:(WSLWaterFlowLayout *)waterFlowLayout{
    if (_style == CustomCellStyleOne || _style == CustomCellStyleTwo || _style == CustomCellStyleThird){
        return 1;
    }else if (_style == CustomCellStyleFouth){
        return 2;
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

-(void)setupStar {
    for (int i = 0; i < 5; i ++) {
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(8+i*17,3,12,12)];
        imgView.image = [UIImage imageNamed:@"start"];
        [self.startbjView addSubview:imgView];
    }
}


@end
