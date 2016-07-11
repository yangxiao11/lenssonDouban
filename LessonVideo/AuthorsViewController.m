//
//  AuthorsViewController.m
//  LessonVideo
//
//  Created by CLT on 16/7/7.
//  Copyright © 2016年 yaxin.guo. All rights reserved.
//

#import "AuthorsViewController.h"
#import "AuthorTableViewCell.h"
#import "AuthorRequest.h"
#import "AuthorModel.h"
#import "VideosViewController.h"

@interface AuthorsViewController ()
<
    UITableViewDataSource,
    UITableViewDelegate
>

@property (strong, nonatomic) IBOutlet UITableView *dotaTableView;
@property (strong, nonatomic) IBOutlet UITableView *lolTableView;

@property (strong, nonatomic) NSMutableArray *dotaAllAuthors;
@property (strong, nonatomic) NSMutableArray *lolAllAuthors;

@end

@implementation AuthorsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dotaAllAuthors = [NSMutableArray array];
    self.lolAllAuthors = [NSMutableArray array];
    //两个tableview 注册cell
    [self.dotaTableView registerNib:[UINib nibWithNibName:@"AuthorTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:AuthorTableViewCell_Identify];
    [self.lolTableView registerNib:[UINib nibWithNibName:@"AuthorTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:AuthorTableViewCell_Identify];
    //调用两个请求
    [self requestDotaAuthors];
    [self requestLOLAuthors];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.rootVC.videoTabBar.hidden = NO;
}

//请求dota主播
- (void)requestDotaAuthors
{
     __weak typeof(self) weakSelf = self;
    [[AuthorRequest shareAuthorRequest] requestDotaAllAuthorsSuccess:^(NSDictionary *dic) {
        NSLog(@"dota dic = %@", dic);
        weakSelf.dotaAllAuthors = [AuthorModel parseAuthorsWithDic:dic];
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.dotaTableView reloadData];
        });
    } failure:^(NSError *error) {
        NSLog(@"dota error = %@", error);
    }];
}
//请求lol主播
- (void)requestLOLAuthors
{
    __weak typeof(self) weakSelf = self;
    [[AuthorRequest shareAuthorRequest] requestLOLAllAuthorsSuccess:^(NSDictionary *dic) {
        NSLog(@"lol dic = %@", dic);
        weakSelf.lolAllAuthors = [AuthorModel parseAuthorsWithDic:dic];
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.lolTableView reloadData];
        });
    } failure:^(NSError *error) {
        NSLog(@"lol error = %@", error);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.dotaTableView) {
        return self.dotaAllAuthors.count;
    }
    else {
        return self.lolAllAuthors.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AuthorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:AuthorTableViewCell_Identify];
    AuthorModel *model = nil;
    if (tableView == self.dotaTableView) {
        model = self.dotaAllAuthors[indexPath.row];
    }
    else {
        model = self.lolAllAuthors[indexPath.row];
    }
    cell.authorModel = model;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    VideosViewController *videoVC = [sb instantiateViewControllerWithIdentifier:@"VideosViewController"];
    if (tableView == self.dotaTableView) {
        AuthorModel *model = self.dotaAllAuthors[indexPath.row];
        videoVC.authorID = model.authorId;
        videoVC.sourceFrom = 0;
    }
    else {
        AuthorModel *model = self.lolAllAuthors[indexPath.row];
        videoVC.authorID = model.authorId;
        videoVC.sourceFrom = 1;
    }
    self.rootVC.videoTabBar.hidden = YES;
    [self.navigationController pushViewController:videoVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{

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
