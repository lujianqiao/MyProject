//
//  WorkPlaceDetailModel.m
//  MyProject
//
//  Created by 千锋 on 16/1/19.
//  Copyright © 2016年 abc. All rights reserved.
//

#import "WorkPlaceDetailModel.h"

@implementation WorkPlaceDetailModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
}

@end
