//
//  WBBasicCell.h
//  Sina
//
//  Created by Chia on 16/4/21.
//  Copyright © 2016年 WB. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WBCellItem;
@interface WBBasicCell : UITableViewCell

@property(nonatomic ,strong ) WBCellItem *item;

+(instancetype)cellWithTableView:(UITableView*)tableView;

@end
