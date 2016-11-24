//
//  UIButton+CZ.h
//  RRCP
//
//  Created by 人人操盘 on 15/11/23.
//  Copyright © 2015年 renrencaopan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (CZ)

+ (UIButton *)setCustomButton:(NSString *)title backGroundColor:(UIColor *)backGroundColor backGroundImage:(UIImage *)image textColor:(UIColor *)textColor textFont:(CGFloat)font;

+ (UIButton *)setIcon:(UIImage *)image setSelectedIcon:(UIImage *)selectedImage sethighLightIcon:(UIImage *)highLightImage;

@end
