//
//  HBSocialShareView.m
//  HBSocialShareDemo
//
//  Created by wangfeng on 15/10/21.
//  Copyright (c) 2015年 HustBroventure. All rights reserved.
//

#import "HBSocialShareView.h"

#define BG_COLOR  [[UIColor blackColor] colorWithAlphaComponent:0.3];
#define CONTAINER_HEIGHT  (300.0f)

#define BUTTON_HEIGHT  (44.0f)

@interface HBSocialShareView()
@property (nonatomic, strong) UIView* containerView;
@property (nonatomic, strong) UILabel* topInfoLabel;
@property (nonatomic, strong) UIButton* cancleButton;

@property (nonatomic, strong) UIScrollView* scrollView;
@property (nonatomic, strong) UIPageControl* pageControl;
@property (nonatomic, strong) UITapGestureRecognizer* tap;


@end
@implementation HBSocialShareView
{
    NSArray* _itemTitleArray;
    NSArray* _itemImageArray;
    CGFloat  _width;
    CGFloat  _height;
}
#pragma mark - public methords
-(instancetype)init
{
    if (self = [super init]) {
        [self initSubView];
        
    }
    return self;
}
+(void)showInView:(UIView*)view
{
    HBSocialShareView* shareView = [[HBSocialShareView alloc]init];
    [view.window addSubview:shareView];
    [shareView showSheet];
}

#pragma mark - private-tools methords
-(void)initSubView
{
        //一开始显示透明颜色
    self.backgroundColor = [UIColor clearColor];
    _width = [UIScreen mainScreen].bounds.size.width;
    _height = [UIScreen mainScreen].bounds.size.height;
    self.frame = CGRectMake(0, 0, _width, _height);
    [self addGestureRecognizer:self.tap];
    [self.containerView addSubview:self.topInfoLabel];
    [self.containerView addSubview:self.scrollView];
    [self.containerView addSubview:self.cancleButton];
    [self addSubview:self.containerView];

}
-(void)showSheet
{
    [UIView animateWithDuration:0.25 animations:^{
        self.backgroundColor = BG_COLOR;
        CGRect containerFrame = self.containerView.frame;
        containerFrame.origin.y = _height -  CONTAINER_HEIGHT;
        self.containerView.frame = containerFrame;
        
    } completion:^(BOOL finished) {
        
    }];
}
-(void)dismissSheet
{
    [UIView animateWithDuration:0.25 animations:^{
        
        self.backgroundColor =[UIColor clearColor];
        CGRect containerFrame = self.containerView.frame;
        containerFrame.origin.y = _height;
        self.containerView.frame = containerFrame;

        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
-(UIButton*)createItemButtonWithTitle:(NSString*)title andImageName:(NSString*)imageName
{
    UIButton* item = [UIButton buttonWithType:UIButtonTypeCustom];
    
    
    return item;
}
#pragma mark - property-setter-getter


#pragma mark - event methords
-(void)buttonClick:(UIButton*)sender
{
    ShareType type = sender.tag;
    if (self.buttonClickBlock) {
        self.buttonClickBlock(type);
    }
    [self dismissSheet];
}

#pragma mark - delegate methords
-(UIView *)containerView
{
    if (!_containerView) {
    
        _containerView = [[UIView alloc]initWithFrame:CGRectMake(0, _height, _width,CONTAINER_HEIGHT)];
        _containerView.backgroundColor = [UIColor whiteColor];

    }
    return _containerView;
}
-(UIButton *)cancleButton
{
    if (!_cancleButton) {
        _cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancleButton setTitle:@"取消" forState:UIControlStateNormal];
        [ _cancleButton setBackgroundColor:[UIColor colorWithWhite:0.9 alpha:0.9]];
        //[_cancleButton setBackgroundImage:<#(UIImage *)#> forState:<#(UIControlState)#>]
        [_cancleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _cancleButton.frame = CGRectMake(0,CONTAINER_HEIGHT - BUTTON_HEIGHT, _width, BUTTON_HEIGHT);
        [_cancleButton addTarget:self action:@selector(dismissSheet) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancleButton;
}
-(UILabel *)topInfoLabel
{
    if (!_topInfoLabel) {
        _topInfoLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0,_width ,BUTTON_HEIGHT)];
        _topInfoLabel.textAlignment = NSTextAlignmentCenter;
        _topInfoLabel.text = @"分享";
    }
    return _topInfoLabel;
}
-(UITapGestureRecognizer *)tap
{
    if (!_tap) {
        _tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissSheet)];
    }
    return _tap;
}
-(UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, BUTTON_HEIGHT, _width,CONTAINER_HEIGHT - BUTTON_HEIGHT * 2)];
        _scrollView.backgroundColor =  [UIColor colorWithWhite:0.8 alpha:0.9];


    }
    return _scrollView;
}
@end
