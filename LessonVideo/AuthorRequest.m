//
//  AuthorRequest.m
//  LessonVideo
//
//  Created by CLT on 16/7/7.
//  Copyright © 2016年 yaxin.guo. All rights reserved.
//

#import "AuthorRequest.h"


static AuthorRequest *request = nil;
@implementation AuthorRequest

+ (instancetype)shareAuthorRequest
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        request = [[AuthorRequest alloc] init];
    });
    return request;
}

//+ (id)allocWithZone:(struct _NSZone *)zone
//{
//    @synchronized(request) {
//        if (!request) {
//            request = [super allocWithZone:zone];
//        }
//    }
//    return request;
//}

//+ (id)copyWithZone:(struct _NSZone *)zone
//{
//    return request;
//}

//请求dota所有主播
- (void)requestDotaAllAuthorsSuccess:(SuccessResponse)success failure:(FailureResponse)failure
{
    [self requestAllAuthorsWithUrl:DotaAllAuthorsRequest_Url success:^(NSDictionary *dic) {
        success(dic);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
//请求LOL所有主播
- (void)requestLOLAllAuthorsSuccess:(SuccessResponse)success failure:(FailureResponse)failure
{
    [self requestAllAuthorsWithUrl:LOLAllAuthorsRequest_Url success:^(NSDictionary *dic) {
        success(dic);
    } failure:^(NSError *error) {
        failure(error);
    }];

}


- (void)requestAllAuthorsWithUrl:(NSString *)url success:(SuccessResponse)success failure:(FailureResponse)failure
{
    NetWorkRequest *request = [[NetWorkRequest alloc] init];
    [request requestWithUrl:url parameters:nil successResponse:^(NSDictionary *dic) {
        success(dic);
    } failureResponse:^(NSError *error) {
        failure(error);
    }];
}

@end
