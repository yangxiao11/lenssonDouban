//
//  VideoRequest.m
//  LessonVideo
//
//  Created by CLT on 16/7/8.
//  Copyright © 2016年 yaxin.guo. All rights reserved.
//

#import "VideoRequest.h"
static VideoRequest *request = nil;

@implementation VideoRequest

+ (instancetype)shareVideoRequest
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        request = [[VideoRequest alloc] init];
    });
    return  request;
}

- (void)requestDotaSingleAuthorAllVideoWithAuthorID:(NSString *)ID success:(SuccessResponse)success failure:(FailureResponse)failure
{
    [self requestSingleAuthorAllVideoWithUrl:DotaSingleAuthorAllVideosRequet_Url(ID) success:^(NSDictionary *dic) {
        success(dic);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)requestLOLSingleAuthorAllVideoWithAuthorID:(NSString *)ID success:(SuccessResponse)success failure:(FailureResponse)failure
{
    [self requestSingleAuthorAllVideoWithUrl:LOLSignleAuthorAllVideosRequest_Url(ID) success:^(NSDictionary *dic) {
        success(dic);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)requestSingleAuthorAllVideoWithUrl:(NSString *)url success:(SuccessResponse)success failure:(FailureResponse)failure
{
    NetWorkRequest *request = [[NetWorkRequest alloc] init];
    [request requestWithUrl:url parameters:nil successResponse:^(NSDictionary *dic) {
        success(dic);
    } failureResponse:^(NSError *error) {
        failure(error);
    }];
}

@end
