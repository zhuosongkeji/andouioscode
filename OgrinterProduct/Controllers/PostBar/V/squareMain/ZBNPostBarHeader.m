//
//  ZBNPostBarHeader.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/2/20.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNPostBarHeader.h"
#import "ZBNSquareModel.h"
#import "ZBNPostUserModel.h"
#import "ZBNSquareFrame.h"
#import "ZBNPostImageCell.h"
#import "SDPhotoBrowser.h"

@interface ZBNPostBarHeader () <UICollectionViewDelegate, UICollectionViewDataSource,SDPhotoBrowserDelegate>

/*! 内容 */
@property (nonatomic, weak) YYLabel *contentLabel;
// 用户头像
@property (weak, nonatomic) IBOutlet UIImageView *userIcon;
// 用户名
@property (weak, nonatomic) IBOutlet UILabel *userName;
// 置顶
@property (weak, nonatomic) IBOutlet UIImageView *setTop;
// 标题
@property (weak, nonatomic) IBOutlet UILabel *titleL;
// 时间
@property (weak, nonatomic) IBOutlet UILabel *createTime;
// 点赞数
@property (weak, nonatomic) IBOutlet UIButton *dingBtn;
// 分享数
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
// 评论数
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;
// 图片背景
@property (nonatomic, weak) UICollectionView *imageBackV;

@end

@implementation ZBNPostBarHeader

static NSString * const ZBNPostImgCellID = @"postImg";

+ (instancetype)headerViewWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"TopicHeader";
    ZBNPostBarHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    if (header == nil) {
        // 缓存池中没有, 自己创建
        NSLog(@"....创建表头...");
        header = [[NSBundle mainBundle] loadNibNamed:@"ZBNPostBarHeader" owner:nil options:nil].lastObject;
    }
    return header;
}


- (void)setSquareFrame:(ZBNSquareFrame *)squareFrame
{
    _squareFrame = squareFrame;
    
    ZBNSquareModel *squareM = squareFrame.squareM;
    ZBNPostUserModel *userM = squareM.userM;
    // 点赞数
    [self.dingBtn setTitle:squareM.thumbNums forState:UIControlStateNormal];
    // 分享数
    [self.shareBtn setTitle:squareM.shareCount forState:UIControlStateNormal];
    // 评论数
    [self.commentBtn setTitle:squareM.commentCount forState:UIControlStateNormal];
    // 时间
    self.createTime.text = squareM.create_time;
    // 头像
    [self.userIcon setHeader:userM.avatarUrl];
    // 名称
    self.userName.text = userM.nickname;
    // 置顶
    if (squareM.isTop) {
        self.setTop.hidden = NO;
    } else {
        self.setTop.hidden = YES;
    }
    // title
    self.titleL.text = squareM.title;
    // content
    self.contentLabel.frame = squareFrame.contentFrame;
    self.contentLabel.attributedText = squareM.attributedText;
    // 图片
    self.imageBackV.frame = squareFrame.imageFrame;
    if (squareM.images) {
        
    }
    
    
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
     [self setupSubView];
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
   
}



- (void)setupSubView
{
    
    // 文本
    YYLabel *contentLabel = [[YYLabel alloc] init];
    // 设置文本的额外区域,修复用户点击事件
    UIEdgeInsets textContainerInset = contentLabel.textContainerInset;
    textContainerInset.bottom = 15;
    contentLabel.textContainerInset = textContainerInset;
    contentLabel.numberOfLines = 0;
    contentLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:contentLabel];
    self.contentLabel = contentLabel;
    // 设置代理
    
    // 图片view
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = 5;
    layout.minimumLineSpacing = 5;
    CGFloat itemW = (KSCREEN_WIDTH - 45) / 3;
    CGFloat itemH = itemW;
    layout.itemSize = CGSizeMake(itemW, itemH);
    UICollectionView *imgView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:layout];
    [self.contentView addSubview:imgView];
    imgView.backgroundColor = [UIColor clearColor];
    ADWeakSelf;
    imgView.delegate = weakSelf;
    imgView.dataSource = weakSelf;
    self.imageBackV = imgView;
    [self.imageBackV registerClass:[ZBNPostImageCell class] forCellWithReuseIdentifier:ZBNPostImgCellID];
}


#pragma mark -- 事件监听
// 点赞
- (IBAction)dingBtnClick:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(squareHeaderDidClickDingBtn:)]) {
        [self.delegate squareHeaderDidClickDingBtn:self];
    }
}
// 点击评论
- (IBAction)commentBtnClick:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(squareHeaderDidClickCommentBtn:)]) {
        [self.delegate squareHeaderDidClickCommentBtn:self];
    }
}
// 点击分享
- (IBAction)shareBtnClick:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(squareHeaderDidClickShareBtn:)]) {
        [self.delegate squareHeaderDidClickShareBtn:self];
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.squareFrame.squareM.images.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZBNPostImageCell *cell  = [collectionView dequeueReusableCellWithReuseIdentifier:ZBNPostImgCellID forIndexPath:indexPath];
    cell.image = [UIImage imageNamed:self.squareFrame.squareM.images[indexPath.row]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    SDPhotoBrowser *photoBrowser = [SDPhotoBrowser new];
    photoBrowser.delegate = self;
    photoBrowser.currentImageIndex = indexPath.item;
    photoBrowser.imageCount = self.squareFrame.squareM.images.count;
    photoBrowser.sourceImagesContainerView = self.imageBackV;
    [photoBrowser show];
    
}

#pragma mark  SDPhotoBrowserDelegate

// 返回临时占位图片（即原来的小图）
- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    // 不建议用此种方式获取小图，这里只是为了简单实现展示而已
    ZBNPostImageCell *cell = (ZBNPostImageCell *)[self collectionView:self.imageBackV cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
    
    return cell.image;

}





@end
