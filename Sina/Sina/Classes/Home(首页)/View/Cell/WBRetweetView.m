//
//  WBRetweetView.m
//  Sina
//
//  Created by Chia on 16/3/30.
//  Copyright © 2016年 WB. All rights reserved.
//

#import "WBRetweetView.h"
#import "WBStatus.h"
#import "WBStatusFrame.h"
#import "WBPhotosView.h"

@interface WBRetweetView()
@property(nonatomic,weak) UILabel *nameView;
@property(nonatomic,weak) UILabel *textView;
@property(nonatomic,weak) WBPhotosView *photosView;
@end

@implementation WBRetweetView

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self setUpAllChildView];
        self.userInteractionEnabled = YES;
        self.image = [UIImage imagewithStretchableName:@"timeline_retweet_background"];
//        UIColor *bgColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_retweet_background"]];
//        [self setBackgroundColor:bgColor];
    }
    return self;
}

#pragma mark - 添加所有子控件
-(void)setUpAllChildView{
    //昵称
    UILabel *nameView = [[UILabel alloc]init];
    nameView.font = WBNameFont;
    nameView.textColor = [UIColor blueColor];
    [self addSubview:nameView];
    _nameView = nameView;
    
    //正文
    UILabel *textView = [[UILabel alloc]init];
    textView.font = WBTextFont;
    //设置换行
    textView.numberOfLines = 0;
    [self addSubview:textView];
    _textView = textView;
    //配图
    WBPhotosView *photosView = [[WBPhotosView alloc] init];
    [self addSubview:photosView];
    _photosView = photosView;
}

-(void)setStatusF:(WBStatusFrame *)statusF{
    _statusF = statusF;
    
    WBStatus *status = statusF.status;
    //set frame
    _nameView.frame = statusF.retweetNameFrame;
    //set name context
    _nameView.text = status.retweetName;
    
    //set text frame
    _textView.frame = statusF.retweetTextFrame;
    //set text context
    _textView.text = status.retweeted_status.text;
    
    //配图
    
    _photosView.frame = statusF.retweetPhotosFrame;
    _photosView.pic_urls = status.retweeted_status.pic_urls;
}

@end
