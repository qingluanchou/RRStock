//
//  HYTimeLineBelowView.h
//  JimuStockChartDemo
//
//  Created by jimubox on 15/5/8.
//  Copyright (c) 2015年 jimubox. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYStockChartConstant.h"

@class HYTimeLineModel;
/************************分时线下面的view************************/
@interface HYTimeLineBelowView : UIView

@property(nonatomic,strong) NSArray *timeLineModels;

//x轴的位置数组
@property(nonatomic,strong) NSArray *xPositionArray;

@property(nonatomic,assign) HYStockChartCenterViewType centerViewType;

//显示颜色数组
@property(nonatomic,strong) NSArray *colorArray;

/**
 *  画下面的view
 */
-(void)drawBelowView;

/**
 *  根据指定颜色清除背景
 */
-(void)clearRectWithColor:(UIColor *)bgColor NS_DEPRECATED_IOS(2_0,2_0,"这个方法暂时没有实现!");

@end
