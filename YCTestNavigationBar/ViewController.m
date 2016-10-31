//
//  ViewController.m
//  YCTestNavigationBar
//
//  Created by 温玉超 on 16/10/30.
//  Copyright © 2016年 温玉超. All rights reserved.
//

#import "ViewController.h"
#import "UINavigationBar+BackgroundView.h"

#define kScreenHeight CGRectGetHeight([UIScreen mainScreen].bounds)
#define kNavigationBarColor [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1]

static NSString * const cellIdentifier = @"CustomCell";
NSString *const NavigationBarTitle = @"weimeng809";

const CGFloat NavigationBarHeight = 64.f;
const CGFloat kTableViewHeaderViewHeight = 320.f;
const CGFloat kTableViewHeaderViewWidth = 100.f;

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = NavigationBarTitle;
    [self setupTableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self scrollViewDidScroll:self.tableView];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tableView.delegate = nil;
    [self.navigationController.navigationBar yc_resetNavigationBarBackground];
}

- (void)setupTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -NavigationBarHeight, self.view.bounds.size.width, self.view.bounds.size.height + NavigationBarHeight) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
    [self.view addSubview:self.tableView];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"IMG_0193.JPG"]];
    imageView.bounds = CGRectMake(0, 0, kTableViewHeaderViewWidth , kTableViewHeaderViewHeight);
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    self.tableView.tableHeaderView = imageView;
    self.tableView.tableHeaderView.frame = CGRectMake(0, 0, kTableViewHeaderViewWidth, kTableViewHeaderViewHeight);
    self.tableView.tableHeaderView.clipsToBounds = YES;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.textLabel.text = [NSString stringWithFormat:@"测试cell：%ld", (long)indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat alpha = MIN(1, (offsetY + NavigationBarHeight) / (kTableViewHeaderViewHeight - NavigationBarHeight));
    [self.navigationController.navigationBar yc_setNavigationBarBackground:[kNavigationBarColor colorWithAlphaComponent:alpha]];
    CGFloat visibleHeiht = alpha * NavigationBarHeight;
    [self.navigationController.navigationBar yc_setNavigationBarMask:visibleHeiht];

}

@end
