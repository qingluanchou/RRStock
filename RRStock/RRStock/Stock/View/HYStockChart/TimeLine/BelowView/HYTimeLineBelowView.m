//
//  HYTimeLineBelowView.m
//  JimuStockChartDemo
//
//  Created by jimubox on 15/5/8.
//  Copyright (c) 2015年 jimubox. All rights reserved.
//

#import "HYTimeLineBelowView.h"
#import "HYTimeLineModel.h"
#import "HYStockChartConstant.h"
#import "HYTimeLineBelowPositionModel.h"
#import "HYTimeLineVolume.h"
#import "UIColor+HYStockChart.h"
#import "HYTimeLineAboveView.h"
#import "YYTimeLineBelowMaskView.h"

@interface HYTimeLineBelowView()

@property(nonatomic,strong) NSArray *positionModels;

//@property (nonatomic,strong)YYTimeLineMaskView *maskView;

@end

@implementation HYTimeLineBelowView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _positionModels = nil;
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    if (!self.positionModels) {
        return;
    }
    
    [self drawGridBackground:rect];
    if (self.centerViewType == HYStockChartCenterViewTypeBrokenLine) {
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        //添加分时线宽度
        CGContextSetLineWidth(context, 0.25);
        //添加分时线颜色
        CGContextSetStrokeColorWithColor(context, [UIColor gridLineColor].CGColor);
        for (int i = 0; i < 4; i ++)
        {
            CGFloat xzhouriqi = (HYStockChartTimeLineAboveViewMaxX-HYStockChartTimeLineAboveViewMinX) * (i + 1 ) / 5.0;
            CGContextMoveToPoint(context,xzhouriqi, 0);
            CGContextAddLineToPoint(context, xzhouriqi, self.frame.size.height);
            CGContextStrokePath(context);
        }
    }

    HYTimeLineVolume *timeLineVolumn = [[HYTimeLineVolume alloc] initWithContext:UIGraphicsGetCurrentContext()];
    timeLineVolumn.timeLineVolumnPositionModels = self.positionModels;
    timeLineVolumn.currentXWidth = HYStockChartTimeLineAboveViewMaxX-HYStockChartTimeLineAboveViewMinX;
    timeLineVolumn.colorArray = self.colorArray;
    [timeLineVolumn draw];
}


#pragma mark - **************** 画边框
- (void)drawGridBackground:(CGRect)rect;
{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIColor * backgroundColor = [UIColor whiteColor];
    CGContextSetFillColorWithColor(context, backgroundColor.CGColor);
    CGContextFillRect(context, rect);
    
    //画边框
    CGContextSetLineWidth(context, HYStockChartTimeLineGridWidth);
    CGContextSetStrokeColorWithColor(context, [UIColor gridLineColor].CGColor);
    CGContextStrokeRect(context, CGRectMake(0, 0, rect.size.width , rect.size.height));
    
    if (self.centerViewType == HYStockChartCenterViewTypeTimeLine)
    {
        //画中间的线
        [self drawline:context startPoint:CGPointMake((rect.size.width ) / 2,0) stopPoint:CGPointMake(rect.size.width / 2, rect.size.height) color:[UIColor gridLineColor] lineWidth:HYStockChartTimeLineGridWidth];
    }
    
    
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



#pragma mark - 时间
-(void)drawBelowView
{
    [self private_convertTimeLineModelsPositionModels];
    NSAssert(self.positionModels, @"positionModels不能为空");
    [self setNeedsDisplay];
}

#pragma mark - 私有方法
#pragma mark 将分时线的模型数组转换成Y坐标的
-(NSArray *)private_convertTimeLineModelsPositionModels
{
    NSAssert(self.timeLineModels && self.xPositionArray && self.timeLineModels.count == self.xPositionArray.count, @"timeLineModels不能为空!");
    //1.算y轴的单元值
    HYTimeLineModel *firstModel = [self.timeLineModels firstObject];
    __block CGFloat minVolume = firstModel.volume;
    __block CGFloat maxVolume = firstModel.volume;
    [self.timeLineModels enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        HYTimeLineModel *timeLineModel = (HYTimeLineModel *)obj;
        if (timeLineModel.volume < minVolume) {
            minVolume = timeLineModel.volume;
        }
        if (timeLineModel.volume > maxVolume) {
            maxVolume = timeLineModel.volume;
        }
        if (timeLineModel.volume < 0) {
            NSLog(@"%ld",timeLineModel.volume);
        }
    }];
    CGFloat minY = HYStockChartTimeLineBelowViewMinY;
    CGFloat maxY = HYStockChartTimeLineBelowViewMaxY;
    CGFloat yUnitValue = (maxVolume - minVolume)/(maxY-minY);
    
    NSMutableArray *positionArray = [NSMutableArray array];
    
    NSInteger index = 0;
    for (HYTimeLineModel *timeLineModel in self.timeLineModels) {
        CGFloat xPosition = [self.xPositionArray[index] floatValue];
        CGFloat yPosition = (maxY - (timeLineModel.volume - minVolume)/yUnitValue);
        HYTimeLineBelowPositionModel *positionModel = [HYTimeLineBelowPositionModel new];
        positionModel.startPoint = CGPointMake(xPosition, maxY);
        positionModel.endPoint = CGPointMake(xPosition, yPosition);
        [positionArray addObject:positionModel];
        index++;
    }
    _positionModels = positionArray;
    return positionArray;
}

- (void)timeLineAboveViewLongPressAboveLineModel:(HYTimeLineModel *)selectedModel selectPoint:(CGPoint)selectedPoint
{

    NSAssert(self.timeLineModels && self.xPositionArray && self.timeLineModels.count == self.xPositionArray.count, @"timeLineModels不能为空!");
    //1.算y轴的单元值
    HYTimeLineModel *firstModel = [self.timeLineModels firstObject];
    __block CGFloat minVolume = firstModel.volume;
    __block CGFloat maxVolume = firstModel.volume;
    [self.timeLineModels enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        HYTimeLineModel *timeLineModel = (HYTimeLineModel *)obj;
        if (timeLineModel.volume < minVolume) {
            minVolume = timeLineModel.volume;
        }
        if (timeLineModel.volume > maxVolume) {
            maxVolume = timeLineModel.volume;
        }
        if (timeLineModel.volume < 0) {
            NSLog(@"%ld",timeLineModel.volume);
        }
    }];
    
    CGFloat minY = HYStockChartTimeLineBelowViewMinY;
    CGFloat maxY = HYStockChartTimeLineBelowViewMaxY;
    CGFloat yUnitValue = (maxVolume - minVolume)/(maxY-minY);
    
    CGFloat xPosition = selectedPoint.x;
    CGFloat yPosition = (maxY - (selectedModel.volume - minVolume)/yUnitValue);
    
    CGPoint vSelectedPoint = CGPointMake(xPosition,yPosition);
    
    if (!self.maskView) {
        _maskView = [YYTimeLineBelowMaskView new];
        _maskView.backgroundColor = [UIColor clearColor];
        [self addSubview:_maskView];
        [_maskView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    } else {
        self.maskView.hidden = NO;
    }

    self.maskView.selectedModel = selectedModel;
    self.maskView.selectedPoint = vSelectedPoint;
    self.maskView.timeLineView = self;
    [self.maskView setNeedsDisplay];

}


- (void)timeLineAboveViewLongPressDismiss
{
    self.maskView.hidden = YES;
}

@end
