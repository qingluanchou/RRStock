//
//  HYTimeLineAboveView.h
//  JimuStockChartDemo
//
//  Created by jimubox on 15/5/8.
//  Copyright (c) 2015年 jimubox. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYStockChartConstant.h"

@class HYTimeLineGroupModel;
@protocol HYTimeLineAboveViewDelegate;
@class HYTimeLineModel;
/************************分时线上面的view************************/
@interface HYTimeLineAboveView : UIView

/**
 *  分时线的模型
 */
@property(nonatomic,strong) HYTimeLineGroupModel *groupModel;

@property(nonatomic,assign) HYStockChartCenterViewType centerViewType;

@property(nonatomic,weak) id<HYTimeLineAboveViewDelegate> delegate;

/** 是否展示结束点*/
@property (nonatomic,assign)BOOL endPointShowEnabled;

/**
 *  画AboveView
 */
-(void)drawAboveView;

/**
 *  根据指定颜色清除背景
 */
//-(void)clearRectWithColor:(UIColor *)bgColor NS_DEPRECATED_IOS(2_0,2_0,"这个方法暂时没有实现!");

/**
 *  长按的时候根据原始的x的位置获得精确的X的位置
 */
-(CGPoint)getRightXPositionWithOriginXPosition:(CGFloat)originXPosition;

-(NSInteger)getPositionWithOriginXPosition:(CGFloat)originXPosition;


@end


@protocol HYTimeLineAboveViewDelegate <NSObject>

@optional

//所有的位置点
-(void)timeLineAboveView:(UIView *)timeLineAboveView positionModels:(NSArray *)positionModels  colorModels:(NSArray *)colorModels;

//长按时当前位置的信息
-(void)timeLineAboveViewLongPressTimeLineModel:(HYTimeLineModel *)timeLineModel;

@end
