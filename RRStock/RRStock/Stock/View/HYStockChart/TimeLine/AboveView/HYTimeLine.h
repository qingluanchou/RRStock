//
//  HYTimeLine.h
//  JimuStockChartDemo
//
//  Created by jimubox on 15/5/8.
//  Copyright (c) 2015年 jimubox. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYTimeLineAbovePositionModel.h"

/************************用于画分时线的画笔************************/
@interface HYTimeLine : NSObject

/**曲线点位置数据数组*/
@property(nonatomic,strong) NSArray *positionModels;

/** 昨天收盘价位置*/
@property(nonatomic,assign) CGFloat horizontalYPosition;

@property(nonatomic,assign) CGFloat timeLineViewWidth;

@property(nonatomic,assign) CGFloat timeLineViewMaxY;

-(instancetype)initWithContext:(CGContextRef)context;

-(void)draw;

@end
