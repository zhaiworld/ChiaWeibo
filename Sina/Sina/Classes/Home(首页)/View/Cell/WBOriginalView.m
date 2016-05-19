//
//  WBOriginalView.m
//  Sina
//
//  Created by Chia on 16/3/30.
//  Copyright © 2016年 WB. All rights reserved.
//

#import "WBOriginalView.h"
#import "WBStatusFrame.h"
#import "WBUser.h"
#import "WBStatus.h"
#import "UIImageView+WebCache.h"
#import "WBPhotosView.h"

@interface WBOriginalView()
@property(nonatomic,weak) UIImageView *iconView;
@property(nonatomic,weak)     UILabel *nameView;
@property(nonatomic,weak) UIImageView *vipView;
@property(nonatomic,weak)     UILabel *timeView;
@property(nonatomic,weak)     UILabel *sourceView;
@property(nonatomic,weak)     UILabel *textView;
@property(nonatomic,weak) WBPhotosView *photosView;
@end

@implementation WBOriginalView

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self setUpAllChildView];
        self.userInteractionEnabled = YES;
        self.image = [UIImage imagewithStretchableName:@"timeline_card_top_background"];
    }
    return self;
}

#pragma mark - 添加所有子控件
-(void)setUpAllChildView{
    //头像
    UIImageView *iconView = [[UIImageView alloc]init];
    [self addSubview:iconView];
    _iconView = iconView;
    //昵称
    UILabel *nameView = [[UILabel alloc]init];
    nameView.font = WBNameFont;
    [self addSubview:nameView];
    _nameView = nameView;
    //Vip
    UIImageView *vipView = [[UIImageView alloc]init];
    [self addSubview:vipView];
    _vipView = vipView;
    //时间
    UILabel *timeView = [[UILabel alloc]init];
    timeView.font = WBTimeFont;
    [self addSubview:timeView];
    _timeView = timeView;
    //来源
    UILabel *sourceView = [[UILabel alloc]init];
    sourceView.font = WBSourceFont;
    [self addSubview:sourceView];
    _sourceView = sourceView;
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
    //set
    _statusF = statusF;
    //设置frame
    [self setUpFrame];
    
    //设置data
    [self setUpData];
}
-(void)setUpFrame{
    //头像
    _iconView.frame = _statusF.originalIconFrame;
    
    //昵称
    _nameView.frame = _statusF.originalNameFrame;
    
    //VIP
    if (_statusF.status.user.vip) {
        _vipView.hidden = NO;
        _vipView.frame = _statusF.originalVipFrame;
    } else {
        _vipView.hidden = YES;
    }
    
    //time
    WBStatus *status = _statusF.status;
    CGFloat timeX = _nameView.frame.origin.x;
    CGFloat timeY = CGRectGetMaxY(_nameView.frame) + WBStatusCellMargin*0.5;
    NSMutableDictionary *timeDict = [NSMutableDictionary dictionary];
    timeDict[NSFontAttributeName] = WBTimeFont;
    CGSize timeSize = [status.created_at sizeWithAttributes:timeDict];
    _timeView.frame = (CGRect){{timeX, timeY},timeSize};
    
    //source
    CGFloat sourceX = CGRectGetMaxX(_timeView.frame) + WBStatusCellMargin;
    CGFloat sourceY = timeY;
    NSMutableDictionary *sourceDict = [NSMutableDictionary dictionary];
    sourceDict[NSFontAttributeName] = WBSourceFont;
    CGSize sourceSize = [status.source sizeWithAttributes:sourceDict];
    _sourceView.frame = (CGRect){{sourceX, sourceY}, sourceSize};
    
    //text
    _textView.frame = _statusF.originalTextFrame;
    //pic_ids
    _photosView.frame = _statusF.originalPhotosFrame;
}

-(void)setUpData{
    
    WBStatus *status = _statusF.status;
    
    //头像
    [_iconView sd_setImageWithURL:status.user.profile_image_url placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    
    //昵称
    _nameView.text = status.user.name;
    if (status.user.vip) {
        _nameView.textColor = [UIColor redColor];
    }else{
        _nameView.textColor = [UIColor blackColor];
    }
    
    //VIP
    NSString *imageName = [NSString stringWithFormat:@"common_icon_membership_level%d",status.user.mbrank];
    _vipView.image = [UIImage imageNamed:imageName];
    
    //时间
    _timeView.text = status.created_at;
    //来源
    _sourceView.text = status.source;
    
    //正文
    _textView.text = status.text;
    
    //配图
    _photosView.pic_urls= status.pic_urls;
    
}

@end




