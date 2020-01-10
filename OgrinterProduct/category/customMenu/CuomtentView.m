//
//  CuomtentView.m
//  OgrinterProduct
//
//  Created by wongshine on 2020/1/9.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "CuomtentView.h"
#import "WSLWaterFlowLayout.h"
#import "CategoryCollectionViewCell.h"
#import "ShoperListModel.h"


@interface CuomtentView()<UICollectionViewDelegate,UICollectionViewDataSource,WSLWaterFlowLayoutDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *mCollectionView;
@property (nonatomic,strong)NSString *idStr;

@end

@implementation CuomtentView


-(void)setTypArr:(NSArray *)typArr{
    _typArr = typArr;
    [self.mCollectionView reloadData];
}


-(void)awakeFromNib{
    [super awakeFromNib];
    [self setup];
}


-(void)setup{
    
    WSLWaterFlowLayout *layout = [[WSLWaterFlowLayout alloc]init];
    
    layout.delegate = self;
    
    [self.mCollectionView setCollectionViewLayout:layout];
    
    self.mCollectionView.delegate = self;
    self.mCollectionView.dataSource = self;
    
    [self.mCollectionView registerNib:[UINib nibWithNibName:@"CategoryCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"CategoryCollectionViewCell"];
    
}


//MARK:-collection
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if ([_typArr count]>0) {
        return [_typArr count];
    }
    return 0;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CategoryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CategoryCollectionViewCell" forIndexPath:indexPath];
    
    if ([_typArr count] > 0) {
        ShoperListModel *list = _typArr[indexPath.item];
        
        cell.mlistm = list;
    }
    
    return cell;
    
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([_typArr count] > 0) {
        [self setcalcal];
        
        ShoperListModel *model1 = _typArr[indexPath.item];
        model1.iselect = !model1.iselect;
        self.idStr = model1.type_Id;
    }
    [self.mCollectionView reloadData];
}


//MARK:-WSLWaterFlowLayout
- (CGSize)waterFlowLayout:(WSLWaterFlowLayout *)waterFlowLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
        return CGSizeMake((self.mCollectionView.bounds.size.width-30)/2,30);
    
}


-(CGFloat)columnCountInWaterFlowLayout:(WSLWaterFlowLayout *)waterFlowLayout{
    return 2;
}

/** 行数*/
-(CGFloat)rowCountInWaterFlowLayout:(WSLWaterFlowLayout *)waterFlowLayout{
    if ([_typArr count]>0) {
        if ([_typArr count]%2 == 0)
            return [_typArr count]/2;
        else
            return [_typArr count]/2+1;
    }
    return 10;
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


//MARK:-
- (IBAction)selectBtn:(UIButton *)sender {
    KPreventRepeatClickTime(1)
    if (_delegate && [_delegate respondsToSelector:@selector(didselectSure:)]) {
        [_delegate didselectSure:self.idStr];
    }
}

- (IBAction)cancal:(UIButton *)sender {
    KPreventRepeatClickTime(1)
    if ([_typArr count] > 0) {
        [self setcalcal];
    }
}


-(void)setcalcal{
    [_typArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ShoperListModel *model = _typArr[idx];
        if (model.iselect) {
            model.iselect = NO;
        }
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
