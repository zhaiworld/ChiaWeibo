//
//  WBBasicCell.m
//  Sina
//
//  Created by Chia on 16/4/21.
//  Copyright © 2016年 WB. All rights reserved.
//

#import "WBBasicCell.h"
#import "WBGroupItem.h"
#import "WBCellItem.h"
#import "WBBadgeView.h"
#import "WBCellBasic.h"


@interface WBBasicCell()
@property(nonatomic, strong) UIImageView *arrowView;
@property(nonatomic, strong) UIImageView *checkView;
@property(nonatomic, strong) UISwitch *switchView;
@property(nonatomic, strong) WBBadgeView *badgeView;
@property(nonatomic, strong) UILabel * labelView;

@end
@implementation WBBasicCell
-(UIImageView *)arrowView
{
    if (_arrowView ==nil) {
        _arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"common_icon_arrow"]];
    }
    return _arrowView;
}
-(UIImageView *)checkView
{
    if (_checkView == nil) {
        _checkView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"common_icon_checkmark"]];
    }
    return _checkView;
}
-(UISwitch *)switchView
{
    if (_switchView == nil) {
        _switchView = [[UISwitch alloc] init];
    }
    return _switchView;
}
-(WBBadgeView *)badgeView
{
    if (_badgeView == nil) {
        _badgeView = [WBBadgeView buttonWithType:UIButtonTypeCustom];
    }
    return _badgeView;
}
-(UILabel *)labelView
{
    if (_labelView == nil) {
        _labelView = [[UILabel alloc] init];
        _labelView.textAlignment = NSTextAlignmentCenter;
        _labelView.textColor = [UIColor redColor];
    }
    return _labelView;
}
+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"cell";
    WBBasicCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    return cell;
}

-(void)setItem:(WBCellItem *)item
{
    _item = item;
    //设置内容
    [self setUpData];
    //设置右边内容
    [self setRightView];
    //设置Label
    if ([_item isKindOfClass:[WBLabelItem class]]) {
        WBLabelItem *item = (WBLabelItem *)_item;
        self.labelView.text = item.text;
        [self addSubview:_labelView];
    }else{
        [_labelView removeFromSuperview];
    }
}
//设置内容
-(void)setUpData
{
    self.textLabel.text = _item.title;
    self.detailTextLabel.text = _item.subTitle;
    self.imageView.image = _item.image;
}
//设置右边内容
-(void)setRightView
{
    if ([_item isKindOfClass:[WBArrowItem class]]) {//跳转
        self.accessoryView = self.arrowView;
    }else if ([_item isKindOfClass:[WBSwitchItem class]]){//开关
        WBSwitchItem *item = (WBSwitchItem *)_item;
        self.switchView.on = item.on;
        self.accessoryView = self.switchView;
    }else if ([_item isKindOfClass:[WBCheckItem class]]){//复选
        WBCheckItem *item = (WBCheckItem *)_item;
        if (item.check) {
            
            self.accessoryView = self.checkView;
        }else
        {
            self.accessoryView = nil;
        }
    }else if ([_item isKindOfClass:[WBBadgeItem class]]){//角标
        WBBadgeItem *item = (WBBadgeItem *)_item;
        self.badgeView.badgeView = item.badgeValue;
        self.accessoryView = self.badgeView;
    }else{
        self.accessoryView = nil;
    }
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.labelView.frame = self.bounds;
    
}
@end
