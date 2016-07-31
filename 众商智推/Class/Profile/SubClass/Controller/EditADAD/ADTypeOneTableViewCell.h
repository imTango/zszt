//
//  ADTypeOneTableViewCell.h
//  众商智推
//
//  Created by VINCENT on 16/7/29.
//  Copyright © 2016年 bjywkj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ADTypeOneTableViewCell : UITableViewCell
//第一种广告的cell
@property (weak, nonatomic) IBOutlet UIImageView *oneBgImg;
@property (weak, nonatomic) IBOutlet UILabel *oneADLabel;
//第二种广告的cell
@property (strong, nonatomic) IBOutlet UIImageView *iconImg;
@property (strong, nonatomic) IBOutlet UILabel *adTitle;
@property (strong, nonatomic) IBOutlet UILabel *addescrible;
//第三种广告的cell




@end
