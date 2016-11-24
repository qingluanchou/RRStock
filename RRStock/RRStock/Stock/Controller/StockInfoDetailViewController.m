//
//  StockInfoDetailViewController.m
//  RRCP
//
//  Created by 人人操盘 on 16/8/23.
//  Copyright © 2016年 renrencaopan. All rights reserved.
//

#import "StockInfoDetailViewController.h"
#import "StockDataController.h"
#import "StockNewsController.h"
#import "StockOpinionController.h"
#import "StockTradeController.h"
#import "StockResearchReportController.h"
#import "StockNoticeController.h"
#import "RecognizeSimultaneousTableView.h"
#import "StockDetailHeaderView.h"
#import "StockContentView.h"
#import "HYStockChartViewController.h"
#import "UIColor+Utils.h"

@interface StockInfoDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    BOOL _isTopIsCanNotMoveTabViewPre;
    BOOL _isTopIsCanNotMoveTabView;
    BOOL _canScroll;
    
    BOOL _canEnter;

}

@property (nonatomic,strong)NSMutableArray *contentViewList;

@property (nonatomic,weak)RecognizeSimultaneousTableView *tableView;

@property (nonatomic,weak)StockDetailHeaderView *stockProductHeaderView;

@end

@implementation StockInfoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    //添加控制器
    [self addStockContentVC];
    
    [self initUI];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"narrow"] style:UIBarButtonItemStylePlain target:self action:@selector(cancelClick)];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(canEnterDetail:) name:CanAcceptTouchNotificationName object:nil];
    
    
}

- (void)canEnterDetail:(NSNotification *)notification
{
    if ([notification.object integerValue] == 1) {
        _canEnter = 1;
        self.tableView.scrollEnabled = NO;
    }
    else
    {
       _canEnter = 0;
        self.tableView.scrollEnabled = YES;
    }
    
}

- (void)addStockContentVC
{
    
    //观点
    StockOpinionController *opinionVC = [[StockOpinionController alloc] init];
    [self addChildViewController:opinionVC];
    [self.contentViewList addObject:opinionVC.view];
    
    //新闻
    StockNewsController *newsVC = [[StockNewsController alloc] init];
    [self addChildViewController:newsVC];
    [self.contentViewList addObject:newsVC.view];
    
    //公告
    StockNoticeController *noticeVC = [[StockNoticeController alloc] init];
    [self addChildViewController:noticeVC];
    [self.contentViewList addObject:noticeVC.view];
    
    //研报
    StockResearchReportController *researchReportVC = [[StockResearchReportController alloc] init];
    [self addChildViewController:researchReportVC];
    [self.contentViewList addObject:researchReportVC.view];
    
    //资料
    StockDataController *dataVC = [[StockDataController alloc] init];
    [self addChildViewController:dataVC];
    [self.contentViewList addObject:dataVC.view];
    
    //交易
    StockTradeController *tradeVC = [[StockTradeController alloc] init];
    [self addChildViewController:tradeVC];
    [self.contentViewList addObject:tradeVC.view];


}

- (void)cancelClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
}



-(void)initUI{
    
    self.navigationItem.title = @"跟投乐产品详情";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    RecognizeSimultaneousTableView *tableView = [[RecognizeSimultaneousTableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)) style:UITableViewStyleGrouped];
    tableView.backgroundColor = [UIColor colorWithWhite242];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.sectionFooterHeight = 0.0;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    
    
    
    StockDetailHeaderView *headerView = [[StockDetailHeaderView alloc] init];
    headerView.frame = CGRectMake(0, 0, ScreenW, 500);
    WEAKSELF(weakSelf);
    headerView.headerBlock = ^(){
        
        if(_canEnter == 1)
        {
            return ;
        }
        
        HYStockChartViewController *stockChartVC = [HYStockChartViewController new];
        stockChartVC.isFullScreen = YES;
        [self presentViewController:stockChartVC animated:NO completion:nil];
    
    };
    _tableView.tableHeaderView = headerView;
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(acceptMsg:) name:kLeaveTopNotificationName object:nil];
}

-(void)acceptMsg : (NSNotification *)notification{
    //NSLog(@"%@",notification);
    NSDictionary *userInfo = notification.userInfo;
    NSString *canScroll = userInfo[@"canScroll"];
    if ([canScroll isEqualToString:@"1"]) {
        _canScroll = YES;
    }
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //CGFloat height = 0.;
    // height = CGRectGetHeight(self.view.frame);
    
    return ScreenH;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    StockContentView *tabView = [[StockContentView alloc] initWithTabConfigArray:self.contentViewList];
    
    [cell.contentView addSubview:tabView];
    return cell;
    
}




-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //taboffsetY--410
    CGFloat tabOffsetY = [_tableView rectForSection:0].origin.y;
    CGFloat offsetY = scrollView.contentOffset.y;
    _isTopIsCanNotMoveTabViewPre = _isTopIsCanNotMoveTabView;
    if (offsetY>=tabOffsetY) {
        scrollView.contentOffset = CGPointMake(0, tabOffsetY);
        _isTopIsCanNotMoveTabView = YES;
    }else{
        _isTopIsCanNotMoveTabView = NO;
    }
    if (_isTopIsCanNotMoveTabView != _isTopIsCanNotMoveTabViewPre) {
        if (!_isTopIsCanNotMoveTabViewPre && _isTopIsCanNotMoveTabView) {
            //NSLog(@"滑动到顶端");
            [[NSNotificationCenter defaultCenter] postNotificationName:kGoTopNotificationName object:nil userInfo:@{@"canScroll":@"1"}];
            _canScroll = NO;
        }
        if(_isTopIsCanNotMoveTabViewPre && !_isTopIsCanNotMoveTabView){
            //NSLog(@"离开顶端");
            if (!_canScroll) {
                scrollView.contentOffset = CGPointMake(0, tabOffsetY);
            }
        }
    }
}

- (NSMutableArray *)contentViewList
{
    if (_contentViewList == nil)
    {
        _contentViewList = [NSMutableArray array];
    }
    return _contentViewList;

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
