//
//  ZBNPostBarCell.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/2/17.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNPostBarCell.h"
#import "ZBNSquareModel.h"
#import "ZBNPostImgCell.h"
#import "ZBNPostCommentCell.h"
#import "ZBNPostComModel.h"

@interface ZBNPostBarCell () <UICollectionViewDelegate, UICollectionViewDataSource>

/*! 用户头像 */
@property (weak, nonatomic) IBOutlet UIImageView *userIcon;
/*! 用户名 */
@property (weak, nonatomic) IBOutlet UILabel *userName;
/*! 指定图标 */
@property (weak, nonatomic) IBOutlet UIImageView *dingIcon;
/*! 标题 */
@property (weak, nonatomic) IBOutlet UILabel *title;
/*! 内容 */
@property (weak, nonatomic) IBOutlet UILabel *contentL;
/*! 时间 */
@property (weak, nonatomic) IBOutlet UILabel *time;
/*! 顶 */
@property (weak, nonatomic) IBOutlet UIButton *dingBtn;
/*! 评论 */
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;
/*! 分享 */
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
/*! 图片背景view */
@property (weak, nonatomic) IBOutlet UICollectionView *iconBackV;

@property (weak, nonatomic) IBOutlet UIImageView *comUserIcon;
@property (weak, nonatomic) IBOutlet UILabel *cUserName;
@property (weak, nonatomic) IBOutlet UILabel *cUserCom;
@property (weak, nonatomic) IBOutlet UILabel *countL;
@property (weak, nonatomic) IBOutlet UIView *cBackView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *height;

@property (nonatomic, strong) NSMutableArray *comArr;

@end

@implementation ZBNPostBarCell

static NSString * const ZBNimgCellId = @"img";

// 设置模型数据
- (void)setSquareM:(ZBNSquareModel *)squareM
{
    // 保存数据
    _squareM = squareM;
    // 设置头像
    self.userIcon.image =  [UIImage circleImageNamed:squareM.userIcon];
    // 设置名字
    self.userName.text = squareM.userName;
    // 如果是置顶的显示图标反之隐藏
    if (squareM.isDing) {
        self.dingIcon.hidden = NO;
    } else {
        self.dingIcon.hidden = YES;
    }
    // 标题
    self.title.text = squareM.title;
    // 内容
    self.contentL.text = squareM.contentL;
    // 时间
    self.time.text = squareM.time;
    
    if (squareM.cUserName) {
        self.cBackView.hidden = NO;
    } else {
        self.cBackView.hidden = YES;
    }
    
    if (squareM.hasImg) {
        self.iconBackV.hidden = NO;
        self.height.constant = 130;
    } else {
        self.iconBackV.hidden = YES;
        self.height.constant = 15;
    }
    
    self.cUserName.text = squareM.cUserName;
    self.comUserIcon.image = [UIImage circleImageNamed:squareM.cUserIcon];
    self.cUserCom.text = squareM.cUserCom;
    self.countL.text = [NSString stringWithFormat:@"共%@条回复>",squareM.cComCount];
}

// 从xib中加载调用
- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self initComArr];
    
    // 设置中间的img
    [self setupCollectionView];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
}

- (void)initComArr
{
    for (int i = 0; i < 2; i ++) {
        ZBNPostComModel *model = [[ZBNPostComModel alloc] init];
        model.count = @"9";
        model.comment = @"垃圾哈哈哈哈哈垃圾哈哈哈哈哈垃圾哈哈哈哈哈垃圾哈哈哈哈哈";
        model.userName = @"yes";
        model.userIcon = @"yxj";
        [self.comArr addObject:model];
    }
}

#pragma mark -- UI
// 设置UI界面
- (void)setupUI
{
    
}

// 设置图片背景view
- (void)setupCollectionView
{
    [self.iconBackV registerNib:[UINib nibWithNibName:NSStringFromClass([ZBNPostImgCell class]) bundle:nil] forCellWithReuseIdentifier:ZBNimgCellId];
    self.iconBackV.delegate = self;
    self.iconBackV.dataSource = self;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
  
    // 设置没一行的间距
    layout.minimumLineSpacing = 0;
    // 设置每个cell的间距
//    layout.minimumInteritemSpacing = 1;
    // 设置cell的尺寸
      CGFloat itemWidth = 0;
      itemWidth = self.iconBackV.width / 3 - 10;
      layout.itemSize = CGSizeMake(itemWidth , self.iconBackV.height);
    
    self.iconBackV.collectionViewLayout = layout;
    
    NSLog(@"ahahhahahahahhahacoleection");
}


#pragma mark -- 按钮点击事件
// 顶的点击
- (IBAction)dingBtnClick:(UIButton *)sender {
}
// 评论点击
- (IBAction)commentBtnClick:(id)sender {
}
// 分享点击
- (IBAction)shareBtnClick:(id)sender {
    if (self.shareBtnClickTask) {
        self.shareBtnClickTask(self.squareM);
    }
}

// 设置frame
- (void)setFrame:(CGRect)frame
{
    // 设置中间额分割线
    frame.size.height -= 10;
    [super setFrame:frame];
    
}

#pragma mark -- collection
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZBNPostImgCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ZBNimgCellId forIndexPath:indexPath];
    cell.image = @"yxj";
    return cell;
}


- (NSMutableArray *)comArr
{
    if (!_comArr) {
        _comArr = [NSMutableArray array];
    }
    return _comArr;
}

@end
