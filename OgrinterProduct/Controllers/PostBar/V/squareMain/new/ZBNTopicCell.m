//
//  ZBNTopicCell.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/3/5.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNTopicCell.h"
#import "ZBNSquareModel.h"
#import "ZBNPostUserModel.h"
#import "ZBNTopicFrame.h"
#import "ZBNTopicCommentCell.h"
#import "ZBNTopicComFrame.h"
#import "ZBNPostImageCell.h"
#import "SDPhotoBrowser.h"
#import "ZBNPostPhotoItem.h"

@interface ZBNTopicCell () <UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate,UICollectionViewDataSource,SDPhotoBrowserDelegate>
/*! 头像 */
@property (nonatomic, weak) UIImageView *avatarView;
/*! 昵称 */
@property (nonatomic, weak) YYLabel *nickName;
/*! 置顶 */
@property (nonatomic, weak) UIImageView *topView;
/*! 标题 */
@property (nonatomic, weak) YYLabel *title;
/*! 内容 */
@property (nonatomic, weak) YYLabel *contentL;
/*! 时间 */
@property (nonatomic, weak) YYLabel *createTime;
/*! 图片 */
@property (nonatomic, weak) UICollectionView *contentBaseView;
/*! thumbBtn点赞 */
@property (nonatomic, weak) UIButton *thumbBtn;
/*! 评论 */
@property (nonatomic, weak) UIButton *commentBtn;
/*! 分享 */
@property (nonatomic, weak) UIButton *shareBtn;
/*!  底部评论视图 */
@property (nonatomic, weak) UITableView *tableV;

@property (nonatomic, strong) NSMutableArray *images;
@property (nonatomic, weak) UIView *line;
@end

@implementation ZBNTopicCell

static NSString * const ZBNPostImgCellID = @"postImg";

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"TopicCell";
    ZBNTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        NSLog(@"....cell嵌套tableView.....创建话题cell...");
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return cell;
}


- (NSMutableArray *)images
{
    if (!_images) {
        _images = [NSMutableArray array];
    }
    return _images;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self  = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        // 初始化
        [self _setup];
        // 创建子控件
        [self _setupSubViews];
        // 布局子控件
        [self _makeSubViewsConstraints];
    }
    return self;
}

- (void)setTopicFrame:(ZBNTopicFrame *)topicFrame
{
    _topicFrame = topicFrame;
    ZBNSquareModel *squareM = topicFrame.topic;
    //头像
    [self.avatarView setHeader:squareM.avator];
    self.avatarView.frame = topicFrame.avatarFrame;
    // 名字
    self.nickName.text = squareM.name;
    self.nickName.frame = topicFrame.nicknameFrame;
    // 是否置顶
    if (squareM.top_post == YES) {
        self.topView.hidden = NO;
    } else {
        self.topView.hidden = YES;
    }
    self.topView.frame = topicFrame.topFrame;
    // 标题
    self.title.text = squareM.title;
    self.title.frame = topicFrame.titleFrame;
    // 内容
    self.contentL.text = squareM.content;
    self.contentL.frame = topicFrame.textFrame;
    // 图片数据
    self.contentBaseView.frame = topicFrame.imgFrame;
    for (int i = 0; i < squareM.images.count; i++) {
        ZBNPostPhotoItem *item = [[ZBNPostPhotoItem alloc] init];
        item.imageName = squareM.images[i];
        [self.images addObject:item];
    }
    // 时间
    self.createTime.text  =squareM.created_at;
    self.createTime.frame = topicFrame.createTimeFrame;
    // 点赞
    [self.thumbBtn setTitle:[NSString stringWithFormat:@" %@",squareM.vote] forState:UIControlStateNormal];
    self.thumbBtn.frame = topicFrame.thumbFrame;
    // 评论
    [self.commentBtn setTitle:[NSString stringWithFormat:@" %@",squareM.comment_count] forState:UIControlStateNormal];
    self.commentBtn.frame = topicFrame.commentFrame;
    // 分享
    [self.shareBtn setTitle:[NSString stringWithFormat:@" %@",squareM.share] forState:UIControlStateNormal];
    self.shareBtn.frame = topicFrame.shareFrame;
    // 评论
    self.tableV.frame = topicFrame.tableViewFrame;
    [self.contentBaseView reloadData];
    [self.tableV reloadData];
}



#pragma mark -- 辅助方法

- (void)_setup
{
    self.contentView.backgroundColor = [UIColor whiteColor];
}

- (void)_setupSubViews
{
    ADWeakSelf;
    // 头像
    UIImageView *avatar = [[UIImageView alloc] init];
    self.avatarView = avatar;
    [self.contentView addSubview:avatar];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_avatarOrNicknameDidClicked)];
    [avatar addGestureRecognizer:tap];
    // 昵称
    YYLabel *nickName = [[YYLabel alloc] init];
    nickName.text = @"";
    nickName.font = [UIFont systemFontOfSize:14];
    nickName.textAlignment = NSTextAlignmentLeft;
    nickName.textColor = [UIColor blackColor];
    [self.contentView addSubview:nickName];
    self.nickName = nickName;
    nickName.textTapAction = ^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        [weakSelf _avatarOrNicknameDidClicked];
    };
    // 置顶
    UIImageView *topImageV = [[UIImageView alloc] init];
    topImageV.image = [UIImage imageNamed:@"zhiding18"]; 
    self.topView = topImageV;
    [self.contentView addSubview:topImageV];
    // 标题
    YYLabel *title = [[YYLabel alloc] init];
    title.text = @"";
    title.font = [UIFont systemFontOfSize:14];
    title.textAlignment = NSTextAlignmentLeft;
    title.textColor = [UIColor blackColor];
    [self.contentView addSubview: title];
    self.title = title;
    // 内容
    YYLabel *contentL = [[YYLabel alloc ] init];
    contentL.font = [UIFont systemFontOfSize:13];
    UIEdgeInsets textContainerInset = contentL.textContainerInset;
    textContainerInset.top = 5;
    textContainerInset.bottom = 5;
    contentL.textContainerInset = textContainerInset;
    contentL.numberOfLines = 0;
    contentL.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:contentL];
    self.contentL = contentL;
    // 内容图片展示区域
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = 5;
    layout.minimumLineSpacing = 5;
    CGFloat itemW = (KSCREEN_WIDTH - 45) / 3;
    CGFloat itemH = itemW;
    layout.itemSize = CGSizeMake(itemW, itemH);
    UICollectionView *imgView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:layout];
    imgView.backgroundColor = [UIColor whiteColor];
    imgView.delegate = self;
    imgView.dataSource = self;
    [self.contentView addSubview:imgView];
    self.contentBaseView = imgView;
    [self.contentBaseView registerClass:[ZBNPostImageCell class] forCellWithReuseIdentifier:ZBNPostImgCellID];
    // 时间
    YYLabel *createL = [[YYLabel alloc] init];
    createL.text = @"";
    createL.font = [UIFont systemFontOfSize:13];
    createL.textAlignment = NSTextAlignmentLeft;
    createL.textColor = KSRGBA(100, 100, 100, 1);
    [self.contentView addSubview:createL];
    self.createTime = createL;
    // 点赞
    UIButton *thumbBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    thumbBtn.adjustsImageWhenHighlighted = NO;
    [thumbBtn setImage:[UIImage imageNamed:@"ding2"] forState:UIControlStateNormal];
    [thumbBtn setTitleColor:KSRGBA(100, 100, 100, 1) forState:UIControlStateNormal];
    [thumbBtn addTarget:self action:@selector(_thumbBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
    thumbBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:thumbBtn];
    self.thumbBtn = thumbBtn;
    // 评论
    UIButton *commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    commentBtn.adjustsImageWhenHighlighted = NO;
    [commentBtn setImage:[UIImage imageNamed:@"pinglun24"] forState:UIControlStateNormal];
     [commentBtn setTitleColor:KSRGBA(100, 100, 100, 1) forState:UIControlStateNormal];
    [commentBtn addTarget:self action:@selector(_commentBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
    commentBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:commentBtn];
    self.commentBtn = commentBtn;
    // 分享
    UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    shareBtn.adjustsImageWhenHighlighted = NO;
    [shareBtn setImage:[UIImage imageNamed:@"fenxiang26"] forState:UIControlStateNormal];
    [shareBtn setTitleColor:KSRGBA(100, 100, 100, 1) forState:UIControlStateNormal];
    shareBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [shareBtn addTarget:self action:@selector(_shareBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:shareBtn];
    self.shareBtn = shareBtn;
    // 底部评论视图
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor yellowColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.bounces = NO;
    tableView.scrollEnabled = NO;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.showsHorizontalScrollIndicator = NO;
    [self.contentView addSubview:tableView];
    self.tableV = tableView;
    // 分割线
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = KSRGBA(241, 241, 241, 1);
    [self.contentView addSubview:line];
    self.line = line;
}

- (void)_makeSubViewsConstraints
{
    
}


#pragma mark - UITableViewDelegate , UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  self.topicFrame.commentFrames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZBNTopicCommentCell *cell = [ZBNTopicCommentCell cellWithTableView:tableView];
    ZBNTopicComFrame *frame = self.topicFrame.commentFrames[indexPath.row];
    cell.commentFrame = frame;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZBNTopicComFrame *frame = self.topicFrame.commentFrames[indexPath.row];
    return frame.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.cellIncellDidClick) {
        self.cellIncellDidClick(self);
    }
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.topicFrame.topic.images.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    ZBNPostImageCell *cell  = [collectionView dequeueReusableCellWithReuseIdentifier:ZBNPostImgCellID forIndexPath:indexPath];
    cell.photoItem = self.images[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    SDPhotoBrowser *photoBrowser = [SDPhotoBrowser new];
    photoBrowser.delegate = self;
    photoBrowser.currentImageIndex = indexPath.item;
    photoBrowser.imageCount = self.images.count;
    photoBrowser.sourceImagesContainerView = self.contentBaseView;
    [photoBrowser show];

}

#pragma mark  SDPhotoBrowserDelegate


// 返回临时占位图片（即原来的小图）
- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    // 不建议用此种方式获取小图，这里只是为了简单实现展示而已
    ZBNPostImageCell *cell = (ZBNPostImageCell *)[self collectionView:self.contentBaseView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];

    return cell.imageView.image;

}

// 解决重用数据错乱
- (void)prepareForReuse
{
    [super prepareForReuse];
    self.images = nil;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
   
    self.line.frame = CGRectMake(0, self.height - 10, KSCREEN_WIDTH, 10);
}

#pragma mark -- shijian

- (void)_avatarOrNicknameDidClicked
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(topicCellDidClickUser:)]) {
        [self.delegate topicCellDidClickUser:self];
    }
}


- (void)_thumbBtnDidClick
{
    if ([self.delegate respondsToSelector:@selector(topicDidClickThumbBtn:)] && self.delegate) {
        [self.delegate topicDidClickThumbBtn:self];
    }

    if (self.topicFrame.topic.is_vote == 0) {
         NSInteger count = self.topicFrame.topic.vote.integerValue + 1;
        NSNumber *vote1 = [NSNumber numberWithInteger:count];
        [self.thumbBtn setTitle:[NSString stringWithFormat:@" %zd",count] forState:UIControlStateNormal];
        [self.topicFrame.topic setVote:vote1];
        self.topicFrame.topic.is_vote = 1;
    } else {
        NSInteger count = self.topicFrame.topic.vote.integerValue - 1;
        NSNumber *vote1 = [NSNumber numberWithInteger:count];
        [self.thumbBtn setTitle:[NSString stringWithFormat:@" %zd",count] forState:UIControlStateNormal];
        [self.topicFrame.topic setVote:vote1];
        self.topicFrame.topic.is_vote = 0;
    }
    
    
}

- (void)_commentBtnDidClick
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(topicDidClickCommentBtn:)]) {
        [self.delegate topicDidClickCommentBtn:self];
    }
}

- (void)_shareBtnDidClick
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(topicDidClickShareBtn:)]) {
        [self.delegate topicDidClickShareBtn:self];
    }
}

@end
