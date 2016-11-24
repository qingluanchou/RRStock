//
//  RRStockChartView.h
//  HYStockChartDemo
//
//  Created by 人人操盘 on 16/9/1.
//  Copyright © 2016年 jimubox. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYStockChartConstant.h"
#import "HYStockChartView.h"

@protocol HYStockChartViewDataSource;

/************************展示K线、成交量、趋势图、各种数据的最终的View************************/
@interface RRStockChartView : UIView

@property(nonatomic,strong) NSArray *itemModels;

/**
 *  数据源
 */
@property(nonatomic,weak) id<HYStockChartViewDataSource> dataSource;

/**
 *  选中的索引
 */
@property(nonatomic,assign,readonly) NSInteger currentIndex;

/**
 *  股票简介模型
 */
//@property(nonatomic,strong) HYStockChartProfileModel *stockChartProfileModel;


/**
 *  重新加载数据
 */
-(void)reloadData;


@end

/************************数据源************************/
@protocol HYStockChartViewDataSource <NSObject>

@required
/**
 *  某个index指定的数据
 */
-(id)stockDatasWithIndex:(NSInteger)index;

@end

