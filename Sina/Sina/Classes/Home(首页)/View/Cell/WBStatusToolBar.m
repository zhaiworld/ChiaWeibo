//
//  WBStatusToolBar.m
//  Sina
//
//  Created by Chia on 16/3/30.
//  Copyright © 2016年 WB. All rights reserved.
//

#import "WBStatusToolBar.h"
#import "UIView+Frame.h"
#import "WBStatus.h"

@interface WBStatusToolBar()
@property(nonatomic,strong) NSMutableArray *btns;
@property(nonatomic,strong) NSMutableArray *dividVs;

@property(nonatomic,weak) UIButton *retweet;
@property(nonatomic,weak) UIButton *comment;
@property(nonatomic,weak) UIButton *unlike;

@end
@implementation WBStatusToolBar

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self setUpAllChildView];

        self.userInteractionEnabled = YES;
        self.image = [UIImage imagewithStretchableName:@"timeline_card_bottom_background"];
    }
    return self;
}

-(NSMutableArray *)btns{
    if (_btns == nil) {
        _btns = [NSMutableArray array];
    }
    return _btns;
}

-(NSMutableArray *)dividVs{
    if (_dividVs == nil) {
        _dividVs = [NSMutableArray array];
    }
    return _dividVs;
}
#pragma mark - 添加所有子控件
-(void)setUpAllChildView{

    //转发
    UIButton *retweet = [self setUpOneBtnWith:@"转发" image:[UIImage imageNamed:@"timeline_icon_retweet"]];
    _retweet =retweet;
    //评论
    UIButton *comment = [self setUpOneBtnWith:@"评论" image:[UIImage imageNamed:@"timeline_icon_comment"]];
    _comment = comment;
    //赞
    UIButton *unlike = [self setUpOneBtnWith:@"赞" image:[UIImage imageNamed:@"timeline_icon_unlike"]];
    _unlike = unlike;

    //分隔线
    for (int i = 0; i < 2; i++) {
        UIImageView *divid = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timeline_card_bottom_line"]];
        [self.dividVs addObject:divid];
        [self addSubview:divid];
    }
}
-(UIButton*)setUpOneBtnWith:(NSString*)title image:(UIImage*)image{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [self addSubview:btn];
    [self.btns addObject:btn];
    
    return btn;
}
-(void)layoutSubviews{
    NSUInteger count = self.btns.count;
    CGFloat w = WBScreenWidth / count;
    CGFloat h = self.frame.size.height;
    CGFloat x = 0;
    CGFloat y = 0;
    for (int i=0; i < count; i++) {
        x = i * w;
        UIButton *btn = self.btns[i];
        btn.frame = CGRectMake(x, y, w, h);
    }
    
    int i = 1;
    for (UIImageView *divids in self.dividVs) {
        UIButton * btn = self.btns[i];
        divids.x = btn.x;
        i++;
    }
}

-(void)setStatus:(WBStatus *)status{
    _status = status;
    
    [self setBtn:_retweet title:status.reposts_count];
    [self setBtn:_retweet title:status.comments_count];
    [self setBtn:_retweet title:status.attitudes_count];

}

-(void)setBtn:(UIButton*)btn title:(int)count{
    
    NSString *title = nil;
    if (count) {
        if (count >10000) {
            CGFloat floatCount = count / 10000.0;
            title = [NSString stringWithFormat:@"%.1fw",floatCount];
            title = [title stringByReplacingOccurrencesOfString:@"0" withString:@""];
        }else{
            title = [NSString stringWithFormat:@"%d",count];
        }
    }
    [btn setTitle:title forState:UIControlStateNormal];
}
@end
