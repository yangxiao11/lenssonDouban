//
//  VideoDetailRequest.m
//  LessonVideo
//
//  Created by CLT on 16/7/8.
//  Copyright © 2016年 yaxin.guo. All rights reserved.
//

#import "VideoDetailRequest.h"
static VideoDetailRequest *request = nil;
@implementation VideoDetailRequest

+ (instancetype)shareVideoDetailRequest
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        request = [[VideoDetailRequest alloc] init];
    });
    return request;
}

//请求dota视频
- (void)requestSingleDotaVideoWithVideoID:(NSString *)ID success:(SuccessResponse)success failure:(FailureResponse)failure
{
    [self requestSingleVideosWithUrl:DotaSingleVideoRequest_Url(ID) success:^(NSDictionary *dic) {
        success(dic);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//请求单个视频（返回视频url）
- (void)requestSingleVideosWithUrl:(NSString *)url success:(SuccessResponse)success failure:(FailureResponse)failure
{
    NetWorkRequest *request = [[NetWorkRequest alloc] init];
    [request requestWithUrl:url parameters:nil successResponse:^(NSDictionary *dic) {
        success(dic);
    } failureResponse:^(NSError *error) {
        failure(error);
    }];
}

@end
