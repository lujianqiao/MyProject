//
//  ListCell.m
//  MyProject
//
//  Created by 千锋 on 16/1/9.
//  Copyright (c) 2016年 abc. All rights reserved.
//

#import "ListCell.h"

@implementation ListCell



-(void)setImgNameStr:(NSString *)imgNameStr
{
    
    self.imageView.image=[UIImage imageNamed:imgNameStr];
}

-(void)setFunctionName:(NSString *)functionName
{
    self.textLabel.text = functionName;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
