//
//  BarChartViewCell.m
//  iseasoftCompany
//
//  Created by 张恒宇 on 2019/5/17.
//  Copyright © 2019 hycrazyfish. All rights reserved.
//

#import "BarChartViewCell.h"
#import "BarChartViewTool.h"
#import <Masonry/Masonry.h>
@interface BarChartViewCell ()
@property (nonatomic ,strong) UIView *backView;
@property (nonatomic ,strong) BarChartViewTool *barChartView;
@end
@implementation BarChartViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self loadContent];
    }
    return self;
}

- (void)loadContent {
    self.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.backView = [[UIView alloc]initWithFrame:CGRectZero];
    self.backView.backgroundColor = [UIColor whiteColor];
    self.backView.layer.cornerRadius = 5;
    self.backView.layer.masksToBounds = YES;
    
    [self addSubview:self.backView];
    self.barChartView = [[BarChartViewTool alloc] init];
    [self.backView addSubview:self.barChartView];
    [self setUI];
}


- (void)setUI{
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(12);
        make.width.mas_equalTo(APP_WIDTH - 24);
        make.top.mas_equalTo(self.mas_top).offset(6);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-6);
    }];
    
    [self.barChartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.mas_equalTo(self.backView);
    }];
}


@end
