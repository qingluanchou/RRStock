//
//  YYTimeLineMaskView.h
//  YYStock  ( https://github.com/yate1996 )
//
//  Created by yate1996 on 16/10/10.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "YYStockTimeLineProtocol.h"
#import "HYTimeLineModel.h"
#import "HYTimeLineAboveView.h"

@interface YYTimeLineMaskView : UIView

//当前长按选中的model
@property (nonatomic, strong) HYTimeLineModel *selectedModel;

//当前长按选中的位置model
@property (nonatomic, assign) CGPoint selectedPoint;

//当前的滑动scrollview
@property (nonatomic, strong) HYTimeLineAboveView *timeLineView;

@end
