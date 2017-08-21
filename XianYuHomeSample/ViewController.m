//
//  ViewController.m
//  XianYuHomeSample
//
//  Created by 周凯丽 on 2017/8/18.
//  Copyright © 2017年 t. All rights reserved.
//

#import "ViewController.h"
#import "HeaderView.h"
#import "ScrollView.h"
@interface ViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) ScrollView *scrollView;//大的背景图
@property (strong, nonatomic) UIView *navView;//导航图
@property (strong, nonatomic) HeaderView *headerView;
@property (strong, nonatomic) UITableView *tableView1;
@property (strong, nonatomic) UITableView *tableView2;
@property (strong, nonatomic) NSMutableArray *tableArray;//


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableArray = [NSMutableArray array];
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.headerView];
    [self.scrollView addSubview:self.tableView1];
    [self.scrollView addSubview:self.tableView2];
    [self.tableArray addObject:self.tableView1];
    [self.tableArray addObject:self.tableView2];
    [self.view addSubview:self.navView];
}
#pragma mark - click
- (void)setScorllOffset:(NSInteger)index
{
    [self.scrollView setContentOffset:CGPointMake(index *self.scrollView.width, 0) animated:NO];
}

#pragma mark - lazy
- (UIView *)navView
{
    if (!_navView) {
        _navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, mScreenWidth, 64)];
        _navView.backgroundColor = RGBFromValue(0xfed853);
    }
    return _navView;
}
- (ScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[ScrollView alloc] initWithFrame:CGRectMake(0, 64, mScreenWidth, mScreenHeight)];
        _scrollView.pagingEnabled = YES;
        _scrollView.clipsToBounds = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.delegate = self;
        _scrollView.bounces = NO;
        _scrollView.delaysContentTouches           = NO;
        _scrollView.contentSize = CGSizeMake(2*_scrollView.width, _scrollView.height);
    }
    return _scrollView;
}
- (HeaderView *)headerView
{
    if (!_headerView) {
        _headerView = [[HeaderView alloc] initWithFrame:CGRectMake(0, 64, self.scrollView.width, kHeadViewHeight)];
        __weak typeof(self)weakSelf =self;
        _headerView.segmentSelectBlock = ^(NSInteger index) {
            __strong typeof(weakSelf)strongSelf =weakSelf;
            [strongSelf setScorllOffset:index];
        };
    }
    return _headerView;
}
- (UITableView *)tableView1
{
    if (!_tableView1) {
        _tableView1 = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.scrollView.width, self.scrollView.height) style:UITableViewStylePlain];
        _tableView1.delegate = self;
        _tableView1.dataSource = self;
        [_tableView1 registerClass:UITableViewCell.class forCellReuseIdentifier:@"cellInfo"];
        _tableView1.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, mScreenWidth, kHeadViewHeight)];
        _tableView1.showsVerticalScrollIndicator = NO;
        _tableView1.tag = 100;
    }
    return _tableView1;
}
- (UITableView *)tableView2
{
    if (!_tableView2) {
        _tableView2 = [[UITableView alloc] initWithFrame:CGRectMake(mScreenWidth, 0, self.scrollView.width, self.scrollView.height) style:UITableViewStylePlain];
        _tableView2.delegate = self;
        _tableView2.dataSource = self;
        [_tableView2 registerClass:UITableViewCell.class forCellReuseIdentifier:@"cellInfo"];
        _tableView2.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, mScreenWidth, kHeadViewHeight)];
        _tableView2.showsVerticalScrollIndicator = NO;
        _tableView2.tag = 101;

    }
    return _tableView2;
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.scrollView) {
        return;
    }

    CGFloat offsetY      = scrollView.contentOffset.y;
    CGFloat originY      = 64;
    CGFloat otherOffsetY = 0;
    if (offsetY <= kHeadContentH) {
        originY              = 64 - offsetY;
        if (offsetY < 0) {
            otherOffsetY         = 0;
        } else {
            otherOffsetY         = offsetY;
        }
        
    } else {
        originY              = 64 - kHeadContentH;
        otherOffsetY         = kHeadContentH;
    }

    self.headerView.frame = CGRectMake(0, originY, self.headerView.width, kHeadViewHeight);
    
    for ( int i = 0; i < 2; i++ ) {
        if (i != self.headerView.index) {
            UITableView *contentView = self.tableArray[i];
            CGPoint offset = CGPointMake(0, otherOffsetY);
            if ([contentView isKindOfClass:[UITableView class]]) {
                if (contentView.contentOffset.y < kHeadContentH || offset.y < kHeadContentH) {
                    [contentView setContentOffset:offset animated:NO];
                    self.scrollView.offsetY = otherOffsetY;
                }
            }
        }
    }
//    用这种方法就会特别卡 不知道为什么
    
    
//    if (scrollView == self.tableView1) {
//        if (self.tableView2.contentOffset.y < headH || otherOffsetY < headH) {
//            CGPoint offset = CGPointMake(0, otherOffsetY);
//            [self.tableView2 setContentOffset:offset animated:NO];
//            self.scrollView.offsetY = otherOffsetY;
//        }
//    }else{
//        if (self.tableView1.contentOffset.y < headH || otherOffsetY < headH) {
//            CGPoint offset = CGPointMake(0, otherOffsetY);
//            [self.tableView1 setContentOffset:offset animated:NO];
//            self.scrollView.offsetY = otherOffsetY;
//        }
//        
//    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if ([scrollView isEqual:self.scrollView]) {
        NSInteger index  = scrollView.contentOffset.x/mScreenWidth;
        self.headerView.index =index;
        return;
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 120;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellInfo" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 100) {
        return 100;
    }
    return 80;
}
@end
