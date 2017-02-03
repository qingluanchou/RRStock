//
//  StockDetailHeaderView.m
//  RRCP
//
//  Created by 人人操盘 on 16/8/22.
//  Copyright © 2016年 renrencaopan. All rights reserved.
//

#import "StockDetailHeaderView.h"
#import "StockDetailTopView.h"
#import "StockChartTitleView.h"
#import "FiveRangeTableView.h"
#import "TradeDetailTableView.h"
#import "RRStockChartView.h"

#define kBtnTag 1000

@interface StockDetailHeaderView ()

@property (nonatomic,weak)StockDetailTopView *topView;

@property (nonatomic,strong)UIView *stockHeaderBottomView;

//底部整体视图
@property (nonatomic,strong)UIView *totalStockHeaderBottomView;

@property (nonatomic,weak)FiveRangeTableView *fiveRangeView;

@property (nonatomic,weak)TradeDetailTableView *tradeDetailView;



@end

@implementation StockDetailHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self makeView];
    }
    return self;
}



- (void)makeView
{
    WEAKSELF(weakSelf);
    StockDetailTopView *topView = [[StockDetailTopView alloc] init];
    [self addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf);
        make.right.equalTo(weakSelf);
        make.height.mas_equalTo(@180);
        make.top.equalTo(weakSelf);
    }];
    self.topView = topView;
    

    RRStockChartView *stockChartView = [[RRStockChartView alloc] init];
    stockChartView.itemModels = @[
                                  [HYStockChartViewItemModel itemModelWithTitle:@"时分" type:HYStockChartCenterViewTypeTimeLine],
                                  [HYStockChartViewItemModel itemModelWithTitle:@"5日" type:HYStockChartCenterViewTypeBrokenLine],
                                  [HYStockChartViewItemModel itemModelWithTitle:@"日K" type:HYStockChartCenterViewTypeKLine],
                                  [HYStockChartViewItemModel itemModelWithTitle:@"周K" type:HYStockChartCenterViewTypeKLine],
                                  [HYStockChartViewItemModel itemModelWithTitle:@"月K" type:HYStockChartCenterViewTypeKLine],
                                  ];
    [self addSubview:stockChartView];
    [stockChartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.top.equalTo(weakSelf.topView.mas_bottom);
        make.height.mas_equalTo(@300);
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(landScapeAction:)];
    [stockChartView addGestureRecognizer:tap];
}



- (void)landScapeAction:(UITapGestureRecognizer *)tapGes
{

    if (self.headerBlock) {
        self.headerBlock();
    }

}


- (void)scrollTradeContentClick:(UIButton *)sender
{
    sender.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1.0];
    NSInteger currentPosition = sender.tag - kBtnTag - 1;
    [UIView animateWithDuration:0.25 animations:^{
        self.tradeDetailView.transform = CGAffineTransformMakeTranslation(-100 * currentPosition, 0);
        self.fiveRangeView.transform = CGAffineTransformMakeTranslation(-100 * currentPosition, 0);
    }];
   
}

- (UIView *)stockHeaderBottomView
{
    if (_stockHeaderBottomView == nil)
    {
        _stockHeaderBottomView = [[UIView alloc] init];
       // _stockHeaderBottomView.backgroundColor = [UIColor blueColor];
        _stockHeaderBottomView.frame = CGRectMake(0, 0, ScreenW, 270);
       // _stockHeaderBottomView.clipsToBounds = YES;
        [self.totalStockHeaderBottomView addSubview:_stockHeaderBottomView];
    }
    return _stockHeaderBottomView;
}




@end
