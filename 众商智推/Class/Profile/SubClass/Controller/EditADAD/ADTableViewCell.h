//
//  ADTableViewCell.h
//  众商智推
//
//  Created by VINCENT on 16/7/29.
//  Copyright © 2016年 bjywkj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ADTableViewCell : UITableViewCell

//第一种广告的cell
@property (weak, nonatomic) IBOutlet UIImageView * firstBgImg;
@property (weak, nonatomic) IBOutlet UILabel * fisrtADLabel;

//第二种广告的cell
@property (strong, nonatomic) IBOutlet UIImageView * secIconImg;
@property (strong, nonatomic) IBOutlet UILabel * secAdTitle;
@property (strong, nonatomic) IBOutlet UILabel * secAdDescrible;

//第三种广告的cell
@property (strong, nonatomic) IBOutlet UIImageView * thirdBgImg;
@property (strong, nonatomic) IBOutlet UIButton * thirdFocusBtn;
@property (strong, nonatomic) IBOutlet UILabel * thirdAdTitle;

//第四种广告的cell
@property (strong, nonatomic) IBOutlet UIImageView * fourthIconImg;
@property (strong, nonatomic) IBOutlet UILabel * fourthAdTitle;
@property (strong, nonatomic) IBOutlet UILabel * fourthAdDescrible;
@property (strong, nonatomic) IBOutlet UIButton * fourthFocusBtn;

//第五种广告的cell
@property (strong, nonatomic) IBOutlet UIImageView * fifthIconImg;
@property (strong, nonatomic) IBOutlet UILabel * fifthAdTitle;


//配置cell的方法
- (void)configTempCellWith:(NSIndexPath *)indexPath;

//cell的初始化方法
+ (ADTableViewCell*)tempTableViewCellWith:(UITableView *)tableView
                            indexPath:(NSIndexPath *)indexPath;


@end
