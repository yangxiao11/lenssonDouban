//
//  RootViewController.m
//  LessonDouBan
//
//  Created by CLT on 16/6/28.
//  Copyright © 2016年 yaxin.guo. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()<VideoTabBarDeleage>

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.hidden = YES;
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn1 setImage:[UIImage imageNamed:@"first_normal.png"] forState:UIControlStateNormal];
    [btn1 setImage:[UIImage imageNamed:@"first_selected.png"] forState:UIControlStateSelected];
    btn1.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 15, 0);
    [btn1 setTitle:@"主播" forState:UIControlStateNormal];
    btn1.titleLabel.font = [UIFont systemFontOfSize:12];
    [btn1 setTitleEdgeInsets:UIEdgeInsetsMake(0, -60, -30, 0)];
    [btn1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor colorWithRed:38.0/255 green:217.0/255 blue:165.0/255 alpha:1] forState:UIControlStateSelected];
    
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn2 setImage:[UIImage imageNamed:@"second_normal.png"] forState:UIControlStateNormal];
    [btn2 setImage:[UIImage imageNamed:@"second_selected.png"] forState:UIControlStateSelected];
    btn2.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 15, 0);
    [btn2 setTitle:@"我的" forState:UIControlStateNormal];
    btn2.titleLabel.font = [UIFont systemFontOfSize:12];
    [btn2 setTitleEdgeInsets:UIEdgeInsetsMake(0, -60, -30, 0)];
    [btn2 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor colorWithRed:38.0/255 green:217.0/255 blue:165.0/255 alpha:1] forState:UIControlStateSelected];

    
    self.videoTabBar = [[VideoTabBar alloc] initWithItems:@[btn1, btn2] frame:CGRectMake(0, WindowHeight - 49, WindownWidth, 49)];
    self.videoTabBar.doubanDelegate = self;
    NSLog(@"frame = %@", NSStringFromCGRect(self.videoTabBar.frame));
    [self.view addSubview:self.videoTabBar];
    self.selectedIndex = self.videoTabBar.currentSelected;
    
}



- (void)videoBanItemDidClicked:(VideoTabBar *)tabBar
{
    self.selectedIndex = tabBar.currentSelected;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
