//
//  HYTimeLineLongPressView.m
//  RRStock
//
//  Created by 曾文亮 on 16/12/17.
//  Copyright © 2016年 liang. All rights reserved.
//

#import "HYTimeLineLongPressView.h"
#import "NSDateFormatter+HYStockChart.h"
#import "HYTimeLineModel.h"
#import "UIColor+HYStockChart.h"


@interface HYTimeLineLongPressView ()

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *volumeLabel;

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@property (weak, nonatomic) IBOutlet UILabel *appliesLabel;

@end

@implementation HYTimeLineLongPressView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+(instancetype)timeLineLongPressProfileView
{
    HYTimeLineLongPressView *timeLineLongPressProfileView = [[[NSBundle mainBundle] loadNibNamed:@"TimeLineLongPressView" owner:nil options:nil] lastObject];
    return timeLineLongPressProfileView;
}

-(void)setTimeLineModel:(HYTimeLineModel *)timeLineModel
{
    NSDateFormatter *formatter = [NSDateFormatter shareDateFormatter];
    _timeLineModel = timeLineModel;
    
    self.priceLabel.text = [NSString stringWithFormat:@"%.2f",timeLineModel.currentPrice];
    self.appliesLabel.text = [NSString stringWithFormat:@"%.2f%%",timeLineModel.PercentChangeFromPreClose];
    UIColor *appliesTextColor = timeLineModel.PercentChangeFromPreClose > 0 ? [UIColor increaseColor] : [UIColor decreaseColor];
    self.appliesLabel.textColor = appliesTextColor;
    NSString *volumeString = [NSString stringWithFormat:@"%.ld",timeLineModel.volume];
    if (volumeString.length >= 9 ) {
        volumeString = [NSString stringWithFormat:@"%.2f亿股",timeLineModel.volume/100000000.0];
    }else{
        volumeString = [NSString stringWithFormat:@"%.2f万股",timeLineModel.volume/10000.0];
    }
    self.volumeLabel.text = volumeString;
    formatter.dateFormat = @"MM-dd-yyyy hh:mm:ss a";
    NSDate *date = [formatter dateFromString:timeLineModel.currentTime];
    formatter.dateFormat = @"HH:mm";
    NSString *timeStr = [formatter stringFromDate:date];
    formatter.dateFormat = @"yyyy-dd-MM";
    NSString *dateStr = [formatter stringFromDate:date];
    self.timeLabel.text = timeStr;
}



@end
