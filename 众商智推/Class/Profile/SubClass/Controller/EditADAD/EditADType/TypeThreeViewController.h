//
//  TypeThreeViewController.h
//  众商智推
//
//  Created by 杨 on 16/5/27.
//  Copyright © 2016年 bjywkj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TypeThreeViewController : UIViewController


//选中图片的上标V
@property (nonatomic,strong) UIImageView * selectedImg;

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

//显示相册选取图片的占位button
@property (nonatomic,strong) UIButton * hiddenBtn;





/**
 *广告语
 */
@property (strong, nonatomic) UITextField *adTextField;
/**
 *广告链接
 */
@property (strong, nonatomic) UITextField *linkTextField;

//广告条的背景图片
@property (nonatomic,strong) NSData * imgData;
//二维码相片的存储
@property (nonatomic,strong) NSData * qrCodeData;
//广告的序号
@property (nonatomic,assign) NSInteger orderNum;

@property (nonatomic,strong) NSString * adId;


-(void)buttonSelected:(UIButton*)sender;

@end
