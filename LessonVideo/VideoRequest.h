//
//  VideoRequest.h
//  LessonVideo
//
//  Created by CLT on 16/7/8.
//  Copyright © 2016年 yaxin.guo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetWorkRequest.h"

@interface VideoRequest : NSObject

+ (instancetype)shareVideoRequest;

- (void)requestDotaSingleAuthorAllVideoWithAuthorID:(NSString *)ID success:(SuccessResponse)success failure:(FailureResponse)failure;

- (void)requestLOLSingleAuthorAllVideoWithAuthorID:(NSString *)ID success:(SuccessResponse)success failure:(FailureResponse)failure;

@end
