//
//  ADFourTableViewCell.m
//  众商智推
//
//  Created by VINCENT on 16/8/3.
//  Copyright © 2016年 bjywkj. All rights reserved.
//

#import "ADFourTableViewCell.h"

@implementation ADFourTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];

    }
    return self;
}


-(void)createUI{
    self.fourthIconImg = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 70, 70)];
    [self.contentView addSubview:self.fourthIconImg];
    
    self.fourthAdTitle = [[UILabel alloc] initWithFrame:CGRectMake(90, 20, ScreenWidth-90-100, 30)];
    self.fourthAdTitle.font = [UIFont systemFontOfSize:25 weight:10];
    [self.contentView addSubview:self.fourthAdTitle];
    
    self.fourthAdDescrible = [[UILabel alloc] initWithFrame:CGRectMake(90, 20, ScreenWidth-70, self.height)];
    self.fourthAdDescrible.textColor = [UIColor grayColor];
    [self.contentView addSubview:self.fourthAdDescrible];
    
    self.fourthFocusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.fourthFocusBtn.tag = 102;
    self.fourthFocusBtn.frame = CGRectMake(ScreenWidth-70, 0, 60, self.height);
    [self.contentView addSubview:self.fourthFocusBtn];
    
}

-(void)loadDataWithModel:(AdtypeFourModel*)model indexPath:(NSIndexPath *)indexpath{
    self.fourthIconImg.image = [UIImage imageWithData:model.iconImg];
    [self.fourthFocusBtn setBackgroundImage:[UIImage imageWithData:model.focusBtnImg] forState:UIControlStateNormal];
    [self.fourthFocusBtn setTitle:@"+关注" forState:UIControlStateNormal];
    self.fourthAdTitle.text = model.adTitle;
    self.fourthAdDescrible.text = model.adDescrible;
    self.fourthUrl = model.url;
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
