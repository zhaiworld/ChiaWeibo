//
//  WBSettingViewController.m
//  Sina
//
//  Created by Chia on 16/4/21.
//  Copyright © 2016年 WB. All rights reserved.
//

#import "WBSettingViewController.h"
#import "WBGroupItem.h"
#import "WBCellItem.h"
#import "WBCellBasic.h"
#import "WBBasicCell.h"
#import "WBCommonTableViewController.h"

@implementation WBSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加section 0
    [self setUpSection0];
    //添加section 1
    [self setUpSection1];
    //添加section 2
    [self setUpSection2];
    
    [self setUpLogOut];
}
-(void)setUpSection0
{
    //传递行数据
    WBBadgeItem *account = [WBBadgeItem itemWithTitle:@"账号管理"];
    account.badgeValue = @"10";
    //传递组数据
    WBGroupItem *group = [[WBGroupItem alloc]init];
    group.items =@[account];
    [self.groups addObject:group];
}
-(void)setUpSection1
{
    //传递行数据
    WBArrowItem *album = [WBArrowItem itemWithTitle:@"我的相册"];
    WBArrowItem *set = [WBArrowItem itemWithTitle:@"通用设置"];
    set.destVcClass =[WBCommonTableViewController class];
    WBArrowItem *private = [WBArrowItem itemWithTitle:@"隐私与安全"];
    //传递组数据
    WBGroupItem *group = [[WBGroupItem alloc]init];
    group.items =@[album,set,private];
    [self.groups addObject:group];
}
-(void)setUpSection2
{
    //传递行数据
    WBArrowItem *feedback = [WBArrowItem itemWithTitle:@"意见反馈"];
    WBArrowItem *about = [WBArrowItem itemWithTitle:@"关于微博"];
    
    //传递组数据
    WBGroupItem *group = [[WBGroupItem alloc]init];
    group.items =@[feedback,about];
    [self.groups addObject:group];
}
-(void)setUpLogOut
{
    WBLabelItem *logout = [[WBLabelItem alloc] init];
    logout.text = @"退出登录";
    
    WBGroupItem *group = [[WBGroupItem alloc]init];
    group.items =@[logout];
    [self.groups addObject:group];
}

//返回每一行长什么样子
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //创建cell
    WBBasicCell * cell = [WBBasicCell cellWithTableView:tableView];
    //设置cell
    WBGroupItem *group = self.groups[indexPath.section];
    WBCellItem *row = group.items[indexPath.row];
    cell.item = row;
    //返回cell
    return cell;
}

@end
