//
//  StockDetailHeaderView.h
//  RRCP
//
//  Created by 人人操盘 on 16/8/22.
//  Copyright © 2016年 renrencaopan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^StockDetailHeaderBlock)();
@interface StockDetailHeaderView : UIView

@property (nonatomic,copy)StockDetailHeaderBlock  headerBlock;

@end
