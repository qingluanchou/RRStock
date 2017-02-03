//
//  YYTimeLineBelowMaskView.m
//  RRStock
//
//  Created by 曾文亮 on 16/12/17.
//  Copyright © 2016年 liang. All rights reserved.
//

#import "YYTimeLineBelowMaskView.h"

@implementation YYTimeLineBelowMaskView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

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
    CGContextSetStrokeColorWithColor(ctx, [UIColor colorWithWhite102].CGColor);
    CGContextSetLineWidth(ctx, 0.5);
    
    //CGFloat x = self.timeLineView.frame.origin.x + self.selectedPoint.x - self.stockScrollView.contentOffset.x;
    
    //绘制横线
    CGContextMoveToPoint(ctx, HYStockChartTimeLineAboveViewMinX,  self.selectedPoint.y);
    CGContextAddLineToPoint(ctx, HYStockChartTimeLineAboveViewMinX + self.frame.size.width,  self.selectedPoint.y);
    
    //绘制竖线
    CGContextMoveToPoint(ctx, self.selectedPoint.x, self.frame.origin.y);
    CGContextAddLineToPoint(ctx, self.selectedPoint.x, self.frame.size.height);
    CGContextStrokePath(ctx);
    
    
    //绘制交叉圆点
//    CGContextSetStrokeColorWithColor(ctx, [UIColor colorWithWhite102].CGColor);
//    CGContextSetFillColorWithColor(ctx, [UIColor whiteColor].CGColor);
//    CGContextSetLineWidth(ctx, 1.5);
//    CGContextSetLineDash(ctx, 0, NULL, 0);
//    CGContextAddArc(ctx, self.selectedPoint.x, self.selectedPoint.y, 3.0, 0, 2 * M_PI, 0);
//    CGContextDrawPath(ctx, kCGPathFillStroke);
    
    //绘制选中日期
    NSDictionary *attribute = @{NSFontAttributeName:[UIFont systemFontOfSize:9],NSForegroundColorAttributeName:[UIColor colorWithWhite153]};
    //绘制选中价格
    NSString *priceText = [NSString stringWithFormat:@"%zd",[self.selectedModel volume] ];
    CGRect priceRect = [self rectOfNSString:priceText attribute:attribute];
    CGContextSetFillColorWithColor(ctx, [UIColor whiteColor].CGColor);
//    CGContextFillRect(ctx, CGRectMake(HYStockChartTimeLineAboveViewMaxX - priceRect.size.width - 4, self.selectedPoint.y - priceRect.size.height/2.f - 2, priceRect.size.width + 4, priceRect.size.height + 4));
    [priceText drawInRect:CGRectMake( 2,  2, priceRect.size.width, priceRect.size.height) withAttributes:attribute];
    
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
