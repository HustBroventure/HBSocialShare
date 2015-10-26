//
//  HBSocialShareView.m
//  HBSocialShareDemo
//
//  Created by wangfeng on 15/10/21.
//  Copyright (c) 2015年 HustBroventure. All rights reserved.
//

#import "HBSocialShareView.h"
    //背景色
#define BG_COLOR  [[UIColor blackColor] colorWithAlphaComponent:0.3];
    //sheet高度
#define CONTAINER_HEIGHT  (190.0f)
    //按钮高度
#define BUTTON_HEIGHT  (44.0f)
    //按钮高度
#define ITEM_WIDTH  (80.0f)

@interface HBSocialShareView()<UIGestureRecognizerDelegate>
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
        [self initData];
        [self initSubView];
        [self setItems];

        
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
-(void)initData
{
    _itemTitleArray = @[@"微信",@"微信朋友圈",@"qq好友",@"qq空间",@"新浪微博",@"短信",@"邮箱",@"复制链接"];
}
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
-(void)setItems
{
    for (int i = 0; i < _itemTitleArray.count; i++) {
        UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = [UIColor blueColor];
        button.frame = CGRectMake(i * ITEM_WIDTH +10*(i+1) , 0, ITEM_WIDTH, ITEM_WIDTH);
        button.layer.cornerRadius = 4.0f;
        button.layer.masksToBounds = YES;
        [self.scrollView addSubview:button];



        UILabel* title = [[UILabel alloc]initWithFrame:CGRectMake(button.frame.origin.x, button.frame.origin.y + ITEM_WIDTH + 5 , ITEM_WIDTH, 10)];
        title.text = _itemTitleArray[i];
        title.textAlignment = NSTextAlignmentCenter;
        title.font = [UIFont systemFontOfSize:12];
        title.adjustsFontSizeToFitWidth = YES;
        [self.scrollView addSubview:title];




    }
    self.scrollView.contentSize = CGSizeMake((ITEM_WIDTH +10)*_itemTitleArray.count +10, 0);



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
//        UIVisualEffectView *visualEffect = [[UIVisualEffectView alloc]initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight]];
//
//        visualEffect.frame = _containerView.bounds;
//
//        visualEffect.alpha = 0.9;
//            //visualEffect.backgroundColor = [UIColor redColor];
//
//        [_containerView addSubview:visualEffect];

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
        _tap.delegate = self;
    }
    return _tap;
}
-(UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, BUTTON_HEIGHT, _width,CONTAINER_HEIGHT - BUTTON_HEIGHT * 2)];
            _scrollView.backgroundColor =  [UIColor whiteColor];


    }
    return _scrollView;
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    CGPoint point = [touch locationInView:self];
    if (point.y < self.frame.size.height -  CONTAINER_HEIGHT) {
        return YES;
    }
    return NO;
}
@end
