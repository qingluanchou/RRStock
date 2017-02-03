//
//  HYTimeLineAboveView.m
//  JimuStockChartDemo
//
//  Created by jimubox on 15/5/8.
//  Copyright (c) 2015年 jimubox. All rights reserved.
//

#import "HYTimeLineAboveView.h"
#import "HYTimeLineModel.h"
#import "HYStockChartConstant.h"
#import "HYTimeLineAbovePositionModel.h"
#import "HYTimeLine.h"
#import "Masonry.h"
#import "HYTimeLineGroupModel.h"
#import "UIColor+HYStockChart.h"
#import "NSDateFormatter+HYStockChart.h"
#import "HYStockChartGloablVariable.h"
#import "MJExtension.h"
#import "UIView+HXCircleAnimation.h"
#import "YYTimeLineMaskView.h"

#define currentDetailDataListWidth 100
#define currentContentOffset 10

@interface HYTimeLineAboveView()

@property(nonatomic,strong) NSArray *positionModels;

@property(nonatomic,strong) NSArray *colorModels;

@property(nonatomic,assign) CGFloat horizontalViewYPosition;

@property(nonatomic,strong) UIView *timeLabelView;

@property(nonatomic,strong) NSArray *timeLineModels;

@property(nonatomic,strong) UILabel *firstTimeLabel;

@property(nonatomic,strong) UILabel *secondTimeLabel;

@property(nonatomic,strong) UILabel *thirdTimeLabel;

@property(nonatomic,assign) CGFloat offsetMaxPrice;

@property (nonatomic,strong)UIView *breathingPointView;

@property (nonatomic,strong)YYTimeLineMaskView *maskView;

@end

@implementation HYTimeLineAboveView

#pragma mark initWithFrame方法
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _positionModels = nil;
        _horizontalViewYPosition = 0;
    }
    return self;
}

-(void)drawRect:(CGRect)rect
{
    if (!self.timeLineModels) {
        return;
    }
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context, rect);
    CGContextSetFillColorWithColor(context, [UIColor backgroundColor].CGColor);
    CGContextFillRect(context, rect);
    
    //时间标题背景色
    CGContextSetFillColorWithColor(context, [UIColor assistBackgroundColor].CGColor);
    CGContextFillRect(context, CGRectMake(0, HYStockChartTimeLineAboveViewMaxY, self.frame.size.width, self.frame.size.height-HYStockChartTimeLineAboveViewMaxY));
    
    [self drawGridBackground:context rect:rect];
    
    HYTimeLine *timeLine = [[HYTimeLine alloc] initWithContext:context];
    //添加位置数组划线
    timeLine.positionModels = [self private_convertTimeLineModlesToPositionModel];
    timeLine.horizontalYPosition = self.horizontalViewYPosition;
    timeLine.timeLineViewWidth = self.frame.size.width;
    timeLine.timeLineViewMaxY = HYStockChartTimeLineAboveViewMaxY;
    [timeLine draw];
    [super drawRect:rect];
}

#pragma mark - **************** 画边框
- (void)drawGridBackground:(CGContextRef)context
                      rect:(CGRect)rect;
{
    UIColor * backgroundColor = [UIColor whiteColor];
    CGContextSetFillColorWithColor(context, backgroundColor.CGColor);
    CGContextFillRect(context, rect);
    
    //画边框
    CGContextSetLineWidth(context, HYStockChartTimeLineGridWidth);
    CGContextSetStrokeColorWithColor(context, [UIColor gridLineColor].CGColor);
    CGContextStrokeRect(context, CGRectMake(0, 0, rect.size.width , HYStockChartTimeLineAboveViewMaxY));
    
    if (self.centerViewType == HYStockChartCenterViewTypeTimeLine)
    {
        //画中间的线
        [self drawline:context startPoint:CGPointMake((rect.size.width ) / 2,0) stopPoint:CGPointMake(rect.size.width / 2, HYStockChartKLineAboveViewMaxY) color:[UIColor gridLineColor] lineWidth:HYStockChartTimeLineGridWidth];
    }
   
    
}

#pragma mark - **************** 长按操作
- (void)showTouchView:(NSSet<UITouch *> *)touches {
    static CGFloat oldPositionX = 0;
    CGPoint location = [touches.anyObject locationInView:self];
    if (location.x < HYStockChartTimeLineAboveViewMinX || location.x > HYStockChartTimeLineBelowViewMaxX || location.y < HYStockChartTimeLineAboveViewMinY || location.y > HYStockChartTimeLineAboveViewMaxY - 10) return;
    CGFloat xUnitValue = [self private_getXAxisUnitValue];
    if(ABS(oldPositionX - location.x) < xUnitValue) return;
    
    oldPositionX = location.x;
    NSInteger startIndex = [self getPositionWithOriginXPosition:oldPositionX];
    if (startIndex < 0) startIndex = 0;
    if (startIndex >= self.timeLineModels.count) startIndex = self.timeLineModels.count - 1;
    
    if (!self.maskView) {
        _maskView = [YYTimeLineMaskView new];
        _maskView.backgroundColor = [UIColor clearColor];
        [self addSubview:_maskView];
        [_maskView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    } else {
        self.maskView.hidden = NO;
    }
    
    //selectedModel = self.timeLineModels[startIndex];
    self.maskView.selectedModel = self.timeLineModels[startIndex];
    HYTimeLineAbovePositionModel *model = (HYTimeLineAbovePositionModel *)self.positionModels[startIndex];
    self.maskView.selectedPoint = model.currentPoint;
    self.maskView.timeLineView = self;
    if (self.delegate && [self.delegate respondsToSelector:@selector(timeLineAboveViewLongPressAboveLineModel:selectPoint:)]) {
        [self.delegate timeLineAboveViewLongPressAboveLineModel:self.timeLineModels[startIndex] selectPoint:model.currentPoint];
    }
    [self setNeedsDisplay];
    [self.maskView setNeedsDisplay];
}

- (void)hideTouchView {
    //恢复scrollView的滑动
    //selectedModel = self.timeLineModels.lastObject;
    [self setNeedsDisplay];
    self.maskView.hidden = YES;
//    if (self.delegate && [self.delegate respondsToSelector:@selector(YYStockView: selectedModel:)]) {
//        [self.delegate YYStockView:self selectedModel:nil];
//    }
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self showTouchView:touches];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self showTouchView:touches];
    [[NSNotificationCenter defaultCenter] postNotificationName:CanAcceptTouchNotificationName object:@"1"];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self hideTouchView];
    [[NSNotificationCenter defaultCenter] postNotificationName:CanAcceptTouchNotificationName object:@"0"];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(timeLineAboveViewLongPressDismiss)]) {
        [self.delegate timeLineAboveViewLongPressDismiss];
    }
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self hideTouchView];
    [[NSNotificationCenter defaultCenter] postNotificationName:CanAcceptTouchNotificationName object:@"0"];
    if (self.delegate && [self.delegate respondsToSelector:@selector(timeLineAboveViewLongPressDismiss)]) {
        [self.delegate timeLineAboveViewLongPressDismiss];
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


#pragma mark - get&set方法
-(UIView *)timeLabelView
{
    if (!_timeLabelView) {
        _timeLabelView = [UIView new];
        [self addSubview:_timeLabelView];
        [_timeLabelView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_bottom);
            make.width.left.equalTo(self);
            make.height.equalTo(@(HYStockChartTimeLineTimeLabelViewHeight));
        }];
        NSString *startTime = nil;
        NSString *middleTime = nil;
        NSString *endTime = nil;
        HYStockType stockType = [HYStockChartGloablVariable stockType];
        switch (stockType) {
            case HYStockTypeA:
                startTime = @"09:30";
                middleTime = @"13:00";
                endTime = @"15:00";
                break;
            case HYStockTypeUSA:
                startTime = @"09:30";
                middleTime = @"12:45";
                endTime = @"16:00";
                break;
            default:
                break;
        }
        self.firstTimeLabel = [self private_createTimeLabel];
        self.firstTimeLabel.text = startTime;
        [_timeLabelView addSubview:self.firstTimeLabel];
        self.secondTimeLabel = [self private_createTimeLabel];
        self.secondTimeLabel.text = middleTime;
        [_timeLabelView addSubview:self.secondTimeLabel];
        self.thirdTimeLabel = [self private_createTimeLabel];
        self.thirdTimeLabel.text = endTime;
        [_timeLabelView addSubview:self.thirdTimeLabel];
        [self.firstTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(_timeLabelView).offset(5);
            make.height.equalTo(@(10));
            make.width.equalTo(@(50));
        }];
        [self.secondTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_timeLabelView.mas_centerX);
            make.top.height.equalTo(self.firstTimeLabel);
        }];
        self.thirdTimeLabel.textAlignment = NSTextAlignmentRight;
        [self.thirdTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_timeLabelView.mas_right).offset(-5);
            make.top.height.width.equalTo(self.firstTimeLabel);
        }];
    }
    return _timeLabelView;
}

#pragma mark groupModel的set方法
-(void)setGroupModel:(HYTimeLineGroupModel *)groupModel
{
    _groupModel = groupModel;
    
    if (groupModel) {
        
        //先将groupModel里面的数组根据时间排序
        NSArray *timeLineModels = groupModel.timeModels;
        NSDateFormatter *dateFormatter = [NSDateFormatter new];
        dateFormatter.dateFormat = @"MM-dd-yyyy";
        NSDateFormatter *timeFormatter = [NSDateFormatter new];
        timeFormatter.dateFormat = @"hh:mm:ss a";
        NSArray *newTimeLineModels = [timeLineModels sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            HYTimeLineModel *timeLineModel1 = (HYTimeLineModel *)obj1;
            HYTimeLineModel *timeLineModel2 = (HYTimeLineModel *)obj2;
            NSDate *date1 = [dateFormatter dateFromString:timeLineModel1.currentDate];
            NSDate *date2 = [dateFormatter dateFromString:timeLineModel2.currentDate];
            if ([date1 compare:date2] != NSOrderedSame) {
                return [date1 compare:date2];
            }else{
                date1 = [timeFormatter dateFromString:timeLineModel1.currentTime];
                date2 = [timeFormatter dateFromString:timeLineModel2.currentTime];
                return [date1 compare:date2];
            }
            return YES;
        }];
        
        self.timeLineModels = newTimeLineModels;
        _groupModel.timeModels = newTimeLineModels;
        self.timeLabelView.backgroundColor = [UIColor clearColor];
    }
}

#pragma mark - 公有方法
#pragma mark 画时分线的方法
-(void)drawAboveView
{
    NSAssert(self.timeLineModels, @"timeLineModels不能为空!");
    [self setNeedsDisplay];
}

#pragma mark 长按的时候根据原始的x的位置获得精确的X的位置
-(CGPoint)getRightXPositionWithOriginXPosition:(CGFloat)originXPosition
{
    NSAssert(_positionModels, @"位置数组不能为空!");
    CGFloat gap = 0.6;
    if (self.positionModels.count > 1) {
        HYTimeLineAbovePositionModel *firstModel = [self.positionModels firstObject];
        HYTimeLineAbovePositionModel *secondModel = self.positionModels[1];
        gap = (secondModel.currentPoint.x - firstModel.currentPoint.x)/2;
    }
    NSInteger idx = 0;
    for (HYTimeLineAbovePositionModel *positionModel in self.positionModels) {
        if (originXPosition < positionModel.currentPoint.x+gap && originXPosition > positionModel.currentPoint.x-gap) {
            if (self.delegate && [self.delegate respondsToSelector:@selector(timeLineAboveViewLongPressTimeLineModel:)]) {
                [self.delegate timeLineAboveViewLongPressTimeLineModel:self.timeLineModels[idx]];
            }
            return positionModel.currentPoint;
        }
        idx++;
    }
    //这里必须为负数，没有找到的合适的位置，竖线就返回这个位置。
    return CGPointMake(-10, -10);
}

-(NSInteger)getPositionWithOriginXPosition:(CGFloat)originXPosition
{
    NSAssert(_positionModels, @"位置数组不能为空!");
    CGFloat gap = 0.6;
    if (self.positionModels.count > 1) {
        HYTimeLineAbovePositionModel *firstModel = [self.positionModels firstObject];
        HYTimeLineAbovePositionModel *secondModel = self.positionModels[1];
        gap = (secondModel.currentPoint.x - firstModel.currentPoint.x)/2;
    }
    NSInteger idx = 0;
    for (HYTimeLineAbovePositionModel *positionModel in self.positionModels) {
        if (originXPosition < positionModel.currentPoint.x+gap && originXPosition > positionModel.currentPoint.x-gap) {
            if (self.delegate && [self.delegate respondsToSelector:@selector(timeLineAboveViewLongPressTimeLineModel:)]) {
                [self.delegate timeLineAboveViewLongPressTimeLineModel:self.timeLineModels[idx]];
            }
            return idx;
        }
        idx++;
    }
    //这里必须为负数，没有找到的合适的位置，竖线就返回这个位置。
    return -1;
}


#pragma mark - 私有方法
#pragma mark 将HYTimeLineModel转换成对应的position模型
-(NSArray *)private_convertTimeLineModlesToPositionModel
{
    NSAssert(self.timeLineModels, @"timeLineModels不能为空!");
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    //1.算y轴的单元值
    HYTimeLineModel *firstModel = [self.timeLineModels firstObject];
    __block CGFloat minPrice = firstModel.currentPrice;
    __block CGFloat maxPrice = firstModel.currentPrice;
    //算出y轴单位值
    CGFloat yUnitValue = 0.0;
    CGFloat minY = HYStockChartTimeLineAboveViewMinY; //10
    CGFloat maxY = HYStockChartTimeLineAboveViewMaxY; //self.frame.size.height-19
    
    //五日分时线
    if (self.centerViewType == HYStockChartCenterViewTypeBrokenLine)
    {
        
        [self.timeLineModels enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            HYTimeLineModel *timeLineModel = (HYTimeLineModel *)obj;
            if (timeLineModel.currentPrice < minPrice) {
                minPrice = timeLineModel.currentPrice;
            }
            if (timeLineModel.currentPrice > maxPrice) {
                maxPrice = timeLineModel.currentPrice;
            }
        }];

        yUnitValue = (maxPrice - minPrice)/(maxY-minY - currentContentOffset);
        
        //昨天最后价格点，画虚线的y点
        //self.horizontalViewYPosition = (firstModel.currentPrice-minPrice)/yUnitValue + 10;
        self.horizontalViewYPosition = (maxY - (firstModel.currentPrice - minPrice)/yUnitValue - minY);
        
        [self drawFiveDaysRightMarkAtt:context maxPrice:maxPrice minPrice:minPrice];
        
    }
    else
    {
        [self.timeLineModels enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            HYTimeLineModel *timeLineModel = (HYTimeLineModel *)obj;
            self.offsetMaxPrice = self.offsetMaxPrice >fabs(self.groupModel.lastDayEndPrice-timeLineModel.currentPrice)?self.offsetMaxPrice:fabs(self.groupModel.lastDayEndPrice-timeLineModel.currentPrice);
        }];
       
        maxPrice = self.groupModel.lastDayEndPrice + self.offsetMaxPrice;
        minPrice =self.groupModel.lastDayEndPrice - self.offsetMaxPrice;
        [self drawRightMarkAtt:context maxPrice:maxPrice midPrice:self.groupModel.lastDayEndPrice minPrice:minPrice];
    
        yUnitValue = (maxPrice - minPrice)/(maxY-minY - currentContentOffset);
        
        //昨天最后价格点，画虚线的y点
        self.horizontalViewYPosition = (self.groupModel.lastDayEndPrice-minPrice)/yUnitValue + currentContentOffset;
        
        
    }
    
    
    //算出y轴单位值
    //CGFloat yUnitValue = (maxPrice - minPrice)/(maxY-minY - 10);
    
    
    
    //2.算出x轴的单元值
    CGFloat xUnitValue = [self private_getXAxisUnitValue];
    
    //转换成posisiton的模型，为了不多遍历一次数组，在这里顺便把折线情况下的日期也设置一下
    NSMutableArray *positionArray = [NSMutableArray array];
    //颜色信息
    NSMutableArray *colorArray = [NSMutableArray array];
    NSInteger index = 0;

    NSArray *xChouZuoBiaoArray = [NSArray array];
    //设置一下时间
    if (self.centerViewType == HYStockChartCenterViewTypeBrokenLine) {
        self.firstTimeLabel.hidden = YES;
        self.secondTimeLabel.hidden = YES;
        self.thirdTimeLabel.hidden = YES;
        
        xChouZuoBiaoArray = [self private_findTradeDateWithModels:self.timeLineModels];
        
        //添加分时线宽度
        CGContextSetLineWidth(context, 0.25);
        //添加分时线颜色
        CGContextSetStrokeColorWithColor(context, [UIColor gridLineColor].CGColor);
        
        for (int i = 0; i < 4; i ++)
        {
            CGFloat xzhouriqi = (HYStockChartTimeLineAboveViewMaxX-HYStockChartTimeLineAboveViewMinX) * (i + 1 ) / 5.0;
            CGContextMoveToPoint(context,xzhouriqi, 0);
            CGContextAddLineToPoint(context, xzhouriqi, maxY);
            
            CGContextStrokePath(context);
        }
        
        for (int i = 0; i < 5; i++)
        {
            CGFloat xzhouriqizuobiao = (HYStockChartTimeLineAboveViewMaxX-HYStockChartTimeLineAboveViewMinX) * (i * 2 + 1 ) / 10.0;
            HYTimeLineModel *currentModel = xChouZuoBiaoArray[i];
            NSString *currentXZuoBiaoStr = [currentModel.currentDate substringToIndex:5];
            NSMutableAttributedString * rightMarkerStrAtt = [[NSMutableAttributedString alloc]initWithString:currentXZuoBiaoStr attributes:nil];
            
            CGSize currentXZuoBiaoSize = [rightMarkerStrAtt size];
            [self drawLabel:context attributesText:rightMarkerStrAtt rect:CGRectMake(xzhouriqizuobiao - currentXZuoBiaoSize.width / 2, maxY + 2, currentXZuoBiaoSize.width, currentXZuoBiaoSize.height)];
        }
        
        
        
        
    }
    
    CGFloat oldXPosition = -1;
    UIColor *color;
    for (HYTimeLineModel *timeLineModel in self.timeLineModels) {
        CGFloat xPosition = 0;
        CGFloat yPosition = 0;
        switch (self.centerViewType) {
            case HYStockChartCenterViewTypeTimeLine:
            {
                if (oldXPosition < 0) {
                    oldXPosition = 0;
                    xPosition = oldXPosition;
                }else{
                    //每2分钟一次数据
                    xPosition = oldXPosition+ xUnitValue * 2;
                    oldXPosition = xPosition;
                }
                yPosition = (maxY - (timeLineModel.currentPrice - minPrice)/yUnitValue - minY);
            }
                break;
            case HYStockChartCenterViewTypeBrokenLine:
            {
                if (oldXPosition < 0) {
                    oldXPosition = HYStockChartTimeLineAboveViewMinX;
                    xPosition = oldXPosition;
                }else{
                    //5日线每10分钟取一次
                    xPosition = oldXPosition + xUnitValue;
                    oldXPosition = xPosition;
                }
                yPosition = (maxY - (timeLineModel.currentPrice - minPrice)/yUnitValue - minY);
            }
                break;
            default:break;
        }
        
        if (index == 0)
        {
            if(timeLineModel.currentPrice >= self.groupModel.lastDayEndPrice)
            {
                color = [UIColor increaseColor];
            }
            else
            {
               color = [UIColor decreaseColor];
            }
        }
        else
        {
            HYTimeLineModel *lastTimeLineModel = self.timeLineModels[index - 1];
            if(timeLineModel.currentPrice >= lastTimeLineModel.currentPrice)
            {
                color = [UIColor increaseColor];
            }
            else
            {
                color = [UIColor decreaseColor];
            }
        }
        
        [colorArray addObject:color];
        
        index++;
        NSAssert(!isnan(xPosition)&&!isnan(yPosition), @"x或y出现NAN值!");
        HYTimeLineAbovePositionModel *positionModel = [HYTimeLineAbovePositionModel new];
        positionModel.currentPoint = CGPointMake(xPosition, yPosition);
        [positionArray addObject:positionModel];
    }
    _positionModels = positionArray;
    _colorModels = colorArray;
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(timeLineAboveView:positionModels:colorModels:)]) {
            [self.delegate timeLineAboveView:self positionModels:positionArray colorModels:colorArray];
        }
    }
    HYTimeLineAbovePositionModel *endPositionModel = [positionArray lastObject];
    CGPoint endPoint = endPositionModel.currentPoint;
    if (self.endPointShowEnabled)
    {
        self.breathingPointView.frame = CGRectMake(endPoint.x - 2, endPoint.y - 2, 4, 4);
        [self.breathingPointView showCircleAnimationLayerWithColor:[UIColor timeLineLineColor] andScale:4.0f];
    }
    
    return positionArray;
}


#pragma mark 找出某个月的第一个交易日
-(NSArray *)private_findTradeDateWithModels:(NSArray *)sortedTimeLineModels;
{
    __block HYTimeLineModel *comparingModel = [sortedTimeLineModels firstObject];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"MM/dd/yyyy";
    NSMutableArray *fiveDayList = [NSMutableArray array];
    [fiveDayList addObject:comparingModel];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [sortedTimeLineModels enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        HYTimeLineModel *timeLineModel = (HYTimeLineModel *)obj;
        NSDate *compaingDate = [formatter dateFromString:comparingModel.currentDate];
        NSDate *objDate = [formatter dateFromString:timeLineModel.currentDate];
        NSDateComponents *compingComponent = [calendar components:NSCalendarUnitMonth | NSCalendarUnitDay fromDate:compaingDate];
        NSDateComponents *objComponent = [calendar components:NSCalendarUnitMonth | NSCalendarUnitDay fromDate:objDate];
        if (compingComponent.month != objComponent.month || compingComponent.day != objComponent.day) {
            comparingModel = timeLineModel;
            [fiveDayList addObject:timeLineModel];
        }
    }];
    return  fiveDayList;
}


#pragma mark - **************** 分时图右侧坐标值
- (void)drawRightMarkAtt:(CGContextRef)context maxPrice:(CGFloat)maxPrice midPrice:(CGFloat)midPrice minPrice:(CGFloat)minPrice
{
    // ------分时图右侧坐标值
    NSMutableAttributedString * rightMarkerMaxStrAtt = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%.02f",maxPrice] attributes:nil];
    CGSize currentXZuoBiaoSize = [rightMarkerMaxStrAtt size];
    [self drawLabel:context attributesText:rightMarkerMaxStrAtt rect:CGRectMake(HYStockChartTimeLineAboveViewMaxX - currentXZuoBiaoSize.width - 5, currentContentOffset, currentXZuoBiaoSize.width, currentXZuoBiaoSize.height)];
    
    NSMutableAttributedString * rightMarkerMidStrAtt = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%.02f",midPrice] attributes:nil];
    [self drawLabel:context attributesText:rightMarkerMidStrAtt rect:CGRectMake(HYStockChartTimeLineAboveViewMaxX - currentXZuoBiaoSize.width - 5, (HYStockChartTimeLineAboveViewMaxY  -currentXZuoBiaoSize.height) / 2 , currentXZuoBiaoSize.width, currentXZuoBiaoSize.height)];
    
    NSMutableAttributedString * rightMarkerMinStrAtt = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%.02f",minPrice] attributes:nil];
    [self drawLabel:context attributesText:rightMarkerMinStrAtt rect:CGRectMake(HYStockChartTimeLineAboveViewMaxX - currentXZuoBiaoSize.width - 5, HYStockChartTimeLineAboveViewMaxY - currentContentOffset - currentXZuoBiaoSize.height / 2, currentXZuoBiaoSize.width, currentXZuoBiaoSize.height)];

}


#pragma mark - **************** 五日分时图右侧坐标值
- (void)drawFiveDaysRightMarkAtt:(CGContextRef)context maxPrice:(CGFloat)maxPrice  minPrice:(CGFloat)minPrice
{
    CGFloat minY = HYStockChartTimeLineAboveViewMinY;
    CGFloat maxY = HYStockChartTimeLineAboveViewMaxY;
    // ------分时图右侧坐标值
    NSMutableAttributedString * rightMarkerMaxStrAtt = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%.02f",maxPrice] attributes:nil];
    CGSize currentXZuoBiaoSize = [rightMarkerMaxStrAtt size];
    [self drawLabel:context attributesText:rightMarkerMaxStrAtt rect:CGRectMake(HYStockChartTimeLineAboveViewMaxX - currentXZuoBiaoSize.width - 5, minY  - currentXZuoBiaoSize.height / 2, currentXZuoBiaoSize.width, currentXZuoBiaoSize.height)];
    
    
    
    NSMutableAttributedString * rightMarkerMinStrAtt = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%.02f",minPrice] attributes:nil];
    [self drawLabel:context attributesText:rightMarkerMinStrAtt rect:CGRectMake(HYStockChartTimeLineAboveViewMaxX - currentXZuoBiaoSize.width - 5, maxY-minY - currentXZuoBiaoSize.height / 2, currentXZuoBiaoSize.width, currentXZuoBiaoSize.height)];
    
}


//画x轴坐标
- (void)drawLabel:(CGContextRef)context
   attributesText:(NSAttributedString *)attributesText
             rect:(CGRect)rect
{
    [attributesText drawInRect:rect];
    //[self drawRect:context rect:rect color:[UIColor clearColor]];
}

#pragma mark 创建时间的label
-(UILabel *)private_createTimeLabel
{
    UILabel *timeLabel = [UILabel new];
    timeLabel.font = [UIFont systemFontOfSize:11];
    timeLabel.textColor = [UIColor colorWithRGBHex:0x2d333a];
    return timeLabel;
}

-(CGFloat)private_getXAxisUnitValue
{
    NSTimeInterval oneDayTradeTimes = [self private_oneDayTradeTimes];
    CGFloat xUnitValue = 0;
    //当天分时
    if (self.centerViewType == HYStockChartCenterViewTypeTimeLine) {
        xUnitValue = (HYStockChartTimeLineAboveViewMaxX-HYStockChartTimeLineAboveViewMinX)/oneDayTradeTimes;
        return xUnitValue;
    }
    else
    {
        //多天分时
        HYTimeLineModel *currentModel = [self.timeLineModels firstObject];
        NSInteger days = 1;
        for (HYTimeLineModel *timeLineModel in self.timeLineModels) {
            if (![currentModel.currentDate isEqualToString:timeLineModel.currentDate]) {
                currentModel = timeLineModel;
                days += 1;
            }
        }
        NSTimeInterval totalMinutes = days * 26;     
        xUnitValue = (HYStockChartTimeLineAboveViewMaxX-HYStockChartTimeLineAboveViewMinX)/totalMinutes;
        
        return xUnitValue;
    }
}


#pragma mark 一天的交易总时间，单位是分钟
-(CGFloat)private_oneDayTradeTimes
{
    HYStockType stockType = [HYStockChartGloablVariable stockType];
    switch (stockType) {
        case HYStockTypeA:
            //（9：30-11：30，13：00-15：00）
            return 240;
            break;
        case HYStockTypeUSA:
            //（9：30-16：00）
            return 390;
            break;
        default:
            return 240;
            break;
    }
}

//-(CGFloat)private_getTodayTimeOffsetWithCurrentTime:(NSString *)currentTime
//{
//    NSDateFormatter *formatter = [NSDateFormatter shareDateFormatter];
//    formatter.dateFormat = @"MM-dd-yyyy hh:mm:ss a";
//    NSDate *currentDateTime = [formatter dateFromString:currentTime];
//
//    
//    NSArray *currentTimes = [currentTime componentsSeparatedByString:@" "];
//    NSString *formatStartTimeString = [[currentTimes firstObject] stringByAppendingString:@" 09:30:00 AM"];
//    NSDate *formatStartTime = [formatter dateFromString:formatStartTimeString];
//    
//    NSString *formatMiddleStartTimeString = [[currentTimes firstObject] stringByAppendingString:@" 01:00:00 PM"];
//    NSDate *formatMiddleStartTime = [formatter dateFromString:formatMiddleStartTimeString];
//    HYStockType stockType = [HYStockChartGloablVariable stockType];
//    switch (stockType) {
//        case HYStockTypeA:
//            if ([currentDateTime timeIntervalSinceDate:formatMiddleStartTime] >= 0) {
//                currentDateTime = [currentDateTime dateByAddingTimeInterval:-5400];
//            }
//            break;
//        case HYStockTypeUSA:break;
//        default:
//            break;
//    }
//
//    
//    NSTimeInterval rightTimeInterval = [currentDateTime timeIntervalSinceDate:formatStartTime]/60;
//    return rightTimeInterval;
//}

//-(CGFloat)private_getXOffsetFromTime:(NSString *)minTimeString toTime:(NSString *)maxTimeString xUnitValue:(CGFloat)xUnitValue
//{
//    NSDateFormatter *formatter = [NSDateFormatter shareDateFormatter];
//    formatter.dateFormat = @"MM-dd-yyyy hh:mm:ss a";
//
//    //0.格式化minTime为当天的日期和00:00:00
//    NSArray *minTimes = [minTimeString componentsSeparatedByString:@" "];
//    NSString *formatMinTimeString = [[minTimes firstObject] stringByAppendingString:@" 00:00:00 AM"];
//    NSDate *formatMinTime = [formatter dateFromString:formatMinTimeString];
//
//    //1.格式化maxTime为当天的日期和00:00:00
//    NSArray *maxTimes = [maxTimeString componentsSeparatedByString:@" "];
//    NSString *formatMaxTimeString = [[maxTimes firstObject] stringByAppendingString:@" 00:00:00 AM"];
//    NSDate *formatMaxTime = [formatter dateFromString:formatMaxTimeString];
//
//    //2.算出间隔有多少天
//    NSTimeInterval daysInterval = [formatMaxTime timeIntervalSinceDate:formatMinTime];
//    NSInteger days = daysInterval/(24*60*60);
//
//    //3.加上maxTime的time距离09:30:00有多少分钟
//    NSTimeInterval lastTimeInterval = [self private_getTodayTimeOffsetWithCurrentTime:maxTimeString];
//    NSTimeInterval totalTimeInterval = days*[self private_oneDayTradeTimes]+lastTimeInterval;
//
//    //4.除以xUnitValue
//    return totalTimeInterval/xUnitValue;
//}

- (UIView *)breathingPointView
{
    
    if (_breathingPointView == nil)
    {
        _breathingPointView = [[UIView alloc] init];
        _breathingPointView.backgroundColor = [UIColor timeLineLineColor];
        _breathingPointView.layer.cornerRadius = 2;
        _breathingPointView.layer.masksToBounds = YES;
        [self addSubview:_breathingPointView];
    }
    return _breathingPointView;
    
}
@end
