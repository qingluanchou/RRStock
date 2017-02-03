//
//  HYKLineVolume.m
//  JimuStockChartDemo
//
//  Created by jimubox on 15/5/8.
//  Copyright (c) 2015年 jimubox. All rights reserved.
//

#import "HYKLineVolume.h"
#import "HYStockChartGloablVariable.h"
#import "UIFont+HYStockChart.h"
#import "UIColor+HYStockChart.h"
#import "HYStockChartConstant.h"
#import "HYStockChartGloablVariable.h"

@interface HYKLineVolume()

@property(nonatomic,assign) CGContextRef context;

@property(nonatomic,assign) CGPoint lastDrawDatePoint;

@end

@implementation HYKLineVolume

#pragma mark 根据context初始化模型
-(instancetype)initWithContext:(CGContextRef)context
{
    self = [super init];
    if (self) {
        _context = context;
    }
    return self;
}

#pragma mark 绘图方法
-(void)draw
{
    if (!self.kLineModel || !self.positionModel || !self.context || !self.lineColor) {
        return;
    }
    CGContextRef context = self.context;
    
    if (self.kLineModel.isFirstTradeDate) {
        
        NSString *dateStr = self.kLineModel.date;
        NSDateFormatter *formatter = [NSDateFormatter new];
        formatter.dateFormat = @"MM/dd/yyyy";
        NSDate *date = [formatter dateFromString:dateStr];
        formatter.dateFormat = @"yyyy-MM-dd";
        dateStr = [formatter stringFromDate:date];
        CGSize dateSize = [dateStr sizeWithAttributes:@{NSFontAttributeName:[UIFont f39Font]}];
        CGPoint drawDatePoint = CGPointMake(self.positionModel.startPoint.x-dateSize.width/2, 0);
        
        if (CGPointEqualToPoint(self.lastDrawDatePoint, CGPointZero) || drawDatePoint.x - self.lastDrawDatePoint.x > 100) {
            
            self.lastDrawDatePoint = drawDatePoint;
            
            CGPoint startPoint = CGPointMake(self.positionModel.startPoint.x, 0);
            CGPoint endPoint = CGPointMake(self.positionModel.startPoint.x, self.positionModel.endPoint.y);
            [self drawline:context startPoint:startPoint stopPoint:endPoint color:[UIColor gridLineColor] lineWidth:0.25];
        }
        
        
        
        
    }
    
    
    
    
    
    CGContextSetStrokeColorWithColor(context, self.lineColor.CGColor);
    //设置线的宽度
    CGContextSetLineWidth(context, [HYStockChartGloablVariable kLineWidth]);
    //画实体线
    const CGPoint solidPoints[] = {self.positionModel.startPoint,self.positionModel.endPoint};
    CGContextStrokeLineSegments(context, solidPoints, 2);
}

#pragma mark - **************** 绘制线
- (void)drawline:(CGContextRef)context
      startPoint:(CGPoint)startPoint
       stopPoint:(CGPoint)stopPoint
           color:(UIColor *)color
       lineWidth:(CGFloat)lineWitdth
{
    CGContextSetStrokeColorWithColor(context, color.CGColor);
    CGContextSetLineWidth(context, lineWitdth);
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, startPoint.x, startPoint.y);
    CGContextAddLineToPoint(context, stopPoint.x,stopPoint.y);
    CGContextStrokePath(context);
}


@end
