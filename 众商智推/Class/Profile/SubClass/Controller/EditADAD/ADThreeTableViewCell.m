//
//  ADThreeTableViewCell.m
//  众商智推
//
//  Created by VINCENT on 16/8/3.
//  Copyright © 2016年 bjywkj. All rights reserved.
//

#import "ADThreeTableViewCell.h"

@implementation ADThreeTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
//        self.layer.masksToBounds = YES;
//        self.layer.cornerRadius = 10;
    }
    return self;
}


-(void)createUI{
    self.thirdBgImg = [[ UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth-60, 90)];
    self.thirdBgImg.layer.borderWidth = 0.6f;
    self.thirdBgImg.layer.masksToBounds = YES;
    self.thirdBgImg.layer.cornerRadius = 5;
    self.thirdBgImg.layer.shadowColor = [UIColor blackColor].CGColor;
    self.thirdBgImg.layer.shadowOffset = CGSizeMake(1, 0);
    self.thirdBgImg.layer.shadowRadius = 5;
    [self.contentView addSubview:self.thirdBgImg];
    
    self.thirdFocusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.thirdFocusBtn.frame = CGRectMake(self.thirdBgImg.width, 0, 60, 90);
    self.thirdFocusBtn.tag = 101;
    [self.thirdFocusBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.thirdFocusBtn setTitle:@"+关注" forState:UIControlStateNormal];
    self.thirdFocusBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.thirdFocusBtn];

    self.thirdAdTitle = [[UILabel alloc] initWithFrame:self.thirdBgImg.frame];
    self.thirdAdTitle.font = [UIFont systemFontOfSize:25 weight:10];
    self.thirdAdTitle.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.thirdAdTitle];

}

-(void)loadDataWithModel:(AdtypeThreeModel*)model indexPath:(NSIndexPath *)indexpath{
    self.thirdBgImg.image = [UIImage imageWithData:model.image];
    self.thirdAdTitle.text = model.title;
    [self.thirdFocusBtn setBackgroundImage:[UIImage imageWithData:model.twoDimensionCode] forState:UIControlStateNormal];
    self.thirdUrl = model.adurl;
    self.adId = model.adId;
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
