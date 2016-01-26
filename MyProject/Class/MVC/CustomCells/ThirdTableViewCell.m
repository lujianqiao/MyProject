//
//  ThirdTableViewCell.m
//  MyProject
//
//  Created by 千锋 on 16/1/11.
//  Copyright © 2016年 abc. All rights reserved.
//

#import "ThirdTableViewCell.h"

@implementation ThirdTableViewCell
{
    UILabel * _titleLabel;//标题
    UIImageView * _firstImage;//工资图片
    UILabel * _firstLabel;//工资标签
    UIImageView * _secondImage;//地点图片
    UILabel * _secondLabel;//地点标签
    UIImageView * _thirdImage;//工种经验图片
    UILabel * _thirdLabel;//工种经验标签
    UILabel * _fourthLabel;//工种类型图片
    UILabel * _fourthLabel2;//工种类型标签
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setFrame:(CGRect)frame
{
    frame.size.height-=5;
    [super setFrame:frame];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGSize size = self.frame.size;
    //标题
    if (!_titleLabel) {
        _titleLabel  =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 30)];
        [self.contentView addSubview:_titleLabel];
        _titleLabel.text = self.model.jobName;
     //   _titleLabel.backgroundColor = [UIColor redColor];
    }
    //工资
    if (!_firstImage) {
        _firstImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 30, size.width/9-20, size.width/9-20)];
        _firstImage.image = [UIImage imageNamed:@"tab_c0"];
        [self.contentView addSubview:_firstImage];
    }
    if (!_firstLabel) {
        _firstLabel = [[UILabel alloc]initWithFrame:CGRectMake(size.width/9, 20, size.width/9*2, size.width/9)];
        _firstLabel.text = self.model.salary;
        _firstLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_firstLabel];
    }
    //地点
    if (!_secondImage) {
        _secondImage = [[UIImageView alloc]initWithFrame:CGRectMake(size.width/9*3, 30, size.width/9-20, size.width/9-20)];
        _secondImage.image = [UIImage imageNamed:@"tab_c1"];
      //  _secondImage.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_secondImage];
    }
    if (!_secondLabel ) {
        _secondLabel = [[UILabel alloc]initWithFrame:CGRectMake(size.width/9*4, 20, size.width/9*2, size.width/9)];
        _secondLabel.text = self.model.address;
        _secondLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_secondLabel];
    }
    //工作经验
    if (!_thirdImage) {
        _thirdImage = [[UIImageView alloc]initWithFrame:CGRectMake(size.width/9*6, 30, size.width/9-20, size.width/9-20)];
        _thirdImage.image = [UIImage imageNamed:@"tab_c2"];
        [self.contentView addSubview:_thirdImage];
    }
    if (!_thirdLabel) {
        _thirdLabel= [[UILabel alloc]initWithFrame:CGRectMake(size.width/9*7, 20, size.width/9*2, size.width/9)];
        _thirdLabel.text = self.model.experience;
        _thirdLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_thirdLabel];
    }

    //公司名称
    if (!_fourthLabel) {
        _fourthLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, (30+size.width/12), 50, 30)];
        _fourthLabel.text = @"公司";
        _fourthLabel.textAlignment = NSTextAlignmentCenter;
        _fourthLabel.textColor = [UIColor orangeColor];
        [self.contentView addSubview:_fourthLabel];
    }
    if (!_fourthLabel2) {
        _fourthLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(50, (30+size.width/12), CGRectGetWidth(self.frame)-50, 30)];
        _fourthLabel2.text = self.model.company_name;
        _fourthLabel2.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_fourthLabel2];
    }
    
}

@end
