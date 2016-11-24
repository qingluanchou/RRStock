//
//  RRStockChartView.m
//  HYStockChartDemo
//
//  Created by 人人操盘 on 16/9/1.
//  Copyright © 2016年 jimubox. All rights reserved.
//

#import "RRStockChartView.h"
#import "HYKLine.h"
#import "HYKLineModel.h"
#import "Masonry.h"
#import "HYTimeLineView.h"
#import "HYKLineView.h"
#import "HYTimeLineGroupModel.h"
#import "MJExtension.h"
#import "HYStockChartGloablVariable.h"
#import "HYStockChartProfileModel.h"
#import "JMSKLineGroupModel.h"
#import "JMSTimeLineModel.h"
#import "JMSGroupTimeLineModel.h"
#import "JMSKLineModel.h"
#import "StockChartTitleView.h"

@interface RRStockChartView ()<HYStockChartViewDataSource>

@property(nonatomic,strong) HYTimeLineView *timeLineView;   //分时线view

@property(nonatomic,strong) HYKLineView *kLineView;         //K线view

@property(nonatomic,strong) HYTimeLineView *brokenLineView; //折线view

@property(nonatomic,assign) HYStockChartCenterViewType currentCenterViewType;

@property(nonatomic,assign,readwrite) NSInteger currentIndex;

@property(nonatomic,strong) JMSGroupTimeLineModel *groupTimeLineModel;

@property(nonatomic,strong) NSArray *fiveDaysModels;    //5日线的模型数组

@property(nonatomic,strong) JMSKLineGroupModel *dayKLineGroupModel;//日K线groupModel

@property(nonatomic,strong) JMSKLineGroupModel *weekKLineGroupModle;   //周K线的groupModel

@property(nonatomic,strong) JMSKLineGroupModel *monthKLineGroupModle;   //月K线的groupModel

@property(nonatomic,strong) UIActivityIndicatorView *indicatorView;

@property (nonatomic,weak)StockChartTitleView *tabTitleView;



@end

@implementation RRStockChartView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.dataSource = self;
        
        NSArray *titleArray = @[
                                @"分时",@"五日",@"日K",@"周K",@"月K"];
        StockChartTitleView *tabTitleView = [[StockChartTitleView alloc] initWithTitleArray:titleArray];
        [self addSubview:tabTitleView];
        [tabTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self);
            make.height.mas_equalTo(@44);
            make.top.equalTo(self);
            make.left.equalTo(self);
        }];
        
        
        tabTitleView.titleClickBlock = ^(NSInteger row){
            [self hyStockChartSegmentView:row];
            NSLog(@"---%ld",row);
           // [self.indicatorView stopAnimating];
        };

    }
    return self;
}


#pragma mark kLineView的get方法
-(HYKLineView *)kLineView
{
    if (!_kLineView) {
        _kLineView = [HYKLineView new];
        [self addSubview:_kLineView];
        [_kLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.right.equalTo(self);
            make.top.equalTo(self).offset(46);
            make.bottom.equalTo(self);
        }];
    }
    return _kLineView;
}

#pragma mark timeLineView的get方法
-(HYTimeLineView *)timeLineView
{
    if (!_timeLineView) {
        _timeLineView = [HYTimeLineView new];
        _timeLineView.centerViewType = HYStockChartCenterViewTypeTimeLine;
        [self addSubview:_timeLineView];
        [_timeLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.right.equalTo(self);
            make.top.equalTo(self).offset(46);
            make.bottom.equalTo(self);
        }];
    }
    return _timeLineView;
}

#pragma mark brokenLineView的get方法
-(HYTimeLineView *)brokenLineView
{
    if (!_brokenLineView) {
        _brokenLineView = [HYTimeLineView new];
        _brokenLineView.centerViewType = HYStockChartCenterViewTypeBrokenLine;
        [self addSubview:_brokenLineView];
        [_brokenLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.right.equalTo(self);
            make.top.equalTo(self).offset(46);
            make.bottom.equalTo(self);
        }];
    }
    return _brokenLineView;
}

#pragma mark - set方

#pragma mark - set方法
#pragma mark items的set方法
-(void)setItemModels:(NSArray *)itemModels
{
    _itemModels = itemModels;
    if (itemModels) {
        NSMutableArray *items = [NSMutableArray array];
        for (HYStockChartViewItemModel *item in itemModels) {
            [items addObject:item.title];
        }
     
        HYStockChartViewItemModel *firstModel = [itemModels firstObject];
        self.currentCenterViewType = firstModel.centerViewType;
    }
    if (self.dataSource)
    {
        [self.tabTitleView setItemSelected:0];
        [self hyStockChartSegmentView:0];
    }
}


#pragma mark dataSource的设置方法
-(void)setDataSource:(id<HYStockChartViewDataSource>)dataSource
{
    _dataSource = dataSource;
    if (self.itemModels) {
        [self.tabTitleView setItemSelected:0];
    }
}

/**
 *  重新加载数据
 */

-(void)reloadData
{
    [self hyStockChartSegmentView:self.currentIndex];
}



#pragma mark indicatorView的get方法
-(UIActivityIndicatorView *)indicatorView
{
    if (!_indicatorView) {
        _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        //_indicatorView.frame.size = CGSizeMake(40, 40);
        [self insertSubview:_indicatorView aboveSubview:self.timeLineView];
        [_indicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(40, 40));
        }];
    }
    return _indicatorView;
}


#pragma mark HYStockChartSegmentViewDelegate代理方法
-(void)hyStockChartSegmentView:(NSInteger)index
{
    self.currentIndex = index;
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(stockDatasWithIndex:)]) {
        id stockData = [self.dataSource stockDatasWithIndex:index];
        
        if (!stockData) {
            return;
        }
        
        HYStockChartViewItemModel *itemModel = self.itemModels[index];
        HYStockChartCenterViewType type = itemModel.centerViewType;
        if (type != self.currentCenterViewType) {
            //移除原来的view，设置新的view
            self.currentCenterViewType = type;
            if (type == HYStockChartCenterViewTypeKLine) {
                self.kLineView.hidden = NO;
                self.brokenLineView.hidden = YES;
                self.timeLineView.hidden = YES;
               // [self bringSubviewToFront:self.kLineView];
            }else if(HYStockChartCenterViewTypeTimeLine == type){
                self.timeLineView.hidden = NO;
                self.kLineView.hidden = YES;
                self.brokenLineView.hidden = YES;
            }else{
                self.brokenLineView.hidden = NO;
                self.kLineView.hidden = YES;
                self.timeLineView.hidden = YES;
            }
        }
        
        if (type == HYStockChartCenterViewTypeTimeLine ||
            HYStockChartCenterViewTypeBrokenLine == type) {
            NSAssert([stockData isKindOfClass:[HYTimeLineGroupModel class]], @"数据必须是HYTimeLineGroupModel类型!!!");
            HYTimeLineGroupModel *groupTimeLineModel = (HYTimeLineGroupModel *)stockData;
            if (type == HYStockChartCenterViewTypeTimeLine) {
                self.timeLineView.timeLineGroupModel = groupTimeLineModel;
                [self.timeLineView reDraw];
            }else{
                self.brokenLineView.timeLineGroupModel = groupTimeLineModel;
                [self.brokenLineView reDraw];
            }
        }else{
            NSArray *stockDataArray = (NSArray *)stockData;
            self.kLineView.kLineModels = stockDataArray;
            [self.kLineView reDraw];
        }
    }
}

#pragma mark 分时线数据请求方法
-(void)event_timeLineRequestMethod
{
    //加载假分时线数据
    NSString *path = [[NSBundle mainBundle] pathForResource:@"TimeLine" ofType:@"plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
    NSArray *datas = [dict objectForKey:@"Bars"];
    CGFloat PreClose = [[dict objectForKey:@"PreClose"] floatValue];
    if (!self.groupTimeLineModel) {
        self.groupTimeLineModel = [JMSGroupTimeLineModel new];
    }
    self.groupTimeLineModel.timeLineModels = [JMSTimeLineModel objectArrayWithKeyValuesArray:datas];
    self.groupTimeLineModel.lastDayEndPrice = PreClose;
    [self reloadData];
}


#pragma mark 5日线数据的请求方法
-(void)event_fiveDaysTimeLineRequestMethod
{
    //加载假5日线数据
    NSString *path = [[NSBundle mainBundle] pathForResource:@"FiveDaysLine" ofType:@"plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
    NSArray *datas = [dict objectForKey:@"Bars"];
    self.fiveDaysModels = [JMSTimeLineModel objectArrayWithKeyValuesArray:datas];
    [self reloadData];
}



#pragma mark 日K线数据的请求方法
-(void)event_daylyKLineRequestMethodWithStartDate:(NSDate *)startDate endDate:(NSDate *)endDate
{
    //加载假日K线数据
    NSString *path = [[NSBundle mainBundle] pathForResource:@"DaylyKLine" ofType:@"plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
    self.dayKLineGroupModel = [JMSKLineGroupModel objectWithKeyValues:dict];
    [self reloadData];
}

#pragma mark 周K线数据的请求方法
-(void)event_weeklyKLineRequestMethodWithStartDate:(NSDate *)startDate endDate:(NSDate *)endDate
{
    //加载假周K线数据
    NSString *path = [[NSBundle mainBundle] pathForResource:@"WeeklyKLine" ofType:@"plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
    self.weekKLineGroupModle = [JMSKLineGroupModel objectWithKeyValues:dict];
    [self reloadData];
}

#pragma mark 月K线数据的请求方法
-(void)event_monthlyKLineRequestMethodWithStartDate:(NSDate *)startDate endDate:(NSDate *)endDate
{
    //加载假月K线数据
    NSString *path = [[NSBundle mainBundle] pathForResource:@"MonthlyKLine" ofType:@"plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
    self.monthKLineGroupModle = [JMSKLineGroupModel objectWithKeyValues:dict];
    [self reloadData];
}


#pragma mark 某个对应的Index需要展示的数据
-(id)stockDatasWithIndex:(NSInteger)index
{
    [self bringSubviewToFront:_indicatorView];
    [self.indicatorView startAnimating];
    switch (index) {
        case 0:
            //时分
            if (self.groupTimeLineModel.timeLineModels.count > 0) {
                //先将jms转换成hy
                NSArray *jmsTimeLineDict = [JMSTimeLineModel keyValuesArrayWithObjectArray:self.groupTimeLineModel.timeLineModels];
                NSArray *hyTimeLineModels = [HYTimeLineModel objectArrayWithKeyValuesArray:jmsTimeLineDict];
                HYTimeLineGroupModel *hyTimeGroupModel = [HYTimeLineGroupModel new];
                hyTimeGroupModel.lastDayEndPrice = self.groupTimeLineModel.lastDayEndPrice;
                hyTimeGroupModel.timeModels = hyTimeLineModels;
                [self.indicatorView stopAnimating];
                return hyTimeGroupModel;
            }else{
                [self event_timeLineRequestMethod];
            }
            break;
            
        case 1:
            //5日线
            if (self.fiveDaysModels.count > 0) {
                NSArray *jmsTimeLineDict = [JMSTimeLineModel keyValuesArrayWithObjectArray:self.fiveDaysModels];
                NSArray *hyTimeLineModels = [HYTimeLineModel objectArrayWithKeyValuesArray:jmsTimeLineDict];
                HYTimeLineGroupModel *hyTimeGroupModel = [HYTimeLineGroupModel new];
                hyTimeGroupModel.lastDayEndPrice = 0;
                hyTimeGroupModel.timeModels = hyTimeLineModels;
                [self.indicatorView stopAnimating];
                return hyTimeGroupModel;
            }else{
                [self event_fiveDaysTimeLineRequestMethod];
            }
            break;
        case 2:
            //日K线
            if (self.dayKLineGroupModel.GlobalQuotes > 0) {
                //先将JMS转换成HY
                NSArray *jmsKLineDict = [JMSKLineModel keyValuesArrayWithObjectArray:self.dayKLineGroupModel.GlobalQuotes];
                NSArray *hyKLineModels = [HYKLineModel objectArrayWithKeyValuesArray:jmsKLineDict];
                [self.indicatorView stopAnimating]; 
                return hyKLineModels;
            }else{
                [self event_daylyKLineRequestMethodWithStartDate:nil endDate:nil];
            }
            break;
        case 3:
            //周K线
            if (self.weekKLineGroupModle.GlobalQuotes > 0) {
                //先将JMS转换成HY
                NSArray *jmsKLineDict = [JMSKLineModel keyValuesArrayWithObjectArray:self.weekKLineGroupModle.GlobalQuotes];
                NSArray *hyKLineModels = [HYKLineModel objectArrayWithKeyValuesArray:jmsKLineDict];
                [self.indicatorView stopAnimating];
                return hyKLineModels;
            }else{
                [self event_weeklyKLineRequestMethodWithStartDate:nil endDate:nil];
            }
            break;
        case 4:
            //月K
            if (self.monthKLineGroupModle.GlobalQuotes > 0) {
                //先将JMS转换成HY
                NSArray *jmsKLineDict = [JMSKLineModel keyValuesArrayWithObjectArray:self.monthKLineGroupModle.GlobalQuotes];
                NSArray *hyKLineModels = [HYKLineModel objectArrayWithKeyValuesArray:jmsKLineDict];
                [self.indicatorView stopAnimating];
                return hyKLineModels;
            }else{
                [self event_monthlyKLineRequestMethodWithStartDate:nil endDate:nil];
            }
            break;
        default:
            break;
    }
    return nil;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
