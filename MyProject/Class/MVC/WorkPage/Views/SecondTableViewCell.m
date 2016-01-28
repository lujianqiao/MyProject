//
//  SecondTableViewCell.m
//  MyProject
//
//  Created by 千锋 on 16/1/11.
//  Copyright © 2016年 abc. All rights reserved.
//

#import "SecondTableViewCell.h"
#import "workPageModel.h"
#import "UIImageView+WebCache.h"

#define PAGE_TAG 10
@interface SecondTableViewCell ()<UIScrollViewDelegate>

{
    UIView * _view;
    UIScrollView * _scrollView;//加载可以左右滑动工种信息的scrollView;
    UIPageControl * _pageController;
}
@end

@implementation SecondTableViewCell

//懒加载
-(NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
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
    frame.size.height-=15;
    [super setFrame:frame];
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    CGSize size = self.frame.size;
    
    for (UIView *v in self.contentView.subviews) {
        [v removeFromSuperview];
    }
    
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.bounces = NO;
    [self.contentView addSubview:_scrollView];
  //  _scrollView.backgroundColor = [UIColor yellowColor];
    for (int index =0; index<self.dataArray.count; index ++) {
        _view = [[UIView alloc]initWithFrame:CGRectMake(size.width*(index/2), size.height*(index%2)/2, size.width, size.height/2-0.5)];
        _view.backgroundColor = [UIColor whiteColor];
        [_scrollView addSubview:_view];
        _view.layer.cornerRadius = 15 ;
    _scrollView.contentSize = CGSizeMake(self.dataArray.count/2*size.width, size.height) ;
        //公司LOGO
    UIImageView * IconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetHeight(_view.frame), CGRectGetHeight(_view.frame))];
    IconImageView.backgroundColor = [UIColor redColor];
        IconImageView.layer.masksToBounds=YES;
        IconImageView.layer.cornerRadius =(CGRectGetHeight(_view.frame)-10)/2;
        
    [_view addSubview:IconImageView];
        //工种标签
    UILabel * jobLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(IconImageView.frame)+size.width/20, 0, size.width/5*3, CGRectGetHeight(_view.frame)/3)];
  //  jobLabel.backgroundColor = [UIColor purpleColor];
    [_view addSubview:jobLabel];
        //公司名称
    UILabel * companyLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(IconImageView.frame)+size.width/20, CGRectGetHeight(_view.frame)/2, size.width/5*2, CGRectGetHeight(_view.frame)/2)];
        companyLabel.font = [UIFont systemFontOfSize:15];
  //  companyLabel.backgroundColor = [UIColor blackColor];
    [_view addSubview:companyLabel];
        //工资
    UILabel * wageLabel = [[UILabel alloc]initWithFrame:CGRectMake((CGRectGetWidth(companyLabel.frame)+CGRectGetWidth(IconImageView.frame)+size.width/10), CGRectGetHeight(_view.frame)/2, CGRectGetWidth(_view.frame)-(CGRectGetWidth(jobLabel.frame)-CGRectGetWidth(IconImageView.frame)), CGRectGetHeight(_view.frame)/2)];
        wageLabel.textColor = [UIColor orangeColor];
 //   wageLabel.backgroundColor = [UIColor yellowColor];
    [_view addSubview:wageLabel];
        workPageModel * model = self.dataArray[index];
        [IconImageView sd_setImageWithURL:[NSURL URLWithString:model.logo]];
        jobLabel.text = model.jobName;
        companyLabel.text = model.company_name;
        wageLabel.text = model.salary;
        _view.userInteractionEnabled = YES;
        _view.tag = [model.ID integerValue];
        UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ToADVDetailPage:)];
        [_view addGestureRecognizer:tapGesture];
     
    }
    
    //创建页面指示器
   _pageController = [[UIPageControl alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame), 100, 20)];
    [self.contentView addSubview:_pageController];
    _pageController.numberOfPages = self.dataArray.count/2;
    _pageController.currentPage = 0;
    _pageController.pageIndicatorTintColor = [UIColor grayColor];
    _pageController.currentPageIndicatorTintColor = [UIColor orangeColor];
}

-(void)ToADVDetailPage:(UITapGestureRecognizer *)sender
{
    NSLog(@"regqergyweqrhtyhhhhhhh");
    UIView * tempView = [sender view];
    NSInteger tempIndex = tempView.tag;
    
    for (int index=0; index<self.dataArray.count; index++) {
        workPageModel * model = self.dataArray[index];
     //   NSInteger integer = [model.ID integerValue];
        if (tempIndex==[model.ID integerValue]) {
            NSLog(@"-=-=-=-=-===%@",[NSString stringWithFormat:@"%@",model.ID]);
            //设置监听
//            [[NSNotificationCenter defaultCenter]postNotificationName:[NSString stringWithFormat:@"%@",model.ID]object:model.detailUrl];
        
              [[NSNotificationCenter defaultCenter]postNotificationName:[NSString stringWithFormat:@"%@",model.ID] object:model];
        }
    }
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger currentPage = scrollView.contentOffset.x/scrollView.frame.size.width;
    _pageController.currentPage = currentPage;
}
@end
