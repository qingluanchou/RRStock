//
//  HYTimeLineView.m
//  JimuStockChartDemo
//
//  Created by jimubox on 15/5/8.
//  Copyright (c) 2015年 jimubox. All rights reserved.
//

#import "HYTimeLineView.h"
#import "HYTimeLineAboveView.h"
#import "HYTimeLineBelowView.h"
#import "Masonry.h"
#import "HYStockChartConstant.h"
#import "HYTimeLineAbovePositionModel.h"
#import "UIColor+HYStockChart.h"
#import "HYTimeLineLongPressProfileView.h"
#import "HYBrokenLineLongPressProfileView.h"
#import "FiveRangeTableView.h"
#import "TradeDetailTableView.h"

#define kBtnTag 1000
@interface HYTimeLineView()<HYTimeLineAboveViewDelegate>

@property(nonatomic,strong) HYTimeLineAboveView *aboveView;

@property(nonatomic,strong) HYTimeLineBelowView *belowView;

@property(nonatomic,strong) UIView *timeLineContainerView;

@property(nonatomic,strong) NSArray *timeLineModels;

@property(nonatomic,strong) UIView *verticalView;

@property (nonatomic,weak)FiveRangeTableView *fiveRangeView;

@property (nonatomic,weak)TradeDetailTableView *tradeDetailView;

//水平线
@property(nonatomic,strong) UIView *horizontalView;

@property(nonatomic,strong) HYTimeLineLongPressProfileView *timeLineLongPressProfileView;

@property(nonatomic,strong) HYBrokenLineLongPressProfileView *brokenLineLongPressProfileView;

@end

#define WEAKSELF(weakSelf)  __weak __typeof(&*self)weakSelf = self;
@implementation HYTimeLineView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.aboveViewRatio = 0.7;
        self.belowView.backgroundColor = [UIColor backgroundColor];
    }
    return self;
}


#pragma mark set&get方法
#pragma mark aboveView的get方法
-(HYTimeLineAboveView *)aboveView
{
    if (!_aboveView) {
        _aboveView = [HYTimeLineAboveView new];
        _aboveView.delegate = self;
        [self.timeLineContainerView addSubview:_aboveView];
        [_aboveView mas_makeConstraints:^(MASConstraintMaker *make) {
            //make.top.left.right.equalTo(self.timeLineContainerView);
            make.left.equalTo(self.timeLineContainerView).offset(10);
            make.top.equalTo(self.timeLineContainerView);
            make.right.equalTo(self.timeLineContainerView).offset(-110).priorityMedium();
            make.height.equalTo(self.timeLineContainerView).multipliedBy(self.aboveViewRatio);
        }];
    }
    return _aboveView;
}



#pragma mark belowView的get方法
-(HYTimeLineBelowView *)belowView
{
    if (!_belowView) {
        _belowView = [HYTimeLineBelowView new];
        [self.timeLineContainerView addSubview:_belowView];
        [_belowView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.aboveView.mas_bottom);
           // make.left.right.equalTo(self.timeLineContainerView);
            make.left.equalTo(self.timeLineContainerView).offset(10);
            make.right.equalTo(self.aboveView);
            make.height.equalTo(self.timeLineContainerView).multipliedBy(1-self.aboveViewRatio);
        }];
    }
    return _belowView;
}

#pragma mark timeLineContainerView的get方法
-(UIView *)timeLineContainerView
{
    if (!_timeLineContainerView) {
        _timeLineContainerView = [UIView new];
        [self addAllEvent];
        [self addSubview:_timeLineContainerView];
        [_timeLineContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.left.right.equalTo(self);
            make.height.equalTo(self);
        }];
    }
    return _timeLineContainerView;
}

#pragma mark timeLineLongPressProfileView的get方法
-(HYTimeLineLongPressProfileView *)timeLineLongPressProfileView
{
    if (!_timeLineLongPressProfileView) {
        _timeLineLongPressProfileView = [HYTimeLineLongPressProfileView timeLineLongPressProfileView];
        [self addSubview:_timeLineLongPressProfileView];
        [_timeLineLongPressProfileView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_top);
            make.left.right.equalTo(self);
            make.height.equalTo(@(HYStockChartProfileViewHeight));
        }];
    }
    return _timeLineLongPressProfileView;
}

#pragma mark brokenLineLongPressProfileView的get方法
-(HYBrokenLineLongPressProfileView *)brokenLineLongPressProfileView
{
    if (!_brokenLineLongPressProfileView) {
        _brokenLineLongPressProfileView = [HYBrokenLineLongPressProfileView brokenLineLongPressProfileView];
        [self addSubview:_brokenLineLongPressProfileView];
        [_brokenLineLongPressProfileView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_top);
            make.left.right.equalTo(self);
            make.height.equalTo(@(HYStockChartProfileViewHeight));
        }];
    }
    return _brokenLineLongPressProfileView;
}

#pragma mark - 模型设置方法
#pragma mark aboveViewRatio设置方法
-(void)setAboveViewRatio:(CGFloat)aboveViewRatio
{
    _aboveViewRatio = aboveViewRatio;
    [_aboveView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(self).multipliedBy(_aboveViewRatio);
    }];
    [_belowView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(self).multipliedBy(1-_aboveViewRatio);
    }];
}

#pragma mark timeLineModels的设置方法
-(void)setTimeLineGroupModel:(HYTimeLineGroupModel *)timeLineGroupModel
{
    _timeLineGroupModel = timeLineGroupModel;
    if (timeLineGroupModel) {
        self.timeLineModels = timeLineGroupModel.timeModels;
        self.aboveView.groupModel = timeLineGroupModel;
        self.belowView.timeLineModels = self.timeLineModels;
        [self.aboveView drawAboveView];
    }
}

-(void)setCenterViewType:(HYStockChartCenterViewType)centerViewType
{
    _centerViewType = centerViewType;
    if (self.centerViewType == HYStockChartCenterViewTypeTimeLine)
    {
        [self.aboveView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.timeLineContainerView).offset(-110);
        }];
        
        FiveRangeTableView *fiveRangeView = [[FiveRangeTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [self.timeLineContainerView insertSubview:fiveRangeView atIndex:0];
        WEAKSELF(weakSelf);
        [fiveRangeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(weakSelf.timeLineContainerView).offset(-20);
            make.left.equalTo(weakSelf.aboveView.mas_right).offset(10);
            make.width.mas_equalTo(@100);
            make.top.equalTo(weakSelf.aboveView);
        }];
        
        self.fiveRangeView = fiveRangeView;
        
        TradeDetailTableView *tradeDetailView = [[TradeDetailTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [self.timeLineContainerView insertSubview:tradeDetailView atIndex:0];
        [tradeDetailView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(weakSelf.fiveRangeView);
            make.left.equalTo(weakSelf.fiveRangeView.mas_right);
            make.width.equalTo(weakSelf.fiveRangeView);
            make.centerY.equalTo(weakSelf.fiveRangeView);
        }];
        tradeDetailView.backgroundColor = [UIColor yellowColor];
        self.tradeDetailView = tradeDetailView;
        
        
        
        UIButton *fiveRangeBtn = [[UIButton alloc] init];
        [fiveRangeBtn setTitle:@"五档" forState:UIControlStateNormal];
        fiveRangeBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [fiveRangeBtn setTitleColor:[UIColor whiteColor153] forState:UIControlStateNormal];
        fiveRangeBtn.tag = kBtnTag + 1;
        [fiveRangeBtn addTarget:self action:@selector(scrollTradeContentClick:) forControlEvents:UIControlEventTouchUpInside];
        fiveRangeBtn.backgroundColor = [UIColor grayColor];
        [self.timeLineContainerView addSubview:fiveRangeBtn];
        [fiveRangeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(40, 16));
            make.top.equalTo(tradeDetailView.mas_bottom);
            make.left.equalTo(weakSelf.fiveRangeView).offset(5);
        }];
        
        UIButton *tradeDetailBtn = [[UIButton alloc] init];
        [tradeDetailBtn setTitle:@"明细" forState:UIControlStateNormal];
        [tradeDetailBtn setTitleColor:[UIColor whiteColor153] forState:UIControlStateNormal];
        tradeDetailBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        tradeDetailBtn.tag = kBtnTag + 2;
        tradeDetailBtn.backgroundColor = [UIColor grayColor];
        //[fiveRangeBtn setba]
        [tradeDetailBtn addTarget:self action:@selector(scrollTradeContentClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.timeLineContainerView addSubview:tradeDetailBtn];
        [tradeDetailBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(40, 16));
            make.top.equalTo(tradeDetailView.mas_bottom);
            make.left.equalTo(fiveRangeBtn.mas_right);
        }];

    }
    else
    {
        [self.aboveView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.timeLineContainerView).offset(-10);
        }];
    }
    self.aboveView.centerViewType = centerViewType;
    self.belowView.centerViewType = centerViewType;
}


- (void)scrollTradeContentClick:(UIButton *)sender
{
    NSInteger currentPosition = sender.tag - kBtnTag - 1;
    [UIView animateWithDuration:0.25 animations:^{
        self.tradeDetailView.transform = CGAffineTransformMakeTranslation(-100 * currentPosition, 0);
        self.fiveRangeView.transform = CGAffineTransformMakeTranslation(-100 * currentPosition, 0);
    }];
    
}

#pragma mark - 私有方法
-(void)addAllEvent
{
    //UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(event_longPressMethod:)];
    //[self.timeLineContainerView addGestureRecognizer:longPress];
}

#pragma mark - 公共方法
#pragma mark 重绘
-(void)reDraw
{
    [self.aboveView drawAboveView];
}

#pragma mark - Event执行方法
#pragma mark 长按执行方法
-(void)event_longPressMethod:(UILongPressGestureRecognizer *)longPress
{
    CGPoint pressPosition = [longPress locationInView:self.aboveView];
    if (UIGestureRecognizerStateBegan == longPress.state || UIGestureRecognizerStateChanged == longPress.state) {
        if (!self.verticalView) {
            
            
            //显示竖线
            self.verticalView = [UIView new];
            self.verticalView.clipsToBounds = YES;
            [self.timeLineContainerView addSubview:self.verticalView];
            self.verticalView.backgroundColor = [UIColor longPressLineColor];
            [self.verticalView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self);
                make.width.equalTo(@(HYStockChartLongPressVerticalViewWidth));
                make.height.equalTo(self.mas_height);
                make.left.equalTo(@-10);
            }];
        }
        
        if (!self.horizontalView) {
            //显示竖线
            self.horizontalView = [UIView new];
            self.horizontalView.clipsToBounds = YES;
            [self.timeLineContainerView addSubview:self.horizontalView];
            self.horizontalView.backgroundColor = [UIColor longPressLineColor];
            [self.horizontalView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self);
                make.height.equalTo(@(HYStockChartLongPressVerticalViewWidth));
                make.width.equalTo(self.mas_width);
                make.top.equalTo(@-10);
            }];
        }
        //        //改变竖线的位置
        CGPoint xPosition = [self.aboveView getRightXPositionWithOriginXPosition:pressPosition.x];
        [self.horizontalView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@(xPosition.y));
        }];
        [self.verticalView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(xPosition.x + 10));
        }];
        [self.verticalView layoutIfNeeded];
        [self.horizontalView layoutIfNeeded];
        self.verticalView.hidden = NO;
        self.horizontalView.hidden = NO;
    }else{
        
        [[NSNotificationCenter defaultCenter] postNotificationName:CanAcceptTouchNotificationName object:@"0"];
        if (self.verticalView) {
            self.verticalView.hidden = YES;
        }
        if (self.horizontalView) {
            self.horizontalView.hidden = YES;
        }
        
        
        self.timeLineLongPressProfileView.hidden = YES;
        self.brokenLineLongPressProfileView.hidden = YES;
    }
}
/*
-(void)event_longPressMethod:(UILongPressGestureRecognizer *)longPress
{
    CGPoint pressPosition = [longPress locationInView:self.aboveView];
    if (UIGestureRecognizerStateBegan == longPress.state || UIGestureRecognizerStateChanged == longPress.state) {
        if (!self.verticalView) {
            //显示竖线
            self.verticalView = [UIView new];
            self.verticalView.clipsToBounds = YES;
            [self.timeLineContainerView addSubview:self.verticalView];
            self.verticalView.backgroundColor = [UIColor longPressLineColor];
            [self.verticalView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self);
                make.width.equalTo(@(HYStockChartLongPressVerticalViewWidth));
                make.height.equalTo(self.mas_height);
                make.left.equalTo(@-10);
            }];
        }
        
        if (!self.horizontalView) {
            //显示竖线
            self.horizontalView = [UIView new];
            self.horizontalView.clipsToBounds = YES;
            [self.timeLineContainerView addSubview:self.horizontalView];
            self.horizontalView.backgroundColor = [UIColor longPressLineColor];
            [self.horizontalView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self);
                make.height.equalTo(@(HYStockChartLongPressVerticalViewWidth));
                make.width.equalTo(self.mas_width);
                make.top.equalTo(@-10);
            }];
        }
//        //改变竖线的位置
        CGPoint xPosition = [self.aboveView getRightXPositionWithOriginXPosition:pressPosition.x];
        [self.horizontalView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@(xPosition.y));
        }];
        [self.verticalView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(xPosition.x + 10));
        }];
        [self.verticalView layoutIfNeeded];
        [self.horizontalView layoutIfNeeded];
        self.verticalView.hidden = NO;
        self.horizontalView.hidden = NO;
    }else{
        if (self.verticalView) {
            self.verticalView.hidden = YES;
        }
        if (self.horizontalView) {
            self.horizontalView.hidden = YES;
        }

        
        self.timeLineLongPressProfileView.hidden = YES;
        self.brokenLineLongPressProfileView.hidden = YES;
    }
}*/

#pragma mark - HYTimeLineAboveViewDelegate代理方法
//绘制线面的成交量图
-(void)timeLineAboveView:(UIView *)timeLineAboveView positionModels:(NSArray *)positionModels colorModels:(NSArray *)colorModels
{
    NSMutableArray *xPositionArr = [NSMutableArray array];
    for (HYTimeLineAbovePositionModel *positionModel in positionModels) {
        [xPositionArr addObject:[NSNumber numberWithFloat:positionModel.currentPoint.x]];
    }
    self.belowView.xPositionArray = xPositionArr;
    self.belowView.colorArray = colorModels;
    [self.belowView drawBelowView];
}

-(void)timeLineAboveViewLongPressTimeLineModel:(HYTimeLineModel *)timeLineModel
{
    if (self.frame.size.width < 450)
    {
        return;
    }
    if (self.centerViewType == HYStockChartCenterViewTypeTimeLine ) {
        self.timeLineLongPressProfileView.timeLineModel = timeLineModel;
        self.timeLineLongPressProfileView.hidden = NO;
    }else
    {
        self.brokenLineLongPressProfileView.timeLineModel = timeLineModel;
        self.brokenLineLongPressProfileView.hidden = NO;
    }
}

@end
