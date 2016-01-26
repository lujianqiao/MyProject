//
//  MoneyModel.m
//  MyProject
//
//  Created by 千锋 on 16/1/19.
//  Copyright © 2016年 abc. All rights reserved.
//

#import "MoneyModel.h"

@implementation MoneyModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
}

@end
