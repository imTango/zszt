//
//  ADOneTableViewCell.h
//  众商智推
//
//  Created by VINCENT on 16/8/3.
//  Copyright © 2016年 bjywkj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdtypeOneModel.h"
@interface ADOneTableViewCell : UITableViewCell

@property (nonatomic,strong) UIImageView * firstBgImg;
@property (strong, nonatomic)  UILabel * fisrtADLabel;
@property (nonatomic,strong)   NSString * firstUrl;

-(void)loadDataWithModel:(AdtypeOneModel*)model indexPath:(NSIndexPath *)indexpath;
@end
