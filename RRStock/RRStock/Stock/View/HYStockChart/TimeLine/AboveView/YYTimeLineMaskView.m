//
//  YYTimeLineMaskView.m
//  YYStock  ( https://github.com/yate1996 )
//
//  Created by yate1996 on 16/10/10.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import "YYTimeLineMaskView.h"
//#import "YYStockConstant.h"
#import "UIColor+HYStockChart.h"
//#import "YYStockVariable.h"
//#import "UIColor+YYStockTheme.h"
@implementation YYTimeLineMaskView

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    [self drawDashLine];
}

/**
 绘制长按的背景线
 */
- (void)drawDashLine {
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGFloat lengths[] = {3,3};
    CGContextSetLineDash(ctx, 0, lengths, 2);
    CGContextSetStrokeColorWithColor(ctx, [UIColor increaseColor].CGColor);
    CGContextSetLineWidth(ctx, 1.5);
    
    //CGFloat x = self.timeLineView.frame.origin.x + self.selectedPoint.x - self.stockScrollView.contentOffset.x;
    
    //绘制横线
    CGContextMoveToPoint(ctx, HYStockChartTimeLineAboveViewMinX,  self.selectedPoint.y);
    CGContextAddLineToPoint(ctx, HYStockChartTimeLineAboveViewMinX + self.timeLineView.frame.size.width,  self.selectedPoint.y);
    
    //绘制竖线
    CGContextMoveToPoint(ctx, self.selectedPoint.x, self.timeLineView.frame.origin.y);
    CGContextAddLineToPoint(ctx, self.selectedPoint.x, self.timeLineView.frame.origin.y + HYStockChartTimeLineAboveViewMaxY);
    CGContextStrokePath(ctx);
    
    //绘制交叉圆点
    CGContextSetStrokeColorWithColor(ctx, [UIColor increaseColor].CGColor);
    CGContextSetFillColorWithColor(ctx, [UIColor decreaseColor].CGColor);
    CGContextSetLineWidth(ctx, 1.5);
    CGContextSetLineDash(ctx, 0, NULL, 0);
    CGContextAddArc(ctx, self.selectedPoint.x, self.selectedPoint.y, 3.0, 0, 2 * M_PI, 0);
    CGContextDrawPath(ctx, kCGPathFillStroke);
    
    //绘制选中日期
    NSDictionary *attribute = @{NSFontAttributeName:[UIFont systemFontOfSize:9],NSForegroundColorAttributeName:[UIColor decreaseColor]};
    /*
    NSDictionary *attribute = @{NSFontAttributeName:[UIFont systemFontOfSize:9],NSForegroundColorAttributeName:[UIColor decreaseColor]};
    NSString *dayText = [self.selectedModel currentTime];
    CGRect textRect = [self rectOfNSString:dayText attribute:attribute];
    
    if (self.selectedPoint.x + textRect.size.width/2.f + 2 > CGRectGetMaxX(self.timeLineView.frame)) {
        CGContextSetFillColorWithColor(ctx, [UIColor increaseColor].CGColor);
        CGContextFillRect(ctx, CGRectMake(CGRectGetMaxX(self.timeLineView.frame) - 4 - textRect.size.width, HYStockChartTimeLineAboveViewMaxY, textRect.size.width + 4, textRect.size.height + 4));
        [dayText drawInRect:CGRectMake(CGRectGetMaxX(self.timeLineView.frame) - 4 - textRect.size.width + 2, HYStockChartTimeLineAboveViewMaxY, textRect.size.width, textRect.size.height) withAttributes:attribute];
    } else {
        CGContextSetFillColorWithColor(ctx, [UIColor increaseColor].CGColor);
        CGContextFillRect(ctx, CGRectMake(self.selectedPoint.x -textRect.size.width/2.f, HYStockChartTimeLineAboveViewMaxY, textRect.size.width + 4, textRect.size.height + 4));
        [dayText drawInRect:CGRectMake(self.selectedPoint.x -textRect.size.width/2.f, HYStockChartTimeLineAboveViewMaxY, textRect.size.width, textRect.size.height) withAttributes:attribute];
    }*/
    
    //绘制选中价格
    NSString *priceText = [NSString stringWithFormat:@"%.2f",[self.selectedModel currentPrice] ];
    CGRect priceRect = [self rectOfNSString:priceText attribute:attribute];
    CGContextSetFillColorWithColor(ctx, [UIColor increaseColor].CGColor);
    CGContextFillRect(ctx, CGRectMake(HYStockChartTimeLineAboveViewMaxX - priceRect.size.width - 4, self.selectedPoint.y - priceRect.size.height/2.f - 2, priceRect.size.width + 4, priceRect.size.height + 4));
    [priceText drawInRect:CGRectMake(HYStockChartTimeLineAboveViewMaxX - priceRect.size.width - 4 + 2,  self.selectedPoint.y - priceRect.size.height/2.f, priceRect.size.width, priceRect.size.height) withAttributes:attribute];
    
    //绘制选中增幅
    /*
    NSString *text2 = [NSString stringWithFormat:@"%.2f%%",([[self.selectedModel Price] floatValue] - [self.selectedModel AvgPrice])*100/[self.selectedModel AvgPrice]];
    CGSize textSize2 = [self rectOfNSString:text2 attribute:attribute].size;
    CGContextSetFillColorWithColor(ctx, [UIColor YYStock_selectedRectBgColor].CGColor);
    CGContextFillRect(ctx, CGRectMake(CGRectGetMaxX(self.stockScrollView.frame) - textSize2.width - 4, self.stockScrollView.frame.origin.y + self.selectedPoint.y - priceRect.size.height/2.f - 2, textSize2.width + 4, textSize2.height + 4));
    
    CGPoint rightDrawPoint = CGPointMake(CGRectGetMaxX(self.stockScrollView.frame) - textSize2.width - 2 , self.stockScrollView.frame.origin.y + self.selectedPoint.y - priceRect.size.height/2.f);
    [text2 drawAtPoint:rightDrawPoint withAttributes:attribute];*/
}

- (CGRect)rectOfNSString:(NSString *)string attribute:(NSDictionary *)attribute {
    CGRect rect = [string boundingRectWithSize:CGSizeMake(MAXFLOAT, 0)
                                       options:NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesLineFragmentOrigin |
                   NSStringDrawingUsesFontLeading
                                    attributes:attribute
                                       context:nil];
    return rect;
}

@end
