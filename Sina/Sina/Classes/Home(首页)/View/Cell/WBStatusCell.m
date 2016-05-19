//
//  WBStatusCell.m
//  Sina
//
//  Created by Chia on 16/3/30.
//  Copyright © 2016年 WB. All rights reserved.
//

#import "WBStatusCell.h"
#import "WBOriginalView.h"
#import "WBRetweetView.h"
#import "WBStatusToolBar.h"
#import "WBStatus.h"

#import "WBStatusFrame.h"

@interface WBStatusCell()
@property (nonatomic, weak) WBOriginalView *original;
@property (nonatomic, weak) WBRetweetView *reTweet;
@property (nonatomic, weak) WBStatusToolBar *toolBar;
@end
@implementation WBStatusCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //添加子控件
        [self setUpAllChildView];
    }
    return self;
}

#pragma mark - 添加所有子控件
-(void)setUpAllChildView{
    //添加原创微博控件
    WBOriginalView *original = [[WBOriginalView alloc]init];
    [self addSubview:original];
    _original = original;
    //添加转发微博控件
    WBRetweetView *reTweet = [[WBRetweetView alloc]init];
    [self addSubview:reTweet];
    _reTweet = reTweet;
    //添加工具条
    WBStatusToolBar *toolBar= [[WBStatusToolBar alloc]init];
    [self addSubview:toolBar];
    _toolBar = toolBar;
}
-(void)setStatusF:(WBStatusFrame *)statusF{
    _statusF = statusF;
    
    // 设置原创微博frame & reload data
    _original.frame = statusF.originalViewFrame;
    _original.statusF = statusF;
    
    if (statusF.status.retweeted_status) {
        
        // 设置转发微博frame & reload data
        _reTweet.frame = statusF.retweetViewFrame;
        _reTweet.statusF = statusF;
        _reTweet.hidden = NO;
    }else{
        _reTweet.hidden = YES;
    }
    
    //设置工具条的frame
    _toolBar.frame = statusF.toolBarViewFrame;
    _toolBar.status = statusF.status;
}

+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"cell";
    id cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[self alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}
@end
