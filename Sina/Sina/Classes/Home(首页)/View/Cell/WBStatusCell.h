//
//  WBStatusCell.h
//  Sina
//
//  Created by Chia on 16/3/30.
//  Copyright © 2016年 WB. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WBStatusFrame;
@interface WBStatusCell : UITableViewCell
@property(nonatomic, strong) WBStatusFrame *statusF;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
