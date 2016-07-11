//
//  AuthorRequest.h
//  LessonVideo
//
//  Created by CLT on 16/7/7.
//  Copyright © 2016年 yaxin.guo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetWorkRequest.h"

@interface AuthorRequest : NSObject

+ (instancetype)shareAuthorRequest;

//请求dota所有主播
- (void)requestDotaAllAuthorsSuccess:(SuccessResponse)success failure:(FailureResponse)failure;
//请求LOL所有主播
- (void)requestLOLAllAuthorsSuccess:(SuccessResponse)success failure:(FailureResponse)failure;

@end
