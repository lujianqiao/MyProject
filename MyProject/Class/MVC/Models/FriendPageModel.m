//
//  FriendPageModel.m
//  MyProject
//
//  Created by 千锋 on 16/1/12.
//  Copyright © 2016年 abc. All rights reserved.
//

#import "FriendPageModel.h"

@implementation FriendPageModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
}

@end
