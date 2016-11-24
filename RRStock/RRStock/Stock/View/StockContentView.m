//
//  StockContentView.m
//  RRCP
//
//  Created by 人人操盘 on 16/8/23.
//  Copyright © 2016年 renrencaopan. All rights reserved.
//

#import "StockContentView.h"
#import "StockChartTitleView.h"
#import "UIColor+Utils.h"

#define tabTitleViewHeight 44
@interface StockContentView ()<UIScrollViewDelegate>

@property (nonatomic, strong) StockChartTitleView *tabTitleView;

@property (nonatomic, strong) UIScrollView *tabContentView;

@end

@implementation StockContentView

-(instancetype)initWithTabConfigArray:(NSArray *)tabConfigArray {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self.frame = CGRectMake(0, 0, ScreenW, ScreenH);
            
        NSArray *titleArray = @[@"观点",@"新闻",@"公告",@"研报",@"资料",@"交易"];
        _tabTitleView = [[StockChartTitleView alloc] initWithTitleArray:titleArray];
        
        __weak typeof(self) weakSelf = self;
        _tabTitleView.titleClickBlock = ^(NSInteger row){
            if (weakSelf.tabContentView) {
                weakSelf.tabContentView.contentOffset = CGPointMake(ScreenW*row, 0);
            }
        };
        
        [self addSubview:_tabTitleView];
        
        
        
        _tabContentView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, tabTitleViewHeight, ScreenW, CGRectGetHeight(self.frame)- tabTitleViewHeight)];
        _tabContentView.contentSize = CGSizeMake(CGRectGetWidth(_tabContentView.frame)* titleArray.count, CGRectGetHeight(_tabContentView.frame));
        _tabContentView.pagingEnabled = YES;
        _tabContentView.bounces = NO;
        _tabContentView.showsHorizontalScrollIndicator = NO;
        _tabContentView.delegate = self;
        [self addSubview:_tabContentView];
        for (int i=0; i<tabConfigArray.count; i++)
        {
            UIView *currentView = tabConfigArray[i];
            currentView.frame = CGRectMake(i * ScreenW, 0, ScreenW, ScreenH - 44);
            currentView.backgroundColor = [UIColor randomColor];
            [_tabContentView addSubview:currentView];
        }
    }
    return self;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat offsetX = scrollView.contentOffset.x;
    NSInteger pageNum = offsetX/ScreenW + 0.5;
    [_tabTitleView setItemSelected:pageNum];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat page = scrollView.contentOffset.x / ScreenW;
    [_tabTitleView setScrollDistance:page];
    //self.lineView.transform = CGAffineTransformMakeTranslation(page * ScreenW * 0.5, 0);
    
}

@end
