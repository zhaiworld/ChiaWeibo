//
//  WBCellItem.m
//  Sina
//
//  Created by Chia on 16/4/21.
//  Copyright © 2016年 WB. All rights reserved.
//

#import "WBCellItem.h"

@implementation WBCellItem

+(instancetype)itemWithTitle:(NSString *)title subTitle:(NSString *)subTitle image:(UIImage *)image
{
    WBCellItem *cellItem = [[self alloc] init];
    cellItem.title = title;
    cellItem.subTitle = subTitle;
    cellItem.image = image;
    return cellItem;
}
+(instancetype)itemWithTitle:(NSString *)title image:(UIImage *)image
{
    return [self itemWithTitle:title subTitle:nil image:image];
}

+(instancetype)itemWithTitle:(NSString *)title
{
    return [self itemWithTitle:title subTitle:nil image:nil];
}

@end
