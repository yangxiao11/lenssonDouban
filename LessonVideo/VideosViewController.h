//
//  VideosViewController.h
//  LessonVideo
//
//  Created by CLT on 16/7/8.
//  Copyright © 2016年 yaxin.guo. All rights reserved.
//

#import "BaseViewController.h"

@interface VideosViewController : BaseViewController
@property (strong, nonatomic) IBOutlet UICollectionView *videoCollectionView;
@property (copy, nonatomic) NSString *authorID;
//判断是从dota主播界面进来，还是lol主播界面进来
@property (assign, nonatomic) int sourceFrom;
@end
