//
//  UIColor+Utils.h
//  RRCP
//
//  Created by 人人操盘 on 16/3/21.
//  Copyright © 2016年 renrencaopan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Utils)
/**
 将16进制颜色值如#000000转换成UIColor
 **/
+ (UIColor*)colorWithHexString:(NSString *)stringToConvert;
+ (UIColor*)colorWithHexString:(NSString *)stringToConvert alpha:(float)_alpha;

+ (UIColor *)colorWithLightBlue;

+ (UIColor *)colorWithLightYellow;

+ (UIColor *)colorWithWhite51;

+ (UIColor *)colorWithWhite102;

+ (UIColor *)colorWithWhite242;

+ (UIColor *)colorWithWhite245;

+ (UIColor *)colorWithWhite196;

+ (UIColor *)colorWithWhite153;

+ (UIColor *)colorWithNavBarColor;

+ (UIColor *)colorWithWhite226;

+ (UIColor *)ColorWithWhite204;

+ (UIColor *)colorWithRateRed;

+ (UIColor *)ColorWithLightGreen;

+ (UIColor *)colorWithLightHighBlue;

//随机颜色
+ (UIColor *)randomColor;

+ (UIColor *)rgbaColor:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;

+ (BOOL) isTheSameColor2:(UIColor*)color1 anotherColor:(UIColor*)color2;
@end
