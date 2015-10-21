//
//  HBSocialShareView.h
//  HBSocialShareDemo
//
//  Created by wangfeng on 15/10/21.
//  Copyright (c) 2015年 HustBroventure. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum : NSUInteger {
    WeChatFriend = 0,
    WeChatCircle,
    QQFriend,
    QQZOne,
} ShareType;
typedef void(^ButtonClickBLock)(ShareType shareType);

@interface HBSocialShareView : UIView

@property (nonatomic, strong) ButtonClickBLock buttonClickBlock;
+(void)showInView:(UIView*)view;
@end

