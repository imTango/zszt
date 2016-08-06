//
//  TypeOneViewController.h
//  众商智推
//
//  Created by 杨 on 16/5/27.
//  Copyright © 2016年 bjywkj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TypeOneViewController : UIViewController


/**
 *广告语
 */
@property (strong, nonatomic) UITextField *adTextField;
/**
 *广告链接
 */
@property (strong, nonatomic) UITextField *linkTextField;
/**
 *  存储背景图片的data
 */
@property (strong,nonatomic) NSData * imgData;

@property (nonatomic,assign)  NSInteger orderNum;

@property (nonatomic,strong) UIImageView * selectedImg;

@property (nonatomic,strong) UIScrollView *scrollView;


/**
 *广告背景图1
 */
@property (strong, nonatomic) UIButton *background1;
/**
 *广告背景图2
 */
@property (strong, nonatomic) UIButton *background2;
/**
 *广告背景图3
 */
@property (strong, nonatomic) UIButton *background3;

//设置从系统图库里调取图片
@property (strong,nonatomic) UIButton * photoLibraryBtn;

@property (strong,nonatomic) UIButton * hiddenBtn;


/**
 *保存按钮
 */
@property (strong, nonatomic) UIButton *saveMessageBtn;


-(void)buttonSelected:(UIButton*)sender;

@end
