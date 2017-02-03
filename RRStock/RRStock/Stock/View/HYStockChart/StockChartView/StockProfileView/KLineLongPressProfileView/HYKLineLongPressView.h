//
//  HYKLineLongPressView.h
//  RRStock
//
//  Created by 曾文亮 on 16/12/17.
//  Copyright © 2016年 liang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HYKLineModel;
@interface HYKLineLongPressView : UIView

@property(nonatomic,strong) HYKLineModel *kLineModel;

/**
 *  工厂方法加载一个HYKLineLongPressProfileViewxib
 */
+(instancetype)kLineLongPressProfileView;

@end
