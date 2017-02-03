//
//  HYTimeLineLongPressView.h
//  RRStock
//
//  Created by 曾文亮 on 16/12/17.
//  Copyright © 2016年 liang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HYTimeLineModel;
@interface HYBrokenLineLongPressView : UIView

+(instancetype)brokenLineLongPressProfileView;

@property(nonatomic,strong) HYTimeLineModel *timeLineModel;

@end
