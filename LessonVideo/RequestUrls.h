//
//  RequestUrls.h
//  LessonVideo
//
//  Created by CLT on 16/7/7.
//  Copyright © 2016年 yaxin.guo. All rights reserved.
//

#ifndef RequestUrls_h
#define RequestUrls_h

//dota 全部主播请求 url
#define DotaAllAuthorsRequest_Url @"http://api.dotaly.com/api/v1/authors?iap=0&ident=F5D9CA17-1E5C-4B19-8727-4C3A51B77596&jb=0"
//lol 全部主播请求 url
#define LOLAllAuthorsRequest_Url @"http://api.dotaly.com/lol/api/v1/authors?iap=0&ident=408A6C12-3E61-42EE-A6DB-FB776FBB834E"

//dota 单个主播所有视频 url
#define DotaSingleAuthorAllVideosRequet_Url(ID)[NSString stringWithFormat:@"http://api.dotaly.com/api/v1/shipin/latest?author=%@&iap=0&ident=F5D9CA17-1E5C-4B19-8727-4C3A51B77596&jb=0&limit=50", ID]

//lol 单个主播所有视频 url
#define LOLSignleAuthorAllVideosRequest_Url(ID) [NSString stringWithFormat:@"http://api.dotaly.com/lol/api/v1/shipin/latest?author=%@&iap=0&ident=408A6C12-3E61-42EE-A6DB-FB776FBB834E&jb=0&limit=50", ID]

//dota 单个视频请求 url
#define DotaSingleVideoRequest_Url(ID) [NSString stringWithFormat:@"http://api.dotaly.com/api/v1/getvideourl?iap=0&ident=F5D9CA17-1E5C-4B19-8727-4C3A51B77596&jb=0&type=mp4&vid=%@", ID]


#endif /* RequestUrls_h */
