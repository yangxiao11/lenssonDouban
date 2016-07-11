//
//  VideosViewController.m
//  LessonVideo
//
//  Created by CLT on 16/7/8.
//  Copyright © 2016年 yaxin.guo. All rights reserved.
//

#import "VideosViewController.h"
#import "VedioCollectionViewCell.h"
#import "VideoRequest.h"
#import "VideoModel.h"

#import "VideoDetailRequest.h"
#import "VideoDetailModel.h"
#import "PlayerView.h"

@interface VideosViewController()
<
    UICollectionViewDataSource,
    UICollectionViewDelegate,
    UICollectionViewDelegateFlowLayout,
    VedioCollectionViewCellDelegate
>
//布局形式
@property (nonatomic, assign) NSInteger layoutType;

@property (nonatomic, strong) NSMutableArray *videos;

//播放视频所需要的view
@property (nonatomic, strong) PlayerView *playerView;

//获得当前播放视频的cell
@property (nonatomic, strong) VedioCollectionViewCell *currentCell;

@property (nonatomic, strong) NSIndexPath *currentPath;
@property (nonatomic, assign) BOOL isPlaying;
@property (nonatomic, assign) BOOL isOnCell;
@property (nonatomic, strong) NSArray *visibleIndexPaths;
@end

@implementation VideosViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.videos = [NSMutableArray array];
    //0 是1行显示两个item
    self.layoutType = 0;
    self.isOnCell = NO;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    layout.itemSize = CGSizeMake(WindownWidth / 2.0, 166);
    self.videoCollectionView.collectionViewLayout = layout;
    
    [self.videoCollectionView registerNib:[UINib nibWithNibName:@"VedioCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:VedioCollectionViewCell_Identify];
    [self addRightItem];
    if (self.sourceFrom == 0)
    {
        //dota
        [self requestDotaVedios];
    }
    else if (self.sourceFrom == 1)
    {
        //lol
        [self requestLOLVideos];
    }
}

- (void)addRightItem
{
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(changeLayoutType:)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)requestDotaVedios
{
    __weak typeof(self) weakSelf = self;
    [[VideoRequest shareVideoRequest] requestDotaSingleAuthorAllVideoWithAuthorID:self.authorID success:^(NSDictionary *dic) {
        NSLog(@"dota video success = %@", dic);
        weakSelf.videos = [VideoModel parseVideoWithDic:dic];
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.videoCollectionView reloadData];
        });
    } failure:^(NSError *error) {
        NSLog(@"dota error = %@", error);
    }];
    
 
}

//请求lol视频
- (void)requestLOLVideos
{
    __weak typeof(self) weakSelf = self;
    [[VideoRequest shareVideoRequest] requestLOLSingleAuthorAllVideoWithAuthorID:self.authorID success:^(NSDictionary *dic) {
        NSLog(@"lol video success = %@", dic);
        
        weakSelf.videos = [VideoModel parseVideoWithDic:dic];
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.videoCollectionView reloadData];
        });

    } failure:^(NSError *error) {
        NSLog(@"lol error = %@", error);
    }];
}

- (void)changeLayoutType:(UIBarButtonItem *)item
{
    if (self.layoutType == 0) {
        self.layoutType = 1;
    }
    else if (self.layoutType == 1) {
        self.layoutType = 0;
    }
    else {
        
    }
    [self.videoCollectionView reloadData];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.layoutType == 0) {
        return CGSizeMake(WindownWidth / 2.0, 166);
    }
    else if (self.layoutType == 1) {
        return CGSizeMake(WindownWidth, 166);
    }
    return CGSizeMake(WindownWidth / 2.0, 166);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.videos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    VedioCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:VedioCollectionViewCell_Identify forIndexPath:indexPath];
    cell.type = (int)self.layoutType;
    cell.delegate = self;
    cell.vedioModel = self.videos[indexPath.row];

    NSLog(@"visibleIndexpaths = %@", self.visibleIndexPaths);
    return cell;
}

//点击cell上的播放按钮，要播放cell上的视频
- (void)vedioCollectionViewPlayBtnClicked:(VedioCollectionViewCell *)cell
{
    self.visibleIndexPaths = [self.videoCollectionView indexPathsForVisibleItems];
    self.currentPath = [self.videoCollectionView indexPathForCell:cell];
    NSLog(@"self.currentPath = %@", self.currentPath);
    self.currentCell = cell;
    if (self.playerView && self.isPlaying) {
        [self.playerView.player pause];
        [self.playerView removeFromSuperview];
        self.isPlaying = NO;
        self.isOnCell = NO;
    }
    
    VideoModel *model = cell.vedioModel;
    //根据model的id去请求视频的url
    [[VideoDetailRequest shareVideoDetailRequest] requestSingleDotaVideoWithVideoID:model.vedioId success:^(NSDictionary *dic) {
        VideoDetailModel *videoDetailModel = [[VideoDetailModel alloc] init];
        [videoDetailModel setValuesForKeysWithDictionary:dic];
        //播放视频
        self.playerView = [[PlayerView alloc] initWithUrl:videoDetailModel.url frame:cell.bounds];
        [cell.contentView addSubview:self.playerView];
        self.isPlaying = YES;
        self.isOnCell = YES;
        
    } failure:^(NSError *error) {
        NSLog(@"single error = %@", error);
    }];
   
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (_playerView == nil) {
        return;
    }
    //先把cell的坐标转化成屏幕坐标
    CGRect changedFrame = [self.videoCollectionView convertRect:self.currentCell.frame toView:self.view];
    if (changedFrame.origin.y
         < -changedFrame.size.height + 64 || changedFrame.origin.y > WindowHeight) {
        [self putToRightCorner];
    }
    else {
        [self backToCell];
    }
}

//当cell划出去的时候，放到右下角播放
- (void)putToRightCorner
{
    if (self.isPlaying) {
        [self.playerView removeFromSuperview];
        [UIView animateWithDuration:0.5 animations:^{
            
            CGRect rightFrame = CGRectMake(WindownWidth / 2.0, WindowHeight * 3.0 /4.0, WindownWidth / 2.0, WindowHeight / 4.0);
            
            self.playerView.frame = rightFrame;
            //把这个layer的frame也改变
            self.playerView.playerLayer.frame =  self.playerView.bounds;
//            [[UIApplication sharedApplication].keyWindow addSubview:self.playerView];
            [self.view addSubview:self.playerView];
            [self.view bringSubviewToFront:self.playerView];

        }];
    }
}

- (void)backToCell
{
//    if (self.isPlaying && !self.isOnCell) {
   
        //先获取屏幕上的所有cell
        //先找到属于哪个cell
        NSLog(@"indexpath aaaaaaa = %@", self.visibleIndexPaths);
        NSLog(@"self.currentPath = %@", self.currentPath);
        if ([self.visibleIndexPaths containsObject:self.currentPath]) {
            if (self.isPlaying) {
                [self.playerView removeFromSuperview];
                //然后把PlayerView增加到这个cell上
                
                [UIView animateWithDuration:0.5 animations:^{
                    self.playerView.frame = self.currentCell.bounds;
                    self.playerView.playerLayer.frame =  self.playerView.bounds;
                    [self.currentCell.contentView addSubview:self.playerView];
                    [self.currentCell.contentView bringSubviewToFront:self.playerView];
                    self.isOnCell = YES;
                }];

            }
        }
//    }
}

- (void)didReceiveMemoryWarning
{
    
}

@end
