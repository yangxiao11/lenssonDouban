//
//  AuthorTableViewCell.h
//  MediaProject
//
//  Created by CLT on 16/6/1.
//  Copyright © 2016年 yaxin.guo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AuthorModel.h"

#define AuthorTableViewCell_Identify @"AuthorTableViewCell_Identify"

@interface AuthorTableViewCell : UITableViewCell

//头像
@property (strong, nonatomic) IBOutlet UIImageView *headerView;
//名字
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
//日期
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
//排名
@property (strong, nonatomic) IBOutlet UILabel *rangeLabel;

@property (strong, nonatomic) AuthorModel *authorModel;

@end
