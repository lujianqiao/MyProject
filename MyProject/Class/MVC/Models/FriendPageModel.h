//
//  FriendPageModel.h
//  MyProject
//
//  Created by 千锋 on 16/1/12.
//  Copyright © 2016年 abc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FriendPageModel : NSObject
//"id": 1,//id
//"posterId": 1,//创建者id
//"creater": "超级管理员",//创建者姓名
//“head”:”xxxxx.jpg”//用户头像
//“level”:”0”//用户等级
//“level_name”:”实习”//用户等级名称
//"title": "测试帖子",//标题
//"previewUrl":
//"http://121.43.121.176/BlueCollar/images/3t/g5/1438824299071.jpg",//图片
//"content": "测试的一个帖子",//内容
//"detailUrl":
//"http://121.43.121.176/BlueCollar/services/posts/detail?type=3&id=1",//详情页面链接
//"postDate": 1438822470000, //创建时间
//"updateDate": 1438824300000, //更新时间
//“create_time”:”2015-11-20”//时间的字符串
//"upCnt": 0, //顶数
//"downCnt": 0, //浏览数·
//"replyCnt": 0//回复数

@property(nonatomic,copy)NSNumber * ID;
@property(nonatomic,copy)NSString * posterId;
@property(nonatomic,copy)NSString * creater;
@property(nonatomic,copy)NSString * head;
@property(nonatomic,copy)NSString * level;
@property(nonatomic,copy)NSString * level_name;
@property(nonatomic,copy)NSString * title;
@property(nonatomic,copy)NSString * previewUrl;
@property(nonatomic,copy)NSString * content;
@property(nonatomic,copy)NSString * detailUrl;
@property(nonatomic,copy)NSString * postDate;
@property(nonatomic,copy)NSString * updateDate;
@property(nonatomic,copy)NSString * create_time;
@property(nonatomic,assign)int  upCnt;
@property(nonatomic,assign)int  downCnt;
@property(nonatomic,assign)int  replyCnt;


@end
