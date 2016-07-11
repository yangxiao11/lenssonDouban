//
//  VedioCollectionViewCell.h
//  MediaProject
//
//  Created by CLT on 16/6/2.
//  Copyright © 2016年 yaxin.guo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoModel.h"
#import <AVFoundation/AVFoundation.h>

#define VedioCollectionViewCell_Identify @"VedioCollectionViewCell_Identify"

@class VedioCollectionViewCell;

@protocol VedioCollectionViewCellDelegate<NSObject>

- (void)vedioCollectionViewPlayBtnClicked:(VedioCollectionViewCell *)cell;

@end

@interface VedioCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLengthLabel;
@property (strong, nonatomic) IBOutlet UIButton *playBtn;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;


@property (assign, nonatomic) id<VedioCollectionViewCellDelegate>delegate;

@property (assign, nonatomic) int type;
@property (strong, nonatomic) VideoModel *vedioModel;

@end
