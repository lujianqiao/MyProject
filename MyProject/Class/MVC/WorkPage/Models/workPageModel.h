//
//  workPageModel.h
//  MyProject
//
//  Created by 千锋 on 16/1/12.
//  Copyright © 2016年 abc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface workPageModel : NSObject

//    "logo" : "http:\/\/121.43.121.176\/BlueCollar\/images\/zn\/5H\/1452222180961.jpg",
//    "id" : 62,
//    "jobType" : 2,
//    "education" : "专科",
//    "jobName" : "销售代表",
//    "address" : "成都市\r",
//    "require" : null,
//    "company_id" : 39,
//    "salary" : "2001-3000",
//    "description" : null,
//    "is_new" : 1,
//    "istop" : true,
//    "number" : null,
//    "duty" : null,
//    "top_time" : null,
//    "create_time" : null,
//    "person" : null,
//    "work_type" : "销售",
//    "city" : null,
//    "has_resume" : null,
//    "commission" : null,
//    "province" : null,
//    "delete" : null,
//    "detailUrl" : "http:\/\/121.43.121.176\/BlueCollar\/services\/job\/detail?id=62",
//    "age" : null,
//    "head_img" : null,
//    "company_name" : "交通银行",
//    "language" : null,
//    "phone" : null,
//    "isComm" : false,
//    "experience" : "应届毕业生",
//    "posts_time" : null,
//    "is_recruiter" : null
@property(nonatomic,copy)NSString * logo;
@property(nonatomic,copy)NSNumber * ID;
@property(nonatomic,copy)NSString * jobType;
@property(nonatomic,copy)NSString * education;
@property(nonatomic,copy)NSString * jobName;
@property(nonatomic,copy)NSString * address;
@property(nonatomic,copy)NSString * require;
@property(nonatomic,copy)NSNumber * company_id;
@property(nonatomic,copy)NSString * salary;
@property(nonatomic,copy)NSString * is_new;
@property(nonatomic,copy)NSString * istop;
@property(nonatomic,copy)NSString * work_type;
@property(nonatomic,copy)NSString * detailUrl;
@property(nonatomic,copy)NSString * company_name;
@property(nonatomic,copy)NSString * isComm;
@property(nonatomic,copy)NSString * experience;

@end
