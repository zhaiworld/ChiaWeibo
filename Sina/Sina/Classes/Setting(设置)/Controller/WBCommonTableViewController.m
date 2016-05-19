//
//  WBCommonTableViewController.m
//  Sina
//
//  Created by Chia on 16/4/21.
//  Copyright © 2016年 WB. All rights reserved.
//

#import "WBCommonTableViewController.h"
#import "WBGroupItem.h"
#import "WBCellItem.h"
#import "WBCellBasic.h"
#import "WBBasicCell.h"
#import "WBFontSizeViewController.h"
#import "WBFontSizeTool.h"

#define WBUserDefaults [NSUserDefaults standardUserDefaults]
#define WBFontSize @"fontSize"
#define WBFontSizeKey @"fontSizeKey"
#define WBFontSizeNote @"FontSizeNotice"


@interface WBCommonTableViewController()
@property(nonatomic, weak) WBCellItem *fontsize;

@end
@implementation WBCommonTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加section 0
    [self setUpSection0];
    //添加section 1
    [self setUpSection1];
    //添加section 2
    [self setUpSection2];
    
    [self setUpSection3];
    [self setUpSection4];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fontSizeChanged) name:WBFontSizeNote object:nil];
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(void)fontSizeChanged
{
    //修改模型
    _fontsize.subTitle = [WBFontSizeTool fontSize];
    //刷新界面
    [self.tableView reloadData];
}
-(void)setUpSection0
{
    //传递行数据
    WBCellItem *read = [WBCellItem itemWithTitle:@"阅读模式"];
    read.subTitle = @"有图模式";
    WBCellItem *fontsize = [WBCellItem itemWithTitle:@"字体大小"];
    NSString *fontSizeStr = [WBFontSizeTool fontSize];
    if (fontSizeStr) {
        fontsize.subTitle = fontSizeStr;
    }else{
        fontsize.subTitle = @"小";
        [WBFontSizeTool saveFontSize:@"小"];
    }
    fontsize.destVcClass = [WBFontSizeViewController class];
    _fontsize = fontsize;
    
    WBSwitchItem *remark = [WBSwitchItem itemWithTitle:@"显示备注"];
    remark.on = YES;
    //传递组数据
    WBGroupItem *group = [[WBGroupItem alloc]init];
    group.items =@[read,fontsize,remark];
    [self.groups addObject:group];
}
-(void)setUpSection1
{
    //传递行数据
    WBArrowItem *picQuality = [WBArrowItem itemWithTitle:@"图片质量"];
    //传递组数据
    WBGroupItem *group = [[WBGroupItem alloc]init];
    group.items =@[picQuality];
    [self.groups addObject:group];
}
-(void)setUpSection2
{
    //传递行数据
    WBSwitchItem *voice = [WBSwitchItem itemWithTitle:@"声音"];
    voice.on = NO;
    //传递组数据
    WBGroupItem *group = [[WBGroupItem alloc]init];
    group.items =@[voice];
    [self.groups addObject:group];
}
-(void)setUpSection3
{
    WBCellItem *multiLanguage = [WBCellItem itemWithTitle:@"多语言环境"];
    multiLanguage.subTitle = @"跟随系统";
    WBGroupItem *group = [[WBGroupItem alloc]init];
    group.items =@[multiLanguage];
    [self.groups addObject:group];
}
-(void)setUpSection4
{
    WBArrowItem *clear = [WBArrowItem itemWithTitle:@"清空图片缓存"];
    clear.subTitle = @"321KB";
    WBGroupItem *group = [[WBGroupItem alloc]init];
    group.items =@[clear];
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
