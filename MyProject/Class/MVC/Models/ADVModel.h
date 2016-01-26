//
//  ADVModel.h
//  MyProject
//
//  Created by 千锋 on 16/1/14.
//  Copyright © 2016年 abc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ADVModel : NSObject

@property(nonatomic,assign)int adv_type;
@property(nonatomic,copy)NSString * content;
@property(nonatomic,assign)int create_time;
@property(nonatomic,copy)NSString * detail_url;
@property(nonatomic,assign)NSNumber * ID;
@property(nonatomic,copy)NSString * img_src;

@end
