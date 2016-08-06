//
//  TypeFourViewController.h
//  众商智推
//
//  Created by 杨 on 16/5/27.
//  Copyright © 2016年 bjywkj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TypeFourViewController : UIViewController

/**
 *标题
 */
@property (strong, nonatomic) UITextField *adTitleTextField;
/**
 *简介
 */
@property (strong, nonatomic) UITextField *adIntroductionTextField;
/**
 *广告链接
 */
@property (strong, nonatomic) UITextField *linkTextField;

//icon的image
@property (nonatomic,strong) NSData * imgData;
//二维码的图片
@property (nonatomic,strong) NSData * qrData;

@end
