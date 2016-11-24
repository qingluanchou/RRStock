//
//  UIColor+Utils.m
//  RRCP
//
//  Created by 人人操盘 on 16/3/21.
//  Copyright © 2016年 renrencaopan. All rights reserved.
//

#import "UIColor+Utils.h"

@implementation UIColor (Utils)
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor clearColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor clearColor];
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

+ (UIColor*)colorWithHexString:(NSString *)stringToConvert alpha:(float)_alpha
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor clearColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor clearColor];
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:_alpha];

}

+ (UIColor *)colorWithLightBlue
{
    return [UIColor colorWithRed:49/255.0 green:146/255.0 blue:187/255.0 alpha:1.0];
}

+ (UIColor *)colorWithLightHighBlue
{
    
    return [UIColor colorWithRed:231/255.0 green:241/255.0 blue:244/255.0 alpha:1.0];
}


+ (UIColor *)colorWithWhite51
{
    
    return [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
}


+ (UIColor *)colorWithWhite102
{

   return [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
}

+ (UIColor *)colorWithWhite245
{
    
    return [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
}

+ (UIColor *)colorWithWhite242
{
    
    return [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
}

+ (UIColor *)colorWithWhite196
{
    
    return [UIColor colorWithRed:196/255.0 green:196/255.0 blue:196/255.0 alpha:1.0];
}

+ (UIColor *)colorWithWhite153
{
    
    return [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
}

+ (UIColor *)colorWithWhite226
{
    
    return [UIColor colorWithRed:226/255.0 green:226/255.0 blue:226/255.0 alpha:1.0];
}

+ (UIColor *)colorWithLightYellow
{

   return [UIColor colorWithRed:251/255.0 green:160/255.0 blue:1/255.0 alpha:1.0];
}


+ (UIColor *)colorWithNavBarColor
{
    
    return [UIColor colorWithRed:28/255.0 green:48/255.0 blue:66/255.0 alpha:0.9];
}

+ (UIColor *)colorWithRateRed
{
    return  [UIColor colorWithRed:255/255.0 green:71/255.0 blue:71/255.0 alpha:1.0];
}

+ (UIColor *)ColorWithLightGreen
{
   return  [UIColor colorWithRed:146/255.0 green:209/255.0 blue:78/255.0 alpha:1.0];
}

+ (UIColor *)ColorWithWhite204
{
    return  [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0];
}

+ (BOOL) isTheSameColor2:(UIColor*)color1 anotherColor:(UIColor*)color2
{
    if (CGColorEqualToColor(color1.CGColor, color2.CGColor)) {
        return YES;
    }
    else {
        return NO;
    }
}

+ (UIColor *)randomColor{
    
    // return [UIColor colorWithRed:[self randomValue] green:[self randomValue] blue:[self randomValue] alpha:1.0];
    return [UIColor colorWithRed:arc4random() % 256 / 256.0 green:arc4random() % 256 / 256.0 blue:arc4random() % 256 / 256.0 alpha:1.0];
}

+ (UIColor *)rgbaColor:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha
{
    
    return [UIColor colorWithRed:red / 256.0 green:green / 256.0 blue:blue / 256.0 alpha:alpha/1.0];
}

+ (CGFloat)randomValue {
    
    return arc4random() % 256 / 256.0;
    
}



@end
