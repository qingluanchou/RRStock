//
//  UIColor+HYStockChartExtension.m
//  jimustock
//
//  Created by jimubox on 15/5/25.
//  Copyright (c) 2015年 jimubox. All rights reserved.
//

#import "UIColor+HYStockChart.h"

@implementation UIColor (HYStockChart)

+ (UIColor *)colorWithRGBHex:(UInt32)hex {
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;
    
    return [UIColor colorWithRed:r / 255.0f
                           green:g / 255.0f
                            blue:b / 255.0f
                           alpha:1.0f];
}

#pragma mark 所有图表的背景颜色
+(UIColor *)backgroundColor
{
    //return [UIColor colorWithRGBHex:0x181c20];
    return [UIColor whiteColor];
}

#pragma mark 辅助背景色
+(UIColor *)assistBackgroundColor
{
    //return [UIColor colorWithRGBHex:0x1d2227];
    return [UIColor whiteColor];
}

#pragma mark 涨的颜色
+(UIColor *)increaseColor
{
    return [UIColor colorWithRed:206/255.0 green:65/255.0 blue:51/255.0 alpha:1.0];
}

#pragma mark 153颜色
+(UIColor *)whiteColor153
{
    return [UIColor colorWithRGBHex:0x999999];
}

#pragma mark 跌的颜色
+(UIColor *)decreaseColor
{
    return [UIColor colorWithRed:37/255.0 green:174/255.0 blue:68/255.0 alpha:1.0];;
}

#pragma mark 主文字颜色
+(UIColor *)mainTextColor
{
    return [UIColor colorWithRGBHex:0xe1e2e6];
}

#pragma mark 辅助文字颜色
+(UIColor *)assistTextColor
{
    return [UIColor colorWithRGBHex:0x565a64];
}

#pragma mark 分时线下面的成交量线的颜色
+(UIColor *)timeLineVolumeLineColor
{
    return [UIColor colorWithRGBHex:0x2d333a];
}

#pragma mark 分时线界面线的颜色
+(UIColor *)timeLineLineColor
{
   // return [UIColor colorWithRGBHex:0x49a5ff];
    return [UIColor colorWithRGBHex:0x1860FE];
}

#pragma mark 长按时线的颜色
+(UIColor *)longPressLineColor
{
    //return [UIColor colorWithRGBHex:0xff5353];
    return [UIColor colorWithRGBHex:0x666666];
}

#pragma mark 边框线的颜色
+(UIColor *)gridLineColor
{
    //return [UIColor colorWithRGBHex:0xff5353];
    return [UIColor colorWithRGBHex:0x999999];
}

#pragma mark ma5的颜色
+(UIColor *)ma5Color
{
    return [UIColor colorWithRGBHex:0xff783c];
}

#pragma mark ma10的颜色
+(UIColor *)ma10Color
{
    return [UIColor colorWithRGBHex:0x49a5ff];
}

#pragma mark ma20颜色
+(UIColor *)ma20Color
{
    return [UIColor colorWithRGBHex:0xffbf43];
}

#pragma mark ma30颜色
+(UIColor *)ma30Color
{
    return [UIColor colorWithRGBHex:0x49a5ff];
}

#pragma mark 分时图渐变色
+(UIColor *)fenShiGradientColor
{
    return [UIColor colorWithRGBHex:0x1860FE];
}
@end
