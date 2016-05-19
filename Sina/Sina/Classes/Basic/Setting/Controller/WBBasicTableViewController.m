//
//  WBBasicTableViewController.m
//  Sina
//
//  Created by Chia on 16/4/20.
//  Copyright © 2016年 WB. All rights reserved.
//

#import "WBBasicTableViewController.h"
#import "WBGroupItem.h"
#import "WBCellItem.h"
#import "WBBasicCell.h"
#import "WBCellBasic.h"

@interface WBBasicTableViewController ()

@end

@implementation WBBasicTableViewController
-(NSMutableArray *)groups
{
    if (_groups == nil) {
        _groups = [NSMutableArray array];
    }
    return _groups;
}
-(instancetype)init
{
    return [self initWithStyle:UITableViewStyleGrouped];
}
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.backgroundColor = WBColor(211, 211, 211);
    self.tableView.sectionHeaderHeight = 10;
    self.tableView.sectionFooterHeight = 0;
    self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
}
//返回一共有多少组
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.groups.count;
}
//返回一组有多少行
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    WBGroupItem *group = self.groups[section];
    return group.items.count;
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
//返回头标题
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.groups[section] headerTitle];
}
//返回尾标题
-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    return [self.groups[section] footerTitle];
}
//点击某行时
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    WBGroupItem *group = self.groups[indexPath.section];
    WBCellItem *row = group.items[indexPath.row];
    if (row.option) {
        WBCheckItem *item = (WBCheckItem *)row;
        row.option(item);
        //return必须要有吗？
        return;
    }
    
    if (row.destVcClass) {
        UIViewController *vc = [[row.destVcClass alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}
@end
