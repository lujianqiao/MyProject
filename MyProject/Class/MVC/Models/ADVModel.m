//
//  ADVModel.m
//  MyProject
//
//  Created by 千锋 on 16/1/14.
//  Copyright © 2016年 abc. All rights reserved.
//

#import "ADVModel.h"

@implementation ADVModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
}

@end
