//
//  HBShareManager.h
//  HBSocialShareDemo
//
//  Created by wangfeng on 15/10/26.
//  Copyright (c) 2015年 HustBroventure. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface ShraeItems : NSObject

@property (nonatomic, copy) NSString* linkUrl;
@property (nonatomic, copy) NSString* imageUrl;
@property (nonatomic, copy) NSString* title;
@property (nonatomic, copy) NSString* body;

-(instancetype)initWithDic:(NSDictionary*)dic;
@end


@interface HBShareManager : NSObject

-(BOOL)shareLinkWith:(ShraeItems*)items;
@end

