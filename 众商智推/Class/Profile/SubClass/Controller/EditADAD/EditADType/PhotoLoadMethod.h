//
//  PhotoLoadMethod.h
//  众商智推
//
//  Created by VINCENT on 16/8/3.
//  Copyright © 2016年 bjywkj. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ImgBlock)(UIImage * image);

@interface PhotoLoadMethod : NSObject<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (nonatomic,strong) UIImage * img;

-(void)loadImageFromLibrayWithController:(UIViewController*)controller alertController:(UIAlertController*)alertController Block:(ImgBlock)block;
@property (nonatomic,copy) ImgBlock imBlock;

@end
