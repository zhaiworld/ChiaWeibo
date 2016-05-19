//
//  WBProfileViewController.m
//  Sina
//
//  Created by Chia on 16/2/29.
//  Copyright © 2016年 WB. All rights reserved.
//

#import "WBProfileViewController.h"
#import "WBGroupItem.h"
#import "WBCellItem.h"
#import "WBCellBasic.h"
#import "WBProfileCell.h"
#import "WBSettingViewController.h"
#import "WBNavigationController.h"


@interface WBProfileViewController ()

@end

@implementation WBProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航
    [self setNav];
    //添加section 0
    [self setUpSection0];
    //添加section 1
    [self setUpSection1];
    //添加section 2
    [self setUpSection2];
    //添加section 3
    [self setUpSection3];
    
}
-(void)setUpSection0
{
    //传递行数据
    WBArrowItem *friendS = [WBArrowItem itemWithTitle:@"新的好友" image:[UIImage imageNamed:@"new_friend"]];
    //传递组数据
    WBGroupItem *group = [[WBGroupItem alloc]init];
    group.items =@[friendS];
    [self.groups addObject:group];
}
-(void)setUpSection1
{
    //传递行数据
    WBArrowItem *album = [WBArrowItem itemWithTitle:@"我的相册" image:[UIImage imageNamed:@"album"]];
    album.subTitle = @"(10)";
    WBArrowItem *collect = [WBArrowItem itemWithTitle:@"我的收藏" image:[UIImage imageNamed:@"collect"]];
    collect.subTitle = @"(0)";
    WBArrowItem *like = [WBArrowItem itemWithTitle:@"赞" image:[UIImage imageNamed:@"like"]];
    like.subTitle = @"(0)";

    //传递组数据
    WBGroupItem *group = [[WBGroupItem alloc]init];
    group.items =@[album,collect,like];
    [self.groups addObject:group];
}
-(void)setUpSection2
{
    //传递行数据
    WBArrowItem *pay = [WBArrowItem itemWithTitle:@"微博支付" image:[UIImage imageNamed:@"pay"]];
    WBArrowItem *vip = [WBArrowItem itemWithTitle:@"个性化" image:[UIImage imageNamed:@"vip"]];
    vip.subTitle = @"微博来源、皮肤、封面图";
    
    //传递组数据
    WBGroupItem *group = [[WBGroupItem alloc]init];
    group.items =@[pay,vip];
    [self.groups addObject:group];
}
-(void)setUpSection3
{
    //传递行数据
    WBArrowItem *card = [WBArrowItem itemWithTitle:@"我的二维码" image:[UIImage imageNamed:@"card"]];
    WBArrowItem *draft = [WBArrowItem itemWithTitle:@"草稿箱" image:[UIImage imageNamed:@"draft"]];
    
    //传递组数据
    WBGroupItem *group = [[WBGroupItem alloc]init];
    group.items =@[card,draft];
    [self.groups addObject:group];
}
//返回每一行长什么样子
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //创建cell
    WBProfileCell * cell = [WBProfileCell cellWithTableView:tableView];
    //设置cell
    WBGroupItem *group = self.groups[indexPath.section];
    WBCellItem *row = group.items[indexPath.row];
    cell.item = row;
    //返回cell
    return cell;
}
-(void)setNav
{
    UIBarButtonItem * settting = [[UIBarButtonItem alloc] initWithTitle:@"我" style:UIBarButtonItemStyleBordered target:self action:@selector(settting)];
    
    self.navigationItem.rightBarButtonItem = settting;
}
-(void)settting{
    WBSettingViewController * settingVc = [[WBSettingViewController alloc] init];
    
    [self.navigationController pushViewController:settingVc animated:YES];
}


@end
