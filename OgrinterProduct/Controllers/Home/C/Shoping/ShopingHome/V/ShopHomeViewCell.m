//
//  ShopHomeViewCell.m
//  OgrinterProduct
//
//  Created by wongshine on 2019/12/4.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ShopHomeViewCell.h"
#import "WSLWaterFlowLayout.h"
#import "ShopCollectionViewCell.h"

@interface ShopHomeViewCell ()<UICollectionViewDelegate,UICollectionViewDataSource,WSLWaterFlowLayoutDelegate>

@property (nonatomic,strong)NSMutableArray *shops;
@property (weak, nonatomic) IBOutlet UICollectionView *mCollectionView;

@end

@implementation ShopHomeViewCell

//MARK:-
-(NSMutableArray *)shops{
    
    if (!_shops) {
        _shops = [NSMutableArray array];
    }
    return _shops;
}

//MARK:- setup
-(void)setup{
    
    WSLWaterFlowLayout *layout = [[WSLWaterFlowLayout alloc]init];
    layout.delegate = self;
    
    [self.mCollectionView setCollectionViewLayout:layout];
    self.mCollectionView.delegate = self;
    self.mCollectionView.dataSource = self;
    
    [self.mCollectionView registerNib:[UINib nibWithNibName:@"ShopCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"ShopCollectionViewCell"];
}


//MARK:-collection
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ShopCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ShopCollectionViewCell" forIndexPath:indexPath];
    //    cell.shop = self.shops[indexPath.item];
    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}


//MARK:-WSLWaterFlowLayout
- (CGSize)waterFlowLayout:(WSLWaterFlowLayout *)waterFlowLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((KSCREEN_WIDTH-30)/2,234);
}

-(CGFloat)columnCountInWaterFlowLayout:(WSLWaterFlowLayout *)waterFlowLayout{
    return 2;
}
/** 行数*/
-(CGFloat)rowCountInWaterFlowLayout:(WSLWaterFlowLayout *)waterFlowLayout{
    return 5;
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


- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setup];
    // Initialization code
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
