//
//  YYTimeLineBelowMaskView.h
//  RRStock
//
//  Created by 曾文亮 on 16/12/17.
//  Copyright © 2016年 liang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYTimeLineModel.h"
#import "HYTimeLineAboveView.h"

@interface YYTimeLineBelowMaskView : UIView

//当前长按选中的model
@property (nonatomic, strong) HYTimeLineModel *selectedModel;

//当前长按选中的位置model
@property (nonatomic, assign) CGPoint selectedPoint;

//当前的滑动scrollview
@property (nonatomic, strong) HYTimeLineAboveView *timeLineView;

@end
