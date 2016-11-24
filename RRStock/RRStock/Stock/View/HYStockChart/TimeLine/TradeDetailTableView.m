//
//  TradeDetailTableView.m
//  RRCP
//
//  Created by 人人操盘 on 16/8/23.
//  Copyright © 2016年 renrencaopan. All rights reserved.
//

#import "TradeDetailTableView.h"
#import "TradeDetailCell.h"

@interface TradeDetailTableView ()<UITableViewDelegate,UITableViewDataSource>

@end

#define TradeDetailCellIdentifer @"TradeDetailCellIdentifer"
@implementation TradeDetailTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        
        self.dataSource = self;
        self.delegate = self;
        
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self registerClass:[TradeDetailCell class] forCellReuseIdentifier:TradeDetailCellIdentifer];
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 5;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TradeDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:TradeDetailCellIdentifer];
    return cell;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return self.frame.size.height / 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
   
    return 0.001f;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 0.01f;
}

@end
