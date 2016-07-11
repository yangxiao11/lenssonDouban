//
//  AuthorModel.m
//  LessonVideo
//
//  Created by CLT on 16/7/7.
//  Copyright © 2016年 yaxin.guo. All rights reserved.
//

#import "AuthorModel.h"

@implementation AuthorModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        _authorId = value;
    }
}

+ (NSMutableArray *)parseAuthorsWithDic:(NSDictionary *)dic
{
    NSArray *authors = [dic objectForKey:@"authors"];
    NSMutableArray *returnAuthors = [NSMutableArray array];
    for (NSDictionary *tmpDic in authors) {
        AuthorModel *model = [[AuthorModel alloc] init];
        [model setValuesForKeysWithDictionary:tmpDic];
        [returnAuthors addObject:model];
    }
    return returnAuthors;
}

@end
