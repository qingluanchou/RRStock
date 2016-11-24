//
//  StockChartTitleView.h
//  RRCP
//
//  Created by 人人操盘 on 16/8/22.
//  Copyright © 2016年 renrencaopan. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  定义点击的block
 *
 *  @param NSInteger 点击column数
 */
typedef void (^StockTabChartTitleClickBlock)(NSInteger);

@interface StockChartTitleView : UIView

-(instancetype)initWithTitleArray:(NSArray *)titleArray;

-(void)setItemSelected: (NSInteger)column;


- (void)setScrollDistance:(CGFloat )ratio;

@property (nonatomic, copy) StockTabChartTitleClickBlock titleClickBlock;

@end
