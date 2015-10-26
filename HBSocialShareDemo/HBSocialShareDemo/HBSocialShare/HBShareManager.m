//
//  HBShareManager.m
//  HBSocialShareDemo
//
//  Created by wangfeng on 15/10/26.
//  Copyright (c) 2015年 HustBroventure. All rights reserved.
//

#import "HBShareManager.h"
#import "HBSocialShareView.h"
@implementation HBShareManager


-(BOOL)shareLinkWith:(ShraeItems*)items
{
    return NO;
}

@end
@implementation ShraeItems

-(instancetype)initWithDic:(NSDictionary *)dic
{
    if (!dic) {
        return nil;
    }
    if(self  = [super init]){
        NSArray* keys = [dic allKeys];
        for (NSString* key in keys) {
            NSObject* value = dic[key];
            if (value == [NSNull null]) {
                value = @"";
            }
            [self setValue:value forKey:key];
        }


    }
    return self;
}

@end