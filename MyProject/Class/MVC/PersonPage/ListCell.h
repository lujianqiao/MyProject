//
//  ListCell.h
//  MyProject
//
//  Created by 千锋 on 16/1/9.
//  Copyright (c) 2016年 abc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListCell : UITableViewCell

//图片名称
@property(nonatomic,copy)NSString * imgNameStr;

//对应的功能名称
@property(nonatomic,copy)NSString * functionName;
@end
