//
//  WBHomeViewController.m
//  Sina
//
//  Created by Chia on 16/2/29.
//  Copyright © 2016年 WB. All rights reserved.
//

#import "WBHomeViewController.h"
#import "WBTitleButton.h"
#import "UIBarButtonItem+WBItem.h"
#import "WBCover.h"
#import "WBPopMenu.h"
#import "UIView+Frame.h"
#import "WBOneViewController.h"
#import "AFNetworking.h"

#import "WBAccountTool.h"
#import "WBAccount.h"

#import "WBStatus.h"
#import "MJExtension.h"

#import "WBUser.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"

#import "HttpTool.h"
#import "WBStatusTool.h"
#import "WBUserTool.h"
#import "WBStatusCell.h"
#import "WBStatusFrame.h"

@interface WBHomeViewController ()<WBCoverDelegate>

@property (nonatomic, weak) WBTitleButton *titleButton;
@property (nonatomic, strong) UILabel *menuLabel;
/**
 *  ViewModel:WBStatusFrame
 */
@property (nonatomic, strong) NSMutableArray *statusFrames;

@end

@implementation WBHomeViewController
/**
 *  用于保存微博数据，是WBStatus模型数据
 *
 *  @return 返回后显示在界面上
 */
-(NSMutableArray *)statusFrames{
    if (_statusFrames ==nil) {
        _statusFrames = [NSMutableArray array];
    }
    return _statusFrames;
}

-(UILabel *)menuLabel{
    if (_menuLabel == nil) {
        _menuLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        _menuLabel.text = @"Hello";
    }
    return _menuLabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor lightGrayColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self setUpNavigationBar];
    
    //添加下拉刷新头部控件
    [self.tableView addHeaderWithTarget:self action:@selector(loadNewStatus)];
    //添加自动下拉刷新
    [self.tableView headerBeginRefreshing];
    //添加上拉刷新加载更多微博
    [self.tableView addFooterWithTarget:self action:@selector(loadMoreStatus)];
    
    [WBUserTool userInfoWithSuccess:^(WBUser *user) {
        //得到user信息
        [_titleButton setTitle:user.name forState:UIControlStateNormal];
        //将获得的用户名信息保存到账号信息里
        WBAccount *account = [WBAccountTool account];
        account.name = user.name;
        //保存账号信息
        [WBAccountTool saveAccount:account];
    } failure:^(NSError *error) {
        //
    }];
    
}

#pragma mark - 请求微博旧微博数据
-(void)loadMoreStatus{
    
    NSString *maxIdStr = nil;
    
    if (self.statusFrames.count) {
        WBStatus *s = [[self.statusFrames lastObject] status];
        long long maxId = [[s idstr] longLongValue] - 1;
        maxIdStr = [NSString stringWithFormat:@"%lld",maxId];
    }
    [WBStatusTool moreStatusWithMaxId:maxIdStr success:^(NSArray *moreStatus) {
        
        //停止刷新
        [self.tableView footerEndRefreshing];
        //模型转视图模型------wbstatus-->wbstatusFrame
        NSMutableArray *statusFrames = [NSMutableArray array];
        for (WBStatus *s in moreStatus) {
            WBStatusFrame *statusF = [[WBStatusFrame alloc]init];
            statusF.status = s;
            [statusFrames addObject:statusF];
        }

        [self.statusFrames addObjectsFromArray:statusFrames];
        //将数据显示在界面上
        [self.tableView reloadData];

    } failure:^(NSError *error) {
        //
    }];
}
#pragma mark - 请求微博最新数据
-(void)loadNewStatus{
    //准备SINCEID
    NSString *sinceId = nil;
    if (self.statusFrames.count) {//现在有微博数据，取其首条的idstr
        WBStatus *s = [self.statusFrames[0] status];
        sinceId = s.idstr;
    }
    [WBStatusTool newStatusWithSinceId:sinceId success:^(NSArray * newStatus) {
        //在下拉时展示最新的微博数
        [self showNewsCount:newStatus.count];
        //结束下拉刷新
        [self.tableView headerEndRefreshing];
        //模型转视图模型------wbstatus-->wbstatusFrame
        NSMutableArray *statusFramesArray = [NSMutableArray array];
        for (WBStatus *s in newStatus) {
            WBStatusFrame *statusF = [[WBStatusFrame alloc]init];
            statusF.status = s;
            [statusFramesArray addObject:statusF];
        }
        
        //将新的微博内容展示在最一条的位置
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, newStatus.count)];
        // 把数组中的元素添加进去
        [self.statusFrames insertObjects:statusFramesArray atIndexes:indexSet];
        [self.tableView reloadData];
    } failure:^(NSError * error) {
        //
    }];
}
#pragma mark - 展示最新的微博数
-(void)showNewsCount:(int)count{
    //没有新微博，则不显示
    if (count == 0) return;
    //展示最新的微博数
    CGFloat w = self.view.width;
    CGFloat h = 35;
    CGFloat x = 0;
    CGFloat y = CGRectGetMaxY(self.navigationController.navigationBar.frame) - h;
    UILabel *countLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
    countLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    countLabel.text = [NSString stringWithFormat:@"有%d条新微博",count];
    countLabel.textColor = [UIColor whiteColor];
    countLabel.textAlignment = NSTextAlignmentCenter;
    

    //将label插入到导航栏下方
    [self.navigationController.view insertSubview:countLabel belowSubview:self.navigationController.navigationBar];
    
    //动画平移
    [UIView animateWithDuration:0.25 animations:^{
        countLabel.transform = CGAffineTransformMakeTranslation(0, h);
    } completion:^(BOOL finished) {
        //完成后再移回，并移除
        [UIView animateWithDuration:0.25 delay:2 options:UIViewAnimationOptionCurveLinear animations:^{
            countLabel.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [countLabel removeFromSuperview];
        }];
    }];
}

-(void) setUpNavigationBar{
    
    //导航左按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_friendsearch"] highImage:[UIImage imageNamed:@"navigationbar_friendsearch_highlighted"] target:self action:@selector(searchFriend) forControlEvents:UIControlEventTouchUpInside];
    
    //导航右按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_pop"] highImage:[UIImage imageNamed:@"navigationbar_pop_highlighted"] target:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
                                              
    //设置导航标题
    WBTitleButton * titleButton = [WBTitleButton buttonWithType:UIButtonTypeCustom];
    
    //如果账号姓名没有值则显示“首页”
    WBAccount *account = [WBAccountTool account];
    NSString *title = account.name?:@"首页";
    [titleButton setTitle:title forState:UIControlStateNormal];
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateHighlighted];
    [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [titleButton sizeToFit];
    _titleButton = titleButton;
    self.navigationItem.titleView = _titleButton ;
}

-(void)titleClick:(UIButton *)button{
    
    //稍后换成_titleButton试试
    button.selected = !button.selected;
    //弹出蒙版
    WBCover *cover = [WBCover showCover];
    cover.delegate = self;
    
    // 弹出pop菜单
    CGFloat popW = 200;
    CGFloat popX = (self.view.width - popW) * 0.5;
    CGFloat popH = popW;
    CGFloat popY = 55;
    
    WBPopMenu *menu = [WBPopMenu showInRect:CGRectMake(popX, popY, popW, popH)];
    menu.contentView = self.menuLabel;
}

-(void)coverDidClickCover:(WBCover *)cover{
    [WBPopMenu hide];
    _titleButton.selected = NO;
}
-(void)searchFriend{
    
}

-(void)pop{
    

    WBOneViewController *oneVc = [[WBOneViewController alloc]init];
    [self.navigationController pushViewController:oneVc animated:YES];
//    self.hidesBottomBarWhenPushed = YES;

    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
    return self.statusFrames.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    WBStatusCell *cell = [WBStatusCell cellWithTableView:tableView];
    //获取status模型
    WBStatusFrame *statusF = self.statusFrames[indexPath.row];
    
    cell.statusF = statusF;
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}
//返回CELL的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    // 获取statusFrames模型
    WBStatusFrame *statusF = self.statusFrames[indexPath.row];
    return statusF.cellHeight;
}
@end
