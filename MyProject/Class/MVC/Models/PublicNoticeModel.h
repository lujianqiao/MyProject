//
//  PublicNoticeModel.h
//  MyProject
//
//  Created by 千锋 on 16/1/18.
//  Copyright © 2016年 abc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PublicNoticeModel : NSObject

@property(nonatomic,copy)NSString * content;
@property(nonatomic,assign)NSInteger  create_time;
@property(nonatomic,copy)NSString * detail_url;
@property(nonatomic,assign)NSNumber * ID;
@end
