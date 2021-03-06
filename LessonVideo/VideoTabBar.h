//
//  DouBanTabBar.h
//  LessonDouBan
//
//  Created by CLT on 16/6/28.
//  Copyright © 2016年 yaxin.guo. All rights reserved.
//

@class VideoTabBar;

@protocol VideoTabBarDeleage

- (void)videoBanItemDidClicked:(VideoTabBar *)tabBar;

@end

#import <UIKit/UIKit.h>

@interface VideoTabBar : UITabBar

//当前选中的tabbar的下标
@property (nonatomic, assign) int currentSelected;
//当前选中的item
@property (nonatomic, strong) UIButton *currentSelectedItem;
//tabbar上面所有的item
@property (nonatomic, strong) NSArray *allItems;

@property (nonatomic, weak) id<VideoTabBarDeleage>doubanDelegate;

//初始化方法：根据items初始化items
- (id)initWithItems:(NSArray *)items frame:(CGRect)frame;

@end
