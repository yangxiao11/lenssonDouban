//
//  VideoDetailModel.h
//  LessonVideo
//
//  Created by CLT on 16/7/9.
//  Copyright © 2016年 yaxin.guo. All rights reserved.
//

#import "BaseModel.h"

@interface VideoDetailModel : BaseModel

@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *message;
//视频播放地址
@property (nonatomic, copy) NSString *url;

@end
