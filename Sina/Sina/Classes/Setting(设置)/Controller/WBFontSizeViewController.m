//
//  WBFontSizeViewController.m
//  Sina
//
//  Created by Chia on 16/4/22.
//  Copyright © 2016年 WB. All rights reserved.
//

#import "WBFontSizeViewController.h"
#import "WBCellBasic.h"
#import "WBGroupItem.h"
#import "WBBasicCell.h"
#import "WBFontSizeTool.h"

#define WBUserDefaults [NSUserDefaults standardUserDefaults]
#define WBFontSize @"fontSize"
#define WBFontSizeKey @"fontSizeKey"
#define WBFontSizeNote @"FontSizeNotice"


@interface WBFontSizeViewController()
@property(nonatomic, weak) WBCheckItem *lastSelItem;

@end
@implementation WBFontSizeViewController


-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setUpSection0];
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);

}

-(void)setUpSection0
{
    __weak typeof (self) weakSelf = self;
    WBCheckItem *big = [WBCheckItem itemWithTitle:@"大"];
    big.option= ^(WBCheckItem * item) {
        [weakSelf selItem:item];
    };
    WBCheckItem *middle = [WBCheckItem itemWithTitle:@"中"];
    middle.option= ^(WBCheckItem * item) {
        [weakSelf selItem:item];
    };
    WBCheckItem *small = [WBCheckItem itemWithTitle:@"小"];
    small.option= ^(WBCheckItem * item) {
        [weakSelf selItem:item];
    };
    WBGroupItem *group = [[WBGroupItem alloc]init];
    group.headerTitle = @"上传图片质量";
    group.items = @[big,middle,small];
    
    [self.groups addObject:group];
    //默认选中item
    [self selItemWithTitle:[WBFontSizeTool fontSize]];

}
-(void)selItemWithTitle:(NSString*)title
{
    for (WBGroupItem *group in self.groups) {
        for (WBCheckItem *item in group.items) {
            if ([item.title isEqualToString:title]) {
                [self selItem:item];
            }
        }
    }
}
-(void)selItem:(WBCheckItem *)item
{
    _lastSelItem.check = NO;
    item.check = YES;
    _lastSelItem = item;
    [self.tableView reloadData];
    
    //保存当前设置的字体
    [WBFontSizeTool saveFontSize:item.title];
    //发出通知
    [[NSNotificationCenter defaultCenter] postNotificationName:WBFontSizeNote object:nil];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 35;
    }else{
        return 10;
    }
    
}


@end
