//
//  WBComposeViewController.m
//  Sina
//
//  Created by Chia on 16/4/15.
//  Copyright © 2016年 WB. All rights reserved.
//

#import "WBComposeViewController.h"
#import "WBTextView.h"
#import "WBComposeToolBar.h"
#import "WBComposePhotosView.h"
#import "WBComposeTool.h"
#import "MBProgressHUD+MJ.h"




@interface WBComposeViewController ()<UITextViewDelegate, WBComposeToolBarDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property(nonatomic, strong) WBTextView *textV;
@property(nonatomic, strong) WBComposeToolBar *toolBar;
@property(nonatomic, strong) WBComposePhotosView *photoV;
@property(nonatomic, strong) UIBarButtonItem *rightBtn;
@property(nonatomic, strong) NSMutableArray *images;

@end

@implementation WBComposeViewController
-(NSMutableArray *)images
{
    if (_images == nil) {
        _images = [NSMutableArray array];
    }
    return _images;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    //设置导航
    [self setUpNavigationBar];
    //设置文本区
    [self setUpTextView];
    //设置工具条
    [self setUpToolBar];
    //监听键盘弹出
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    //设置图片区
    [self setUpPhotosView];

}
#pragma mark ----设置图片区
-(void)setUpPhotosView
{
    WBComposePhotosView *photoV = [[WBComposePhotosView alloc] initWithFrame:CGRectMake(0, 70, self.view.width, self.view.height - 70)];
    _photoV = photoV;
    [_textV addSubview:photoV];
}
#pragma mark -----完成选择图片时调用
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    NSLog(@"info%@",info);
    //获取选中的图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    _photoV.image = image;
    [self.images addObject:image];
    _rightBtn.enabled = YES;
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)keyboardFrameChange:(NSNotification *)note
{
//    NSLog(@"keyboard%@",note.userInfo);
    //获取键盘的frame
    CGRect frame = [[note.userInfo objectForKey:@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    if (frame.origin.y == self.view.height) {//没有弹出键盘
        _toolBar.transform = CGAffineTransformIdentity;
    }else{//弹出键盘
        _toolBar.transform = CGAffineTransformMakeTranslation(0, -frame.size.height);
    }
}
#pragma mark ----设置工具条
-(void)setUpToolBar
{
    CGFloat y = CGRectGetMaxY(self.view.frame);
    WBComposeToolBar *toolBar = [[WBComposeToolBar alloc] initWithFrame:CGRectMake(0, y-35, self.view.bounds.size.width, 35)];
    _toolBar = toolBar;
    toolBar.delegate = self;
    [self.view addSubview:toolBar];
}
#pragma mark ----点击工具条按钮时调用
-(void)composeToolBar:(WBComposeToolBar *)toolBar didClickBtn:(NSInteger)index
{
    if (index == 0) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        
        imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        imagePicker.delegate = self;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
}
#pragma mark ----设置文本区
-(void)setUpTextView
{
    WBTextView *textV = [[WBTextView alloc] initWithFrame:self.view.bounds];
    _textV = textV;
    textV.placeHolder = @"发布新鲜事";
    
    [self.view addSubview:textV];
    //默认允许垂直拖拽操作
    textV.alwaysBounceVertical = YES;
    //监听文本框输入事件
    /**
     *  observer:谁需要监听
     *  name:监听的通知名称
     *  object:监听谁发送的通知 nil表示谁发送我都监听
     *
     */
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextViewTextDidChangeNotification object:nil];
    //监听 拖拽事件
    _textV.delegate = self;
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
//    [_textV resignFirstResponder];
    [_textV endEditing:YES];

}
//监听输入有内容有变化时调用
-(void)textChange
{
    if (_textV.text.length) {//说明有内容
        _textV.hiddenPlaceHolder = YES;
        _rightBtn.enabled = YES;
    }else{//说明没有内容
        _textV.hiddenPlaceHolder = NO;
        _rightBtn.enabled = NO;

    }
}
//界面出现时，默认弹出键盘
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_textV becomeFirstResponder];
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark ---设置导航
-(void)setUpNavigationBar
{
    self.navigationItem.title = @"发微博";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:0 target:self action:@selector(cancle)];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"发送" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    [btn sizeToFit];
    [btn addTarget:self action:@selector(compose) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBtn =  [[UIBarButtonItem alloc] initWithCustomView:btn];
    rightBtn.enabled = NO;
    _rightBtn = rightBtn;
    self.navigationItem.rightBarButtonItem =rightBtn;
}
-(void)cancle
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark ----发送微博
-(void)compose
{
    if (self.images.count) {//有图片
        //
        [self sentPic];
    }else{//仅文字
        [self sendText];
    }
    
}
#pragma mark ---发送文字微博
-(void)sentPic
{
    UIImage *image = self.images[0];
    NSString *status = _textV.text.length?_textV.text:@"分享图片";
    [MBProgressHUD showMessage:@"正在发送中..."];
    [WBComposeTool composeWithStatus:status image:image success:^{
        [MBProgressHUD hideHUD];
        //
        [MBProgressHUD showSuccess:@"发送成功"];
        [self dismissViewControllerAnimated:YES completion:nil];
    } failure:^(NSError *error) {
        //
        NSLog(@"failure");
    }];
}
#pragma mark ---发送文字微博
-(void)sendText
{
    [MBProgressHUD showMessage:@"正在发送中..."];
    
    [WBComposeTool composeWithStatus:_textV.text success:^{
        //success
        [MBProgressHUD hideHUD];
        [self dismissViewControllerAnimated:YES completion:nil];
        [MBProgressHUD showSuccess:@"发送成功"];
    } failure:^(NSError *error) {
        //failure
        NSLog(@"failure");
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
