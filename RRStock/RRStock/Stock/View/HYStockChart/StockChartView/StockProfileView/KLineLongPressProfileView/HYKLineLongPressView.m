//
//  HYKLineLongPressView.m
//  RRStock
//
//  Created by 曾文亮 on 16/12/17.
//  Copyright © 2016年 liang. All rights reserved.
//

#import "HYKLineLongPressView.h"
#import "HYKLineModel.h"
#import "HYStockChartGloablVariable.h"
#import "UIColor+HYStockChart.h"
#import "HYStockChartTool.h"
#import "NSDateFormatter+HYStockChart.h"

@interface HYKLineLongPressView ()

@property (weak, nonatomic) IBOutlet UILabel *appliesLabel;

@property (weak, nonatomic) IBOutlet UILabel *closePriceLabel;

@property (weak, nonatomic) IBOutlet UILabel *openPriceLabel;

@property (weak, nonatomic) IBOutlet UILabel *maxPriceLabel;

@property (weak, nonatomic) IBOutlet UILabel *minPriceLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *volumeLabel;

@end

@implementation HYKLineLongPressView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+(instancetype)kLineLongPressProfileView
{
    HYKLineLongPressView *longPressProfileView = [[[NSBundle mainBundle] loadNibNamed:@"kLineLongPressView" owner:nil options:nil] lastObject];
   
    //    longPressProfileView.symbolLabel.text = [HYStockChartGloablVariable stockSymbol];
    return longPressProfileView;
}

#pragma mark - set方法
-(void)setKLineModel:(HYKLineModel *)kLineModel
{
_kLineModel = kLineModel;

NSString *currencySymbol = [HYStockChartTool currencySymbol];
self.closePriceLabel.text = [NSString stringWithFormat:@"%.2f",kLineModel.close];
self.appliesLabel.text = [NSString stringWithFormat:@"%.2f%%",kLineModel.percentChangeFromOpen];
UIColor *appliesLabelColor = kLineModel.percentChangeFromOpen > 0 ? [UIColor increaseColor] : [UIColor decreaseColor];
    self.appliesLabel.textColor = appliesLabelColor;
    self.openPriceLabel.text = [NSString stringWithFormat:@"%.2f",kLineModel.open];
    self.maxPriceLabel.text = [NSString stringWithFormat:@"%.2f",kLineModel.high];
    self.minPriceLabel.text = [NSString stringWithFormat:@"%.2f",kLineModel.low];
    
    NSDateFormatter *formatter = [NSDateFormatter shareDateFormatter];

    formatter.dateFormat = @"MM-dd-yyyy";
    NSDate *date = [formatter dateFromString:kLineModel.date];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSString *dateStr = [formatter stringFromDate:date];
    self.timeLabel.text = [NSString stringWithFormat:@"%@",dateStr];
    
    NSString *volumeString = [NSString stringWithFormat:@"%f",kLineModel.volume];
    if (volumeString.length >= 9 ) {
        volumeString = [NSString stringWithFormat:@"%.2f亿股",kLineModel.volume/100000000.0];
    }else{
        volumeString = [NSString stringWithFormat:@"%.2f万股",kLineModel.volume/10000.0];
    }
    self.volumeLabel.text = volumeString;
}


@end
