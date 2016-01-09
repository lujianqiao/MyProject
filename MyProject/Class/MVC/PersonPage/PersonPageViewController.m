//
//  PersonPageViewController.m
//  MyProject
//
//  Created by 千锋 on 16/1/8.
//  Copyright (c) 2016年 abc. All rights reserved.
//

#import "PersonPageViewController.h"
#import "ListCell.h"

@interface PersonPageViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *userIconImage;
@property (weak, nonatomic) IBOutlet UITextField *UserName;
@property (weak, nonatomic) IBOutlet UIButton *userTEXT;
@property (weak, nonatomic) IBOutlet UIButton *userANSWER;
@property (weak, nonatomic) IBOutlet UIButton *outBUTTON;



- (IBAction)userText:(UIButton *)sender;
- (IBAction)userAnswer:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITableView *listTableView;
- (IBAction)outButton:(UIButton *)sender;
//图片名称
@property(nonatomic,strong)NSArray * imageNameArr;
//功能名称
@property(nonatomic,strong)NSArray * functionName;

@end



@implementation PersonPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.userIconImage.layer.cornerRadius=50;
    self.listTableView.delegate=self;
    self.listTableView.dataSource=self;
    [self creatBackgroundImage];
    // Do any additional setup after loading the view.
}
//设置背景图片及改变各个按钮的大小
-(void)creatBackgroundImage
{
    //设置背景图片
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    imageView.userInteractionEnabled=YES;
    [self.view addSubview:imageView];
    [self.view sendSubviewToBack:imageView];
    imageView.image=[UIImage imageNamed:@"Default-568h"];
    //改变登出按钮的圆角
    self.outBUTTON.layer.cornerRadius=15;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//懒加载
-(NSArray *)imageNameArr
{
    if (_imageNameArr==nil) {
        _imageNameArr=@[@"icon_baoliao_s",@"icon_msg_s",@"icon_setting_s",@"icon_home_s",@"icon_favorite_s"];
    }
    return _imageNameArr;
}

-(NSArray *)functionName
{
    if (_functionName==nil) {
        _functionName=@[@"公告",@"我的简历",@"编辑个人信息",@"系统",@"邀请码"];
    }
    return _functionName;
}

- (IBAction)userText:(UIButton *)sender {
}

- (IBAction)userAnswer:(UIButton *)sender {
}
- (IBAction)outButton:(UIButton *)sender {
    NSLog(@"退出");
}

#pragma mark-TableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.imageNameArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.imgNameStr = self.imageNameArr[indexPath.row];
    cell.functionName = self.functionName[indexPath.row];
    return cell;
    
}
@end
