//
//  VideoModel.m
//  LessonVideo
//
//  Created by CLT on 16/7/8.
//  Copyright © 2016年 yaxin.guo. All rights reserved.
//

#import "VideoModel.h"

@implementation VideoModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        _vedioId = value;
    }
}

+ (NSMutableArray *)parseVideoWithDic:(NSDictionary *)dic
{
    NSMutableArray *returnVideos = [NSMutableArray array];
    NSArray *videos = [dic objectForKey:@"videos"];
    for (NSDictionary *tempDic in videos) {
        VideoModel *model = [[VideoModel alloc] init];
        [model setValuesForKeysWithDictionary:tempDic];
        [returnVideos addObject:model];
    }
    return returnVideos;
}

@end
