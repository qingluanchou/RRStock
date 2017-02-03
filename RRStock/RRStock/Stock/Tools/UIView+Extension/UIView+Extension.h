//
//  UIView+Extension.h
//  RRCP
//
//  Created by zwl on 15/11/2.
//  Copyright © 2015年 qinxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)

/**
 *  在分类中使用@property只会生成get/set方法的声明，不会实现
 */

@property (nonatomic, assign) CGFloat centerX;

@property (nonatomic, assign) CGFloat centerY;

@property (nonatomic, assign) CGFloat x;

@property (nonatomic, assign) CGFloat y;

@property (nonatomic, assign) CGFloat width;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign) CGSize size;

@end
