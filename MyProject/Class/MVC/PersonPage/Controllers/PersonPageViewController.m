//
//  PersonPageViewController.m
//  MyProject
//
//  Created by 千锋 on 16/1/8.
//  Copyright (c) 2016年 abc. All rights reserved.
//

#import "PersonPageViewController.h"
#import "ListCell.h"
#import "MyResumeViewController.h"
#import "EditPersonInfoViewController.h"
#import "SystemViewController.h"
#import "UMSocial.h"

//选择相机或相册枚举
typedef NS_ENUM(NSInteger,ChosePhotoType)
{
  ChosePhotoTypeAlbum,
    ChosePhotoTypeCamera
};

@interface PersonPageViewController ()<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

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
    [SVProgressHUD dismiss];
    self.userIconImage.layer.cornerRadius=50;
    self.listTableView.delegate=self;
    self.listTableView.dataSource=self;
    [self creatBackgroundImage];
    self.userIconImage.userInteractionEnabled = YES;
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
        _imageNameArr=@[@"icon_msg_s",@"icon_setting_s",@"icon_home_s",@"icon_favorite_s"];
    }
    return _imageNameArr;
}

-(NSArray *)functionName
{
    if (_functionName==nil) {
        _functionName=@[@"我的简历",@"编辑个人信息",@"系统",@"邀请码"];
    }
    return _functionName;
}
//分享按钮
- (IBAction)shareBurron:(UIBarButtonItem *)sender {
    [UMSocialSnsService presentSnsIconSheetView:self appKey:@"56a088b567e58e8baa0001d6" shareText:@"" shareImage:[UIImage imageNamed:@"icon_favorite_s@2x.png"] shareToSnsNames:nil delegate:nil];
}

//更换头像实现
- (IBAction)changeUserIcon:(UITapGestureRecognizer *)sender {
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"选择相片" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction * album =[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self chosePhoto:ChosePhotoTypeAlbum];
    }];
    UIAlertAction * camera = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self chosePhoto:ChosePhotoTypeCamera];
    }];
    UIAlertAction * cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:album];
    [alert addAction:camera];
    [alert addAction:cancle];
    
    [self presentViewController:alert animated:YES completion:^{
        
    }];
}


//选择相片
-(void)chosePhoto:(ChosePhotoType)type
{
    UIImagePickerController * picker = [[UIImagePickerController alloc]init];
    picker.delegate = self;
    picker.allowsEditing =YES;
    if (type == ChosePhotoTypeAlbum) {
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    else if (type == ChosePhotoTypeCamera)
    {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        }
        else
        {
            [SVProgressHUD showErrorWithStatus:@"相机不可用"];
            return;
        }
    }
    [self presentViewController:picker animated:YES completion:^{
        
    }];
    
}
//选择相片后回调
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage * img = info[UIImagePickerControllerOriginalImage];
  //  self.userIconImage.image = img;
    NSLog(@"img-------%@",img);

    //对图片大小进行压缩
    //  img = [self imageWithImage:img scaledToSize:imageSize];
  //  img = [UIImage imageWithCGImage:img scale:imageSize orientation:UIImageOrientationDown];
    NSData * imgdata = UIImageJPEGRepresentation(img, 0.1);
    UIImage * image =[UIImage imageWithData:imgdata];
    NSLog(@"image-----------%@",imgdata);
    self.userIconImage.image = image;
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
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
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard * sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];

    if (indexPath.row==0) {
        NSLog(@"...................");
     //   UIStoryboard * sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        MyResumeViewController * MyController = [sb instantiateViewControllerWithIdentifier:@"MyResumeViewController"];
        MyController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:MyController animated:YES];
        
    }
    else if (indexPath.row ==1)
    {
        EditPersonInfoViewController * editPVC = [sb instantiateViewControllerWithIdentifier:@"EditPersonInfoViewController"];
        editPVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:editPVC animated:YES];
    }
    else if (indexPath.row == 2)
    {
        SystemViewController * systemVC = [sb instantiateViewControllerWithIdentifier:@"SystemViewController"];
        systemVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:systemVC animated:YES];
    }
}

@end
