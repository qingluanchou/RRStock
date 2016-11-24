//
//  TradeDetailCell.m
//  RRCP
//
//  Created by 人人操盘 on 16/8/23.
//  Copyright © 2016年 renrencaopan. All rights reserved.
//

#import "TradeDetailCell.h"
#import "Masonry.h"
#import "CustomLabel.h"
#import "UIColor+HYStockChart.h"

#define WEAKSELF(weakSelf)  __weak __typeof(&*self)weakSelf = self;

@implementation TradeDetailCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self makeView];
    }
    return self;
}

- (void)makeView
{
    
    CustomLabel *currentTimeLabel = [CustomLabel setCustomLabelText:@"14.56" font:10 textColor:[UIColor whiteColor153]];
    [self.contentView addSubview:currentTimeLabel];
    WEAKSELF(weakSelf);
    [currentTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.contentView);
        make.left.equalTo(weakSelf.contentView).offset(5);
    }];
    
    
    CustomLabel *currentPriceLabel = [CustomLabel setCustomLabelText:@"35.56" font:10 textColor:[UIColor whiteColor153]];
    [self.contentView addSubview:currentPriceLabel];
    [currentPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.contentView);
        make.left.equalTo(currentTimeLabel.mas_right).offset(3);
    }];
    
    
    CustomLabel *currentShuLiang = [CustomLabel setCustomLabelText:@"38" font:10 textColor:[UIColor whiteColor153]];
    [self.contentView addSubview:currentShuLiang];
    [currentShuLiang mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.contentView);
        make.left.equalTo(currentPriceLabel.mas_right).offset(10);
    }];
    
    CustomLabel *currentStyleLabel = [CustomLabel setCustomLabelText:@"B" font:10 textColor:[UIColor whiteColor153]];
    [self.contentView addSubview:currentStyleLabel];
    [currentStyleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.contentView);
        make.left.equalTo(currentShuLiang.mas_right).offset(3);
    }];
    
    
}



@end
