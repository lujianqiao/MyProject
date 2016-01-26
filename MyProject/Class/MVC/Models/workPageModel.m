//
//  workPageModel.m
//  MyProject
//
//  Created by 千锋 on 16/1/12.
//  Copyright © 2016年 abc. All rights reserved.
//

#import "workPageModel.h"

@implementation workPageModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.ID=value;
    }
}


@end
