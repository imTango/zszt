//
//  TypeOneViewController.m
//  众商智推
//
//  Created by 杨 on 16/5/27.
//  Copyright © 2016年 bjywkj. All rights reserved.
//

#import "TypeOneViewController.h"
#import "PhotoLoadMethod.h"

@interface TypeOneViewController ()<UITextFieldDelegate,UIScrollViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>


@property (strong,nonatomic) NSMutableDictionary * adInfoDic;

//从广告条界面跳转过来之后携带者广告ID，用来查找该广告条位置并获取原始数据修改重新提交，如果是添加个人广告跳转进来则ID为空
@property (strong,nonatomic) NSString * ID;
@end

@implementation TypeOneViewController
{
    PhotoLoadMethod * ph;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:ZSColor(244, 244, 244)];
    [self createHeadUI];
    [self createContentControls];
    self.adInfoDic = [[NSMutableDictionary alloc] init];
    self.imgData = [NSData dataWithData:UIImagePNGRepresentation([UIImage imageNamed:@"11"])];
    
}
#pragma mark - 创建顶部View
- (void)createHeadUI
{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    headView.backgroundColor = ZSColor(19, 143, 253);
    [self.view addSubview:headView];
    
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(5, 25, 40, 40);
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:backBtn];
    
    //标题按钮
    UILabel *titleLabel= [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth/2-60, 25, 120, 40)];
    titleLabel.text = @"广告类型1";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:titleLabel];
}
//退出此控制器返回到上级的控制器
- (void)goBack
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark -
#pragma mark - 加载内容控件
- (void)createContentControls
{
    //背景self.scrollView
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64)];
    [self.scrollView setBackgroundColor:ZSColor(244, 244, 244)];
    self.scrollView.delegate = self;
    self.scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.scrollView];
    
    UILabel *adLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 100, 40)];
    adLabel.text = @"广告语";
    adLabel.font = [UIFont boldSystemFontOfSize:20];
    [self.scrollView addSubview:adLabel];
    
    self.adTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 55, ScreenWidth-20, 60)];
    self.adTextField.placeholder = @"请添加您的广告语(限30字)...";
    self.adTextField.delegate = self;
    self.adTextField.borderStyle = UITextBorderStyleRoundedRect;
    [self.scrollView addSubview:self.adTextField];
    
    UILabel *linkLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 120, 100, 40)];
    linkLabel.text = @"广告链接";
    linkLabel.font = [UIFont boldSystemFontOfSize:20];
    [self.scrollView addSubview:linkLabel];
    
    self.linkTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 165, ScreenWidth-20, 60)];
    self.linkTextField.placeholder = @"请输入您的广告链接，网址请加http://";
    self.linkTextField.delegate = self;
    self.linkTextField.borderStyle = UITextBorderStyleRoundedRect;
    [self.scrollView addSubview:self.linkTextField];
    
    UILabel *backgroundLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 235, 100, 40)];
    backgroundLabel.text = @"广告背景";
    backgroundLabel.font = [UIFont boldSystemFontOfSize:20];
    [self.scrollView addSubview:backgroundLabel];

    //背景1
    self.background1 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.background1.tag = 11;
    self.background1.frame = CGRectMake(10, 285, ScreenWidth-20, 90);
    self.background1.layer.cornerRadius = 5;
    self.background1.layer.masksToBounds = YES;
    [self.background1 setTitle:@"广告语" forState:UIControlStateNormal];
    [self.background1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.background1 setBackgroundImage:[UIImage imageNamed:@"11.png"] forState:UIControlStateNormal];
//    [self.background1 setBackgroundImage:[UIImage imageNamed:@"11.png"] forState:UIControlStateSelected];
    [self.background1 addTarget:self action:@selector(buttonSelected:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:self.background1];
    
    //背景2
    self.background2 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.background2.tag = 22;
    self.background2.frame = CGRectMake(10, 385, ScreenWidth-20, 90);
    self.background2.layer.cornerRadius = 5;
    self.background2.layer.masksToBounds = YES;
    [self.background2 setTitle:@"广告语" forState:UIControlStateNormal];
    [self.background2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.background2 setBackgroundImage:[UIImage imageNamed:@"22.png"] forState:UIControlStateNormal];
//    [self.background2 setBackgroundImage:[UIImage imageNamed:@"22.png"] forState:UIControlStateSelected];
    [self.background2 addTarget:self action:@selector(buttonSelected:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:self.background2];
    //背景3
    self.background3 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.background3.tag = 33;
    self.background3.frame = CGRectMake(10, 485, ScreenWidth-20, 90);
    self.background3.layer.cornerRadius = 5;
    self.background3.layer.masksToBounds = YES;
    [self.background3 setTitle:@"广告语" forState:UIControlStateNormal];
    [self.background3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.background3 setBackgroundImage:[UIImage imageNamed:@"33.png"] forState:UIControlStateNormal];
//    [self.background3 setBackgroundImage:[UIImage imageNamed:@"33.png"] forState:UIControlStateSelected];
    [self.background3 addTarget:self action:@selector(buttonSelected:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:self.background3];
    
    
    self.hiddenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.hiddenBtn.frame = CGRectMake(10, 585, ScreenWidth-20, 90);
    //    self.hiddenBtn.hidden = YES;
//    self.hiddenBtn.backgroundColor = [UIColor redColor];
    self.hiddenBtn.layer.cornerRadius = 5;
    self.hiddenBtn.layer.masksToBounds = YES;
    [self.scrollView addSubview:self.hiddenBtn];

    
    self.photoLibraryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.photoLibraryBtn.frame = CGRectMake(10, 585, ScreenWidth-20, 90);
    self.photoLibraryBtn.backgroundColor = [UIColor grayColor];
    self.photoLibraryBtn.layer.cornerRadius = 5;
    self.photoLibraryBtn.layer.masksToBounds = YES;
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"+点击上传广告图片（600px*160px)"];
    NSRange strRange = {0,[str length]};
    [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:strRange];
    [self.photoLibraryBtn setAttributedTitle:str forState:UIControlStateNormal];
    [self.photoLibraryBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.photoLibraryBtn addTarget:self action:@selector(selectImage) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:self.photoLibraryBtn];
    
    self.saveMessageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //        _saveBtn.frame = CGRectMake(10, 500, ScreenWidth-20, 50);
    self.saveMessageBtn.frame = CGRectMake(10, 690, ScreenWidth-20, 50);
    self.saveMessageBtn.backgroundColor = [UIColor colorWithRed:0/255.0 green:211/255.0 blue:100/255.0 alpha:1];
    [self.saveMessageBtn setTitle:@"保存" forState:UIControlStateNormal];
    self.saveMessageBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.saveMessageBtn.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [self.saveMessageBtn addTarget:self action:@selector(saveMessageBtnMethod) forControlEvents:UIControlEventTouchUpInside];
    self.saveMessageBtn.layer.cornerRadius = 5;
    self.saveMessageBtn.layer.masksToBounds = YES;
    [self.scrollView addSubview:self.saveMessageBtn];
    
    //选中的按钮
    self.selectedImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"vv"]];
    self.selectedImg.size = CGSizeMake(20,20);
    self.selectedImg.center = CGPointMake(CGRectGetMaxX(self.background1.frame), CGRectGetMinY(self.background1.frame));
    [self.scrollView addSubview:self.selectedImg];
    
    self.scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(self.saveMessageBtn.frame)+20);

}
/**
 *选择广告类型的背景
 */
-(void)buttonSelected:(UIButton*)sender
{
    self.orderNum = sender.tag;
    [self.selectedImg removeFromSuperview];
    self.selectedImg.size = CGSizeMake(20,20);
    self.selectedImg.center = CGPointMake(CGRectGetMaxX(sender.frame), CGRectGetMinY(sender.frame));
    [self.scrollView addSubview:self.selectedImg];
    UIImage * img = [UIImage imageNamed:[NSString stringWithFormat:@"%ld.png",(long)sender.tag]];
    self.imgData = UIImagePNGRepresentation(img);
}

- (void)saveMessageBtnMethod
{
    ZSLog(@"保存按钮被点击!!");

    NSMutableDictionary * infoDic = [NSMutableDictionary dictionaryWithCapacity:0];
    infoDic = (NSMutableDictionary*)[NSKeyedUnarchiver unarchiveObjectWithFile:kPath];//将沙盒路径下的归档对象解档出来
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setValue:self.adTextField.text forKey:@"title"];
    [dic setValue:self.linkTextField.text forKey:@"adurl"];
    [dic setValue:@"1" forKey:@"type"];
    NSMutableDictionary * para = [NSMutableDictionary dictionaryWithDictionary:dic];
    [dic setValue:[NSString stringWithFormat:@"%ld",(long)self.orderNum] forKey:@"orderNum"];
    NSMutableArray * arr = [NSMutableArray array];

    //存在ad1，先去查找ad1里面的所有广告id，有的话说明是要编辑，没有自然就是添加喽
    if (self.adId != nil) {
        for (__strong NSMutableDictionary * tempDic in infoDic[@"ad1"]) {
            NSString * adIdStr = tempDic[@"adId"];
            if ([self.adId isEqualToString:adIdStr]) {
                //如果当前类中adId有值且和本地储存的一个广告中的adId相等，说明用户在修改广告条
                tempDic = [NSMutableDictionary dictionaryWithDictionary:dic];
                [HTTPToolsPost EditPostRequestWithUrl:EditUrl parameters:para imageData:self.imgData QRCode:nil completion:^{
                    [tempDic setValue:self.imgData forKey:@"image"];
                    [arr addObject:tempDic];
                    [infoDic setValue:arr forKey:@"ad1"];
                    if ([NSKeyedArchiver archiveRootObject:infoDic toFile:kPath]) {
                        [self goBack];
                    }
                }];
            }
        }
    }else{
        //
        [HTTPToolsPost StoragePostRequestWithUrl:StorageUrl parameters:para imageData:self.imgData QRCode:nil success:^(NSString *ADId) {
            [dic setValue:ADId forKey:@"adId"];
            [dic setValue:self.imgData forKey:@"image"];
            [arr addObject:dic];
            [infoDic setValue:arr forKey:@"ad1"];
            if ([NSKeyedArchiver archiveRootObject:infoDic toFile:kPath]) {
                [self goBack];
            }
        } fail:^{
            //
        }];
    }

    
//    if (infoDic[@"ad1"] == nil) {
//        //非常重要
//        [HTTPToolsPost StoragePostRequestWithUrl:StorageUrl parameters:dic success:^(NSString *ADId) {
//            [dic setValue:ADId forKey:@"adId"];
//            [arr addObject:dic];
//            [infoDic setValue:arr forKey:@"ad1"];
//            BOOL sucess = [NSKeyedArchiver archiveRootObject:infoDic toFile:kPath];
//            if (sucess) {
//                [self goBack];
//            }
//        } fail:^{
//            [MBProgressHUD showError:@"网络状况较差，存储失败"];
//        }];
//
//            }
//    else{
    
        
    //保存用户添加的数据（如果数据存在，则覆盖setObject: forkey:，否则添加addObject）
//    for (NSDictionary * dic in tempArr) {
//        if ([dic[@"id"] isEqualToString:self.ID])//@"从服务器请求回来的id添加到广告条中作为一个value，编辑跳转到这个页面时把id当做参数传过来，并找到id对应的dictionary，重新保存数据，然后写入plist文件，若是添加跳转到这个页面时，则else{addObject到tempArr数组中，并写入plist文件}，重点：无论怎样写入plist文件之前要先将数据进行post到后台成功返回再存储"])
//        {
//            [dic setValue:self.adTextField.text forKey:@"adTitle"];
//            [dic setValue:self.linkTextField.text forKey:@"url"];
//            [dic setValue:self.imgData forKey:@"bgImg"];
//        }
//    }
        
//    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


#pragma mark - 自定义封装的获取相机或图库的图片的方法
-(void)selectImage{
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];

    ph = [[PhotoLoadMethod alloc] init];
    [ph loadImageFromLibrayWithController:self alertController:alertController Block:^(UIImage *image) {
//        NSLog(@"img----------------%@",image);
        self.orderNum = 44;
        [self.hiddenBtn setBackgroundImage:image forState:UIControlStateNormal];
        [self.selectedImg removeFromSuperview];
        self.selectedImg.size = CGSizeMake(20,20);
        self.selectedImg.center = CGPointMake(CGRectGetMaxX(self.hiddenBtn.frame), CGRectGetMinY(self.hiddenBtn.frame));
        [self.scrollView addSubview:self.selectedImg];
        
        self.imgData = UIImageJPEGRepresentation(image, 0.5);
        
        CGSize size = CGSizeMake(0, 840);
        self.scrollView.contentSize = size;
        
        CGRect frame = self.photoLibraryBtn.frame;
        frame = CGRectMake(10, 685, ScreenWidth-20, 90);
        self.photoLibraryBtn.frame = frame;
        
        CGRect saveFrame = self.saveMessageBtn.frame;
        saveFrame = CGRectMake(10, 790, ScreenWidth-20, 50);
        self.saveMessageBtn.frame = saveFrame;
    }];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

    @end
