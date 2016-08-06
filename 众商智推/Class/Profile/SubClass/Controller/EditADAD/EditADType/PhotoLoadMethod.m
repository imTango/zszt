//
//  PhotoLoadMethod.m
//  众商智推
//
//  Created by VINCENT on 16/8/3.
//  Copyright © 2016年 bjywkj. All rights reserved.
//

#import "PhotoLoadMethod.h"



@implementation PhotoLoadMethod

-(void)loadImageFromLibrayWithController:(UIViewController*)controller alertController:(UIAlertController*)alertController Block:(ImgBlock)block{


__block NSUInteger blockSourceType = 0;

// 判断是否支持相机
if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
{
    //支持访问相机与相册情况
    [alertController addAction:[UIAlertAction actionWithTitle:@"从相册中选取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        //相册
        blockSourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        
        imagePickerController.delegate = self;
        
        imagePickerController.allowsEditing = YES;
        
        imagePickerController.sourceType = blockSourceType;
        
        [controller presentViewController:imagePickerController animated:YES completion:nil];
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //相机
        blockSourceType = UIImagePickerControllerSourceTypeCamera;
        
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        
        imagePickerController.delegate = self;
        
        imagePickerController.allowsEditing = YES;
        
        imagePickerController.sourceType = blockSourceType;
        
        [controller presentViewController:imagePickerController animated:YES completion:nil];
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        // 取消
        return;
    }]];
    
    [controller presentViewController:alertController animated:YES completion:nil];

}

else{
    //只支持访问相册情况
    alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"从相册中选取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //相册
        blockSourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        
        imagePickerController.delegate = self;
        
        imagePickerController.allowsEditing = YES;
        
        imagePickerController.sourceType = blockSourceType;
        
        [controller presentViewController:imagePickerController animated:YES completion:^{
            
        }];
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        // 取消
        return;
    }]];
    
    [controller presentViewController:alertController animated:YES completion:nil];
}

    self.imBlock = block;

}
#pragma mark - 选择图片后,回调选择

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    self.img = [info objectForKey:UIImagePickerControllerEditedImage];
    self.imBlock(self.img);
}

@end
