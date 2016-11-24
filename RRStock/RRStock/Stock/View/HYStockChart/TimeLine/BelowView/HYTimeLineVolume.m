//
//  HYTimeLineVolume.m
//  JimuStockChartDemo
//
//  Created by jimubox on 15/5/11.
//  Copyright (c) 2015年 jimubox. All rights reserved.
//

#import "HYTimeLineVolume.h"
#import "HYStockChartConstant.h"
#import "HYTimeLineBelowPositionModel.h"
#import "UIColor+HYStockChart.h"

@interface HYTimeLineVolume()

@property(nonatomic,assign) CGContextRef context;

@end

@implementation HYTimeLineVolume

-(instancetype)initWithContext:(CGContextRef)context
{
    self = [super init];
    if (self) {
        _context = context;
    }
    return self;
}

-(void)draw
{
    NSAssert(self.timeLineVolumnPositionModels && self.context, @"timeLineVolumnPositionModels不能为空！");
    CGContextRef context = self.context;
    CGFloat volumeLineWidth = self.currentXWidth / self.timeLineVolumnPositionModels.count - 1.0;
    CGContextSetLineWidth(self.context, volumeLineWidth);
    NSInteger index = 0;
    for (HYTimeLineBelowPositionModel *positionModel in self.timeLineVolumnPositionModels) {
        
        UIColor *color = self.colorArray[index];
        CGContextSetStrokeColorWithColor(self.context, color.CGColor);
        //画实体线
        const CGPoint solidPoints[] = {positionModel.startPoint,positionModel.endPoint};
        CGContextStrokeLineSegments(context, solidPoints, 2);
        index ++;
    }
}

@end
