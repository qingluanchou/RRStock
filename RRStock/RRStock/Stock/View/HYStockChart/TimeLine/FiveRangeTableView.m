//
//  FiveRangeTableView.m
//  RRCP
//
//  Created by 人人操盘 on 16/8/23.
//  Copyright © 2016年 renrencaopan. All rights reserved.
//

#import "FiveRangeTableView.h"
#import "FiveRangeCell.h"
#import "Masonry.h"

@interface FiveRangeTableView ()<UITableViewDelegate,UITableViewDataSource>

@end

#define FiveRangeCellIdentifer @"FiveRangeCellIdentifer"
@implementation FiveRangeTableView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        
        self.dataSource = self;
        self.delegate = self;
        
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self registerClass:[FiveRangeCell class] forCellReuseIdentifier:FiveRangeCellIdentifer];
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
    FiveRangeCell *cell = [tableView dequeueReusableCellWithIdentifier:FiveRangeCellIdentifer];
    return cell;


}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return (self.frame.size.height - 20)/ 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{

    UIView *sectionView =  [[UIView alloc]init];
    sectionView.backgroundColor = [UIColor whiteColor];
    UIView *lineView =  [[UIView alloc]init];
    [sectionView addSubview:lineView];
    lineView.backgroundColor = [UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1.0];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(sectionView);
        make.centerY.equalTo(sectionView);
        make.left.equalTo(sectionView);
        make.height.mas_equalTo(@0.5);
    }];

    return sectionView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{

    if (section == 0)
    {
        return 20.0f;
    }
    else
    {
        return 0.001f;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

    return 0.01f;
}



@end
