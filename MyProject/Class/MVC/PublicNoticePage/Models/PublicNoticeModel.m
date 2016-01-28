//
//  PublicNoticeModel.m
//  MyProject
//
//  Created by 千锋 on 16/1/18.
//  Copyright © 2016年 abc. All rights reserved.
//

#import "PublicNoticeModel.h"

@implementation PublicNoticeModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
}
@end
