//
//  WBProfileCell.m
//  Sina
//
//  Created by Chia on 16/4/21.
//  Copyright © 2016年 WB. All rights reserved.
//

#import "WBProfileCell.h"

@implementation WBProfileCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.detailTextLabel.font = [UIFont systemFontOfSize:12];
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.detailTextLabel.x = CGRectGetMaxX(self.textLabel.frame) + 5;
}
@end
